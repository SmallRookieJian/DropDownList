#DropDownList

###功能
下拉列表，最多显示4行。

###使用
	//初始化
	- (DropDownList *)dropDownList {
    	if (!_dropDownList) {
        	_dropDownList = [[DropDownList alloc] init];
        	_dropDownList.delegate = self;
        	_dropDownList.headerName = @"全部";     
    	}
       	return _dropDownList;
	}

	//赋值
	self.dropDownList.arrayTexts = 
	self.arrayClassOfTeacher;

	//折叠
	[self.dropDownList dropDownListFold];

	//点击回调方法
	//#pragma mark - DropDownListDelegate
	- (void)dropDownList:(DropDownList *)dropDownList 
	didSelectRow:(NSInteger)row {
		//your coding
	}




