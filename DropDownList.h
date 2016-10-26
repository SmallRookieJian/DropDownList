//
//  DropDownList.h
//  ReleaseDemo
//
//  Created by trq on 16/8/31.
//  Copyright © 2016年 fanyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownList;
@protocol DropDownListDelegate <NSObject>

- (void)dropDownList:(DropDownList *)dropDownList didSelectRow:(NSInteger)row;

@end

@interface DropDownList : UIView

@property (nonatomic, assign) id<DropDownListDelegate>delegate;
/**
 *  下拉列表的折叠情况，默认是YES，表示折叠
 */
@property (nonatomic, assign) BOOL isFold;

/**
 *  下拉列表中显示的内容，区头，默认显示数组中的第一个值
 */
@property (nonatomic, strong) NSArray *arrayTexts;

@property (nonatomic, strong) NSString *headerName;

/**
 *  当前下拉列表中选择的索引，，默认值为-1(表示选择的是区头）
 */
@property (nonatomic, assign) NSInteger indexOfCurrentSelect;

/**
 *  可设置下拉列表的行高，默认为30
 */
//@property (nonatomic, assign) CGFloat heightOfRow;



/**
 *  是下拉列表折叠
 */
- (void)dropDownListFold;
@end
