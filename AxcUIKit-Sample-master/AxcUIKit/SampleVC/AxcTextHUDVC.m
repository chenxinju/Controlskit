//
//  AxcTextHUDVC.m
//  AxcUIKit
//
//  纯文字加载提示工具（AxcUI_TextHUD）演示
//
//  Created by Axc on 2017/6/9.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import "AxcTextHUDVC.h"

@interface AxcTextHUDVC ()

// 用于演示「在指定View中展示」的容器
@property (nonatomic, strong) UIView *targetBox;
// 实例化演示创建的HUD
@property (nonatomic, strong) AxcUI_TextHUD *customHUD;

// 展示效果配置
@property (nonatomic, strong) UILabel *appearSegmentedLabel;
@property (nonatomic, strong) UISegmentedControl *appearSegmented;
@property (nonatomic, strong) UILabel *disappearSegmentedLabel;
@property (nonatomic, strong) UISegmentedControl *disappearSegmented;
@property (nonatomic, strong) UILabel *overlaySegmentedLabel;
@property (nonatomic, strong) UISegmentedControl *overlaySegmented;
@property (nonatomic, strong) UILabel *shimmeringSwitchLabel;
@property (nonatomic, strong) UISwitch *shimmeringSwitch;
@property (nonatomic, strong) UILabel *onlyActiveSwitchLabel;
@property (nonatomic, strong) UISwitch *onlyActiveSwitch;

@end

@implementation AxcTextHUDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.instructionsLabel];
    self.instructionsLabel.text = @"纯文字加载提示工具演示\n支持类方法（单例）与实例方法两种调用，含滑闪/遮罩/入场出场动画/交互屏蔽等属性";

    [self setupButtons];
    [self setupConfigControls];
}

