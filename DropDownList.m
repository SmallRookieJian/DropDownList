//
//  DropDownList.m
//  ReleaseDemo
//
//  Created by trq on 16/8/31.
//  Copyright © 2016年 fanyu. All rights reserved.
//

#import "DropDownList.h"
#import "classModel.h"

#define kHeightOfRow 45
#define kHeightOfHeader 45

@interface DropDownList ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) UIImageView *imgViewTriangle;

@property (nonatomic, strong) UIButton *buttonDropDown;

@property (nonatomic, strong) UIView *topLine;

/**
 *  可设置下拉列表的总长度，默认为200
 */
@property (nonatomic, assign) CGFloat heightOfTableView;


@end

@implementation DropDownList

- (id)init {
    
    if (self = [super init]) {
        
        _isFold = YES;
        
//        _heightOfRow = kHeightOfRow;
        _heightOfTableView = 200;
        
//        NSLog(@"这是我想要的数组么？%@",self.arrayTexts);
        
        [self addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(kHeightOfHeader);
            
        }];
        
    }
    return self;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.rowHeight = kHeightOfRow;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    
    return _tableView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isFold) {
        
        return self.arrayTexts.count;
    }
    else {
        
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = UIColorFromRGB(0xe8e8e8);
        [cell addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(-1);
            make.right.left.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        classModel *model = self.arrayTexts[indexPath.row];
        
        UILabel *labelClassName = [[UILabel alloc] init];
        [cell.contentView addSubview:labelClassName];
        
        [labelClassName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.mas_equalTo(0);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
            
        }];
        
        labelClassName.text = model.classname;
        labelClassName.font = [UIFont systemFontOfSize:13];
        labelClassName.textColor = UIColorFromRGB(0x333333);
        
        labelClassName.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return kHeightOfHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    [self.buttonDropDown addSubview:self.imgViewTriangle];
    
    [self.imgViewTriangle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-14);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(10);
        
    }];
    
    [self.buttonDropDown addSubview:self.topLine];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-1);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    return self.buttonDropDown;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选了东西");
    
    classModel *model = self.arrayTexts[indexPath.row];
    self.indexOfCurrentSelect = indexPath.row;
    
    [self.buttonDropDown setTitle:model.classname forState:UIControlStateNormal];
    
    [self btnIsFoldClicked];
    
    self.indexOfCurrentSelect = indexPath.row;
    
    if ([self.delegate respondsToSelector:@selector(dropDownList:didSelectRow:)]) {
        
        [self.delegate dropDownList:self didSelectRow:indexPath.row];
        
    }
    
}

//CGFloat angleValue(CGFloat angle) {
//    return (angle * M_PI) / 180;
//}

- (void)btnIsFoldClicked {
    
    
    self.topLine.hidden = !self.topLine.hidden;
    
    [self.superview bringSubviewToFront:self];
    
    CGFloat heightOfView;
    
    if (!self.isFold) {
        //将折叠
        //顺时针旋转90度
        self.imgViewTriangle.transform = CGAffineTransformMakeRotation((90.0 * M_PI) / 180.0f);
        
        heightOfView = kHeightOfHeader;
        
        self.tableView.layer.borderWidth = 0;
        
    }
    else {
        //将展开
        self.imgViewTriangle.transform = CGAffineTransformMakeRotation((270.0 * M_PI) / 180.0f);
        
        heightOfView = self.heightOfTableView;
        
        self.tableView.layer.borderColor = UIColorFromRGB(0xe8e8e8).CGColor;
        self.tableView.layer.borderWidth = 0.5;
        
    }
    
    
    [UIView beginAnimations:nil context:NULL];
    /* Make the animation 1 seconds long */
    [UIView setAnimationDuration:0.5];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(heightOfView);
        
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(heightOfView);
        
    }];
    
    /* Commit the animation */
    [UIView commitAnimations];
    
    [self.tableView reloadData];
    self.isFold = !self.isFold;
}

- (UIImageView *)imgViewTriangle
{
    if (!_imgViewTriangle) {
        _imgViewTriangle = [[UIImageView alloc] init];
        _imgViewTriangle.image = [UIImage imageNamed:@"ico_duobianxingright"];
        _imgViewTriangle.transform = CGAffineTransformMakeRotation((90.0 * M_PI) / 180.0f);
//        _imgViewTriangle.transform = CGAffineTransformMakeRotation((270.0 * M_PI) / 180.0f);
        
    }
    
    return _imgViewTriangle;
}

- (UIButton *)buttonDropDown {
    
    if (!_buttonDropDown) {
        
        _buttonDropDown = [UIButton buttonWithType:UIButtonTypeCustom];
        //    button.frame = CGRectZero;
        _buttonDropDown.backgroundColor = [UIColor whiteColor];
        
        self.indexOfCurrentSelect = -1;
        
        [_buttonDropDown setTitle:self.headerName forState:UIControlStateNormal];
        
        [_buttonDropDown setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        _buttonDropDown.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonDropDown.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        
        [_buttonDropDown addTarget:self action:@selector(btnIsFoldClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _buttonDropDown;
}

- (UIView *)topLine {
    
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = UIColorFromRGB(0xe1ba83);
        _topLine.hidden = YES;
    }
    return _topLine;
}

- (void)setArrayTexts:(NSArray *)arrayTexts {
    
    
    _arrayTexts = arrayTexts;
    
    if ([self.headerName isEqualToString:@"全部班级"]) {
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.arrayTexts];
        
        classModel *model = [[classModel alloc] init];
        
        model.classname = @"全部班级";
        
        [array addObject:model];
        
        _arrayTexts = array;
        
    }
    
    NSInteger num = 0;
    if (_arrayTexts.count < 4) {
        num= _arrayTexts.count + 1;
    }
    else {
        num = 4;
    }
    
    self.heightOfTableView = num * kHeightOfRow + kHeightOfHeader;
    
    [self.tableView reloadData];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dropDownListFold {
    [self btnIsFoldClicked];
}

@end
