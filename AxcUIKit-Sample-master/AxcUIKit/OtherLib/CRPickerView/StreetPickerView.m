//
//  StreetPickerView.m
//  PickerViewDemo
//
//  Created by djk on 17/6/26.
//  Copyright © 2017年 ButterJie. All rights reserved.
//

#import "StreetPickerView.h"
#import "Constants.h"
#import "UIView+Common.h"
#import "PickerToolBar.h"

static CGFloat const PickerViewHeight = 240;
static CGFloat const PickerViewLabelWeight = 32;

@interface StreetPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
/** 当前街道数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayStreets;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong, nullable) PickerToolBar *toolbar;

/** 运营商 */
@property (nonatomic, strong,)NSString *streetsStr;
/** 运营商编号*/
@property (nonatomic, assign)NSInteger OperatorCode;

@end

@implementation StreetPickerView

+ (instancetype)selectStreetWithStreetArr:(NSMutableArray *)streetArr back:(SelectStreetBlock)selectStreetBlock{
    StreetPickerView *newPickerView = [[StreetPickerView alloc] init];
    newPickerView.arrayStreets = streetArr;
    newPickerView.selectStreetBlock = selectStreetBlock;
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
    if (self.selectStreetBlock) {
        self.selectStreetBlock(self.streetsStr,self.OperatorCode);
    }
    [self dismiss];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
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
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.arrayStreets.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return PickerViewLabelWeight;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.arrayStreets[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.streetsStr = self.arrayStreets[row];
    self.OperatorCode = row;
    [self.toolbar setTitle:self.streetsStr];
}


@end