- (void)setupButtons {
    CGFloat width = (self.view.bounds.size.width - 40 - 20) / 2;
    CGFloat height = 44;
    CGFloat gap = 12;
    CGFloat x = 20;
    CGFloat y = 30;

    NSArray<NSString *> *titles = @[
        @"类方法 · 短文字",
        @"类方法 · 长文字",
        @"实例 · 自定义样式",
        @"展示在指定View",
        @"展示后更新文字",
        @"移除展示",
    ];
    NSArray<NSString *> *actions = @[
        @"click_showShort",
        @"click_showLong",
        @"click_showCustom",
        @"click_showInBox",
        @"click_update",
        @"click_dismiss",
    ];

    for (NSInteger i = 0; i < titles.count; i++) {
        NSInteger row = i / 2;
        NSInteger col = i % 2;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(x + col * (width + 20), y + row * (height + gap), width, height);
        button.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        button.layer.cornerRadius = 6;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:NSSelectorFromString(actions[i]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)setupConfigControls {
    [self.view addSubview:self.appearSegmentedLabel];
    [self.view addSubview:self.appearSegmented];
    [self.view addSubview:self.disappearSegmentedLabel];
    [self.view addSubview:self.disappearSegmented];
    [self.view addSubview:self.overlaySegmentedLabel];
    [self.view addSubview:self.overlaySegmented];
    [self.view addSubview:self.shimmeringSwitchLabel];
    [self.view addSubview:self.shimmeringSwitch];
    [self.view addSubview:self.onlyActiveSwitchLabel];
    [self.view addSubview:self.onlyActiveSwitch];
}

// 把当前配置控件应用到单例HUD
- (void)applyConfig {
    AxcUI_TextHUD *hud = [AxcUI_TextHUD shared];
    hud.axcUI_appearAnimationType = self.appearSegmented.selectedSegmentIndex;
    hud.axcUI_disappearAnimationType = self.disappearSegmented.selectedSegmentIndex;
    hud.axcUI_overlayType = self.overlaySegmented.selectedSegmentIndex;
    hud.axcUI_shimmeringEnabled = self.shimmeringSwitch.on;
    hud.axcUI_isTheOnlyActiveView = self.onlyActiveSwitch.on;
}

#pragma mark - 类方法（单例）演示
//MARK: 短文字（开启滑闪，对照原类效果）
- (void)click_showShort {
    [self cancelScheduledDismiss];
    [self applyConfig];
    [AxcUI_TextHUD AxcUI_showWithText:@"努力加载中..." shimmering:YES];
    [self performSelector:@selector(autoDismiss) withObject:nil afterDelay:2.0];
}
//MARK: 长文字（多行自动换行）
- (void)click_showLong {
    [self cancelScheduledDismiss];
    [self applyConfig];
    [AxcUI_TextHUD AxcUI_showWithText:@"这是一段比较长的加载提示文字，用于演示多行文字的自动换行与尺寸自适应，最大宽度默认为屏幕宽度的1/2.8"];
    [self performSelector:@selector(autoDismiss) withObject:nil afterDelay:3.0];
}

#pragma mark - 实例方法演示
//MARK: 自定义样式（含边框）——使用独立实例，需单独移除
- (void)click_showCustom {
    [self cancelScheduledDismiss];
    [AxcUI_TextHUD AxcUI_dismiss];        // 先移除单例HUD，避免叠加
    [self.customHUD AxcUI_dismiss];       // 移除旧的实例HUD
    self.customHUD = [[AxcUI_TextHUD alloc] initWithFrame:CGRectZero];
    self.customHUD.axcUI_backgroundColor = [UIColor colorWithRed:0.55 green:0.29 blue:0.71 alpha:0.9]; // 紫色
    self.customHUD.axcUI_textColor = [UIColor whiteColor];
    self.customHUD.axcUI_fontSize = 16;
    self.customHUD.axcUI_cornerRadius = 10;
    self.customHUD.axcUI_borderColor = [UIColor whiteColor];   // 边框
    self.customHUD.axcUI_borderWidth = 1.0;
    self.customHUD.axcUI_horizontalPadding = 28;
    self.customHUD.axcUI_verticalPadding = 20;
    self.customHUD.axcUI_shimmeringEnabled = self.shimmeringSwitch.on;
    [self.customHUD AxcUI_showWithText:@"自定义样式演示" inView:self.view];
    [self performSelector:@selector(autoDismissCustom) withObject:nil afterDelay:2.0];
}
//MARK: 展示在指定View
- (void)click_showInBox {
    [self cancelScheduledDismiss];
    [self targetBox]; // 初始化黄色容器
    [AxcUI_TextHUD AxcUI_showWithText:@"展示在黄色区域内" inView:self.targetBox];
    [self performSelector:@selector(autoDismiss) withObject:nil afterDelay:2.0];
}

#pragma mark - 更新与移除
//MARK: 展示后更新文字
- (void)click_update {
    [self cancelScheduledDismiss];
    [self applyConfig];
    [AxcUI_TextHUD AxcUI_showWithText:@"正在加载..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AxcUI_TextHUD AxcUI_updateText:@"加载完成，即将消失"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [AxcUI_TextHUD AxcUI_dismiss];
        });
    });
}
//MARK: 移除展示（单例与自定义实例一起移除）
- (void)click_dismiss {
    [self cancelScheduledDismiss];
    [self.customHUD AxcUI_dismiss];
    self.customHUD = nil;
    [AxcUI_TextHUD AxcUI_dismiss];
}

// 取消所有待执行的自动移除
- (void)cancelScheduledDismiss {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoDismiss) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoDismissCustom) object:nil];
}
// 定时自动移除单例HUD
- (void)autoDismiss {
    [AxcUI_TextHUD AxcUI_dismiss];
}
// 定时自动移除自定义实例HUD
- (void)autoDismissCustom {
    [self.customHUD AxcUI_dismiss];
    self.customHUD = nil;
}

