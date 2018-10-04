//
//  StreetPickerView.m
//  PickerViewDemo
//
//  Created by djk on 17/6/26.
//  Copyright © 2017年 ButterJie. All rights reserved.
//

#import "PrivencePickerView.h"
#import "Constants.h"
#import "UIView+Common.h"
#import "PickerToolBar.h"
#import "CRPrivenceModel.h"
static CGFloat const PickerViewHeight = 240;
static CGFloat const PickerViewLabelWeight = 32;

@interface PrivencePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
/**省份数据源*/
@property (nonatomic, strong, nullable) NSMutableArray *privences;
/**保存选中的省对象*/
@property (nonatomic, assign) CRPrivenceModel *tmpPro;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong, nullable) PickerToolBar *toolbar;



/** 当前选中的省市 */
@property (nonatomic, strong)NSString *streetsStr;
/** 当前选中的省编号 */
@property (nonatomic, assign)long PrivenceAreaCode;
/** 当前选中的市编号 */
@property (nonatomic, copy)NSString *CityAreaCode;

@end

@implementation PrivencePickerView

+ (instancetype)selectPrivenceWithPrivenceArr:(NSMutableArray *)privenceArr back:(SelectPrivenceBlock)selectPrivenceBlock{
    PrivencePickerView *newPickerView = [[PrivencePickerView alloc] init];
    newPickerView.privences = privenceArr;
    newPickerView.selectPrivenceBlock = selectPrivenceBlock;
    return newPickerView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self customUI];
    }
    return self;
}

- (void)customUI {
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = RGBA(0, 0, 0, 102.0/255);
    [self.layer setOpaque:0.0];
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.lineView];
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), 0.5)];
        [_lineView setBackgroundColor:RGB(205, 205, 205)];
    }
    return _lineView;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        CGFloat pickerW = screenWidth();
        CGFloat pickerH = PickerViewHeight - 44;
        CGFloat pickerX = 0;
        CGFloat pickerY = screenHeight() + 44;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        [_pickerView setDataSource:self];
        [_pickerView setDelegate:self];
    }
    return _pickerView;
}

- (PickerToolBar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[PickerToolBar alloc]initWithTitle:@"不限"
                                     cancelButtonTitle:@"取消"
                                         okButtonTitle:@"确定"
                                             addTarget:self
                                          cancelAction:@selector(dismiss)
                                              okAction:@selector(selectedOk)];
        _toolbar.x = 0;
        _toolbar.y = screenHeight();
    }
    return _toolbar;
}

- (void)selectedOk {
    if (self.selectPrivenceBlock) {
        self.selectPrivenceBlock(self.streetsStr,self.PrivenceAreaCode,self.CityAreaCode);
    }
    [self dismiss];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
//    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
    
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y -= PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:1];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss {
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y += PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y += PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:0];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        //省的个数
        return self.privences.count;
    }else{
        //取出对应省内的城市个数
        return  self.tmpPro.Children.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return PickerViewLabelWeight;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        //取出此时对应的省
        CRPrivenceModel *p = self.privences[row];
        //取出省名
        return p.AreaName;
    }else{
        //从保存的临时省对象里面取出来对应市的数据
        return self.tmpPro.Children[row][@"AreaName"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        //取出此时pickerView展示出的省的索引
        NSInteger indexP = [pickerView selectedRowInComponent:0];
        //取出省的对象并保存一下
        self.tmpPro = self.privences[indexP];
        //选中第0列刷新第1列数据
        [self.pickerView reloadComponent:1];
        //让pickerView选中第1列的第0行
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
    }
    //获取当前pickerView上的第1列的索引
    NSInteger selCityIndex = [self.pickerView selectedRowInComponent:1];
    //从保存的临时省对象里面取出来对应市的数据
    self.streetsStr = [NSString stringWithFormat:@"%@      %@",self.tmpPro.AreaName,self.tmpPro.Children[selCityIndex][@"AreaName"]];
    self.PrivenceAreaCode = self.tmpPro.AreaCode;
    self.CityAreaCode =  [NSString stringWithFormat:@"%@",self.tmpPro.Children[selCityIndex][@"AreaCode"]];
    [self.toolbar setTitle:self.streetsStr];
}


@end