#pragma mark - 懒加载
- (UIView *)targetBox {
    if (!_targetBox) {
        _targetBox = [[UIView alloc] initWithFrame:CGRectMake(20,
                                                              self.view.axcUI_safeHeight - 240,
                                                              self.view.bounds.size.width - 40,
                                                              120)];
        _targetBox.backgroundColor = [UIColor colorWithRed:1.0 green:0.94 blue:0.72 alpha:1.0];
        _targetBox.layer.cornerRadius = 8;
        [self.view addSubview:_targetBox];
    }
    return _targetBox;
}

- (UILabel *)appearSegmentedLabel {
    if (!_appearSegmentedLabel) {
        _appearSegmentedLabel = [self makeConfigLabelWithY:200 text:@"入场动画"];
    }
    return _appearSegmentedLabel;
}
- (UISegmentedControl *)appearSegmented {
    if (!_appearSegmented) {
        _appearSegmented = [self makeConfigSegmentedWithY:225 items:@[@"上", @"下", @"左", @"右", @"放大", @"淡入"]];
        _appearSegmented.selectedSegmentIndex = AxcTextHUDAppearAnimationTypeFadeIn;
    }
    return _appearSegmented;
}
- (UILabel *)disappearSegmentedLabel {
    if (!_disappearSegmentedLabel) {
        _disappearSegmentedLabel = [self makeConfigLabelWithY:265 text:@"出场动画"];
    }
    return _disappearSegmentedLabel;
}
- (UISegmentedControl *)disappearSegmented {
    if (!_disappearSegmented) {
        _disappearSegmented = [self makeConfigSegmentedWithY:290 items:@[@"上", @"下", @"左", @"右", @"缩小", @"渐隐"]];
        _disappearSegmented.selectedSegmentIndex = AxcTextHUDDisappearAnimationTypeFadeOut;
    }
    return _disappearSegmented;
}
- (UILabel *)overlaySegmentedLabel {
    if (!_overlaySegmentedLabel) {
        _overlaySegmentedLabel = [self makeConfigLabelWithY:330 text:@"遮罩类型"];
    }
    return _overlaySegmentedLabel;
}
- (UISegmentedControl *)overlaySegmented {
    if (!_overlaySegmented) {
        _overlaySegmented = [self makeConfigSegmentedWithY:355 items:@[@"无", @"模糊", @"半透明", @"阴影"]];
        _overlaySegmented.selectedSegmentIndex = AxcTextHUDOverlayTypeNone;
    }
    return _overlaySegmented;
}
- (UILabel *)shimmeringSwitchLabel {
    if (!_shimmeringSwitchLabel) {
        _shimmeringSwitchLabel = [self makeConfigLabelWithY:400 text:@"文字滑闪"];
    }
    return _shimmeringSwitchLabel;
}
- (UISwitch *)shimmeringSwitch {
    if (!_shimmeringSwitch) {
        _shimmeringSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 70, 392, 50, 30)];
        _shimmeringSwitch.on = NO;
    }
    return _shimmeringSwitch;
}
- (UILabel *)onlyActiveSwitchLabel {
    if (!_onlyActiveSwitchLabel) {
        _onlyActiveSwitchLabel = [self makeConfigLabelWithY:440 text:@"屏蔽背景点击"];
    }
    return _onlyActiveSwitchLabel;
}
- (UISwitch *)onlyActiveSwitch {
    if (!_onlyActiveSwitch) {
        _onlyActiveSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 70, 432, 50, 30)];
        _onlyActiveSwitch.on = YES;
    }
    return _onlyActiveSwitch;
}

- (UILabel *)makeConfigLabelWithY:(CGFloat)y text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, self.view.bounds.size.width - 100, 30)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor orangeColor];
    label.text = text;
    return label;
}

- (UISegmentedControl *)makeConfigSegmentedWithY:(CGFloat)y items:(NSArray<NSString *> *)items {
    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:items];
    segmented.frame = CGRectMake(20, y, self.view.bounds.size.width - 40, 30);
    return segmented;
}

@end
