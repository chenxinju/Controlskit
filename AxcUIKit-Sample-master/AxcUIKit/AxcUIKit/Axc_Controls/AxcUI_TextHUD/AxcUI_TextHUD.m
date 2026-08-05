//
//  AxcUI_TextHUD.m
//  AxcUIKit
//
//  轻量级纯文字加载提示工具
//
//  Created by Axc on 2017/6/9.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import "AxcUI_TextHUD.h"
#import "UILabel+AxcShimmering.h"

@implementation AxcUI_TextHUD
{
    UILabel *_textLabel;
    // 当前承载的父视图，弱引用避免循环
    __weak UIView *_targetView;
    // 遮罩视图（模糊/半透明黑）
    UIView *_overlay;
}

#pragma mark - 单例
+ (instancetype)shared {
    static AxcUI_TextHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AxcUI_TextHUD alloc] initWithFrame:CGRectZero];
    });
    return instance;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // 样式默认值（对齐原类 AxcUI_ActivityHUD 的文字展示）
    _axcUI_textColor = [UIColor whiteColor];
    _axcUI_backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    _axcUI_fontSize = 14;
    _axcUI_cornerRadius = 5;
    _axcUI_horizontalPadding = 16;
    _axcUI_verticalPadding = 12;
    _axcUI_maxWidth = [UIScreen mainScreen].bounds.size.width / 2.8;

    // 边框默认值
    _axcUI_borderColor = [UIColor clearColor];
    _axcUI_borderWidth = 0;

    // 遮罩与交互默认值
    _axcUI_overlayType = AxcTextHUDOverlayTypeNone;
    _axcUI_isTheOnlyActiveView = YES;

    // 动画默认值
    _axcUI_appearAnimationType = AxcTextHUDAppearAnimationTypeFadeIn;
    _axcUI_disappearAnimationType = AxcTextHUDDisappearAnimationTypeFadeOut;
    _axcUI_shimmeringEnabled = NO;

    self.backgroundColor = _axcUI_backgroundColor;
    self.layer.cornerRadius = _axcUI_cornerRadius;
    self.layer.masksToBounds = YES;
    // resting alpha 为1，入场动画自行处理淡入/滑入
    self.alpha = 1.0;

    _textLabel = [[UILabel alloc] init];
    _textLabel.numberOfLines = 0;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.textColor = _axcUI_textColor;
    _textLabel.font = [UIFont systemFontOfSize:_axcUI_fontSize];
    [self addSubview:_textLabel];
}

#pragma mark - 样式属性SET方法
- (void)setAxcUI_textColor:(UIColor *)axcUI_textColor {
    _axcUI_textColor = axcUI_textColor;
    _textLabel.textColor = axcUI_textColor;
}

- (void)setAxcUI_backgroundColor:(UIColor *)axcUI_backgroundColor {
    _axcUI_backgroundColor = axcUI_backgroundColor;
    self.backgroundColor = axcUI_backgroundColor;
}

- (void)setAxcUI_fontSize:(CGFloat)axcUI_fontSize {
    _axcUI_fontSize = axcUI_fontSize;
    _textLabel.font = [UIFont systemFontOfSize:axcUI_fontSize];
}

- (void)setAxcUI_cornerRadius:(CGFloat)axcUI_cornerRadius {
    _axcUI_cornerRadius = axcUI_cornerRadius;
    self.layer.cornerRadius = axcUI_cornerRadius;
}

- (void)setAxcUI_borderColor:(UIColor *)axcUI_borderColor {
    _axcUI_borderColor = axcUI_borderColor;
    self.layer.borderColor = axcUI_borderColor.CGColor;
}

- (void)setAxcUI_borderWidth:(CGFloat)axcUI_borderWidth {
    _axcUI_borderWidth = axcUI_borderWidth;
    self.layer.borderWidth = axcUI_borderWidth;
}

#pragma mark - 公开的SHOW方法重载
//MARK: 展示于keyWindow
- (void)AxcUI_showWithText:(NSString *)text {
    [self AxcUI_showWithText:text inView:[self defaultSuperView]];
}
- (void)AxcUI_showWithText:(NSString *)text shimmering:(BOOL)shimmering {
    self.axcUI_shimmeringEnabled = shimmering;
    [self AxcUI_showWithText:text];
}
//MARK: 展示于指定View
- (void)AxcUI_showWithText:(NSString *)text inView:(UIView *)view {
    // 如果已在展示，先移除，避免多次叠加
    if (self.superview) {
        [self removeFromSuperview];
    }
    _targetView = view;

    [self applyOverlay];                 // 按遮罩类型添加背景
    [view addSubview:self];
    [view bringSubviewToFront:self];

    [self relayoutWithText:text];        // 布局并应用滑闪
    [self blockBackgroundInteraction];   // 屏蔽背景点击

    [self showAnimation];                // 入场动画
}
- (void)AxcUI_showWithText:(NSString *)text inView:(UIView *)view shimmering:(BOOL)shimmering {
    self.axcUI_shimmeringEnabled = shimmering;
    [self AxcUI_showWithText:text inView:view];
}

#pragma mark - 刷新文字
- (void)AxcUI_updateText:(NSString *)text {
    if (self.superview) {
        [self relayoutWithText:text];
    }
}

#pragma mark - 移除
- (void)AxcUI_dismiss {
    if (self.superview) {
        [self hideAnimation];
    }
}

#pragma mark - 遮罩
- (void)applyOverlay {
    [self removeOverlay];
    switch (self.axcUI_overlayType) {
        case AxcTextHUDOverlayTypeNone:
            // 无遮罩，不处理
            break;

        case AxcTextHUDOverlayTypeBlur: {
            UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithFrame:_targetView.bounds];
            blurView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            _overlay = blurView;
            [_targetView addSubview:_overlay];
            break;
        }
        case AxcTextHUDOverlayTypeTransparent: {
            UIView *maskView = [[UIView alloc] initWithFrame:_targetView.bounds];
            maskView.backgroundColor = [UIColor blackColor];
            maskView.alpha = 0.25;
            _overlay = maskView;
            [_targetView addSubview:_overlay];
            break;
        }
        case AxcTextHUDOverlayTypeShadow:
            // 阴影作用于HUD自身，需关闭masksToBounds
            self.layer.masksToBounds = NO;
            self.layer.shadowColor = [UIColor blackColor].CGColor;
            self.layer.shadowOffset = CGSizeMake(2.0, 2.0);
            self.layer.shadowOpacity = 0.5;
            break;
    }
}

- (void)removeOverlay {
    if (_overlay != nil) {
        [_overlay removeFromSuperview];
        _overlay = nil;
    }
    self.layer.masksToBounds = YES;
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0;
}

#pragma mark - 背景交互屏蔽
- (void)blockBackgroundInteraction {
    if (self.axcUI_isTheOnlyActiveView && _targetView) {
        for (UIView *view in _targetView.subviews) {
            if (view != self && view != _overlay) {
                view.userInteractionEnabled = NO;
            }
        }
    }
}

- (void)restoreBackgroundInteraction {
    if (self.axcUI_isTheOnlyActiveView && _targetView) {
        for (UIView *view in _targetView.subviews) {
            view.userInteractionEnabled = YES;
        }
    }
}

#pragma mark - 入场动画
- (void)showAnimation {
    switch (self.axcUI_appearAnimationType) {
        case AxcTextHUDAppearAnimationTypeSlideFromTop:
            [self showSlideFromTop];
            break;
        case AxcTextHUDAppearAnimationTypeSlideFromBottom:
            [self showSlideFromBottom];
            break;
        case AxcTextHUDAppearAnimationTypeSlideFromLeft:
            [self showSlideFromLeft];
            break;
        case AxcTextHUDAppearAnimationTypeSlideFromRight:
            [self showSlideFromRight];
            break;
        case AxcTextHUDAppearAnimationTypeZoomIn:
            [self showZoomIn];
            break;
        case AxcTextHUDAppearAnimationTypeFadeIn:
            [self showFadeIn];
            break;
    }
}

- (void)showFadeIn {
    self.alpha = 0.0;
    self.center = [self centerPoint];
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)showSlideFromTop {
    self.center = CGPointMake([self centerPoint].x, -CGRectGetHeight(self.bounds));
    [UIView animateWithDuration:0.4
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        self.center = [self centerPoint];
    } completion:nil];
}

- (void)showSlideFromBottom {
    self.center = CGPointMake([self centerPoint].x, CGRectGetHeight(_targetView.bounds) + CGRectGetHeight(self.bounds));
    [UIView animateWithDuration:0.4
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.center = [self centerPoint];
    } completion:nil];
}

- (void)showSlideFromLeft {
    self.center = CGPointMake(-CGRectGetWidth(self.bounds), [self centerPoint].y);
    [UIView animateWithDuration:0.4
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.center = [self centerPoint];
    } completion:nil];
}

- (void)showSlideFromRight {
    self.center = CGPointMake(CGRectGetWidth(_targetView.bounds) + CGRectGetWidth(self.bounds), [self centerPoint].y);
    [UIView animateWithDuration:0.4
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.center = [self centerPoint];
    } completion:nil];
}

- (void)showZoomIn {
    self.center = [self centerPoint];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

#pragma mark - 离场动画
- (void)hideAnimation {
    switch (self.axcUI_disappearAnimationType) {
        case AxcTextHUDDisappearAnimationTypeSlideToTop:
            [self hideSlideToTop];
            break;
        case AxcTextHUDDisappearAnimationTypeSlideToBottom:
            [self hideSlideToBottom];
            break;
        case AxcTextHUDDisappearAnimationTypeSlideToLeft:
            [self hideSlideToLeft];
            break;
        case AxcTextHUDDisappearAnimationTypeSlideToRight:
            [self hideSlideToRight];
            break;
        case AxcTextHUDDisappearAnimationTypeZoomOut:
            [self hideZoomOut];
            break;
        case AxcTextHUDDisappearAnimationTypeFadeOut:
            [self hideFadeOut];
            break;
    }
}

- (void)hideFadeOut {
    CGFloat originalAlpha = self.alpha;
    [UIView animateWithDuration:0.35
                          delay:0
                        options:kNilOptions
                     animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.alpha = originalAlpha;
        [self cleanupAfterHide];
    }];
}

- (void)hideSlideToTop {
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.center = CGPointMake([self centerPoint].x, -CGRectGetHeight(self.bounds));
    } completion:^(BOOL finished) {
        [self cleanupAfterHide];
    }];
}

- (void)hideSlideToBottom {
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.center = CGPointMake([self centerPoint].x, CGRectGetHeight(_targetView.bounds) + CGRectGetHeight(self.bounds));
    } completion:^(BOOL finished) {
        [self cleanupAfterHide];
    }];
}

- (void)hideSlideToLeft {
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.center = CGPointMake(-CGRectGetWidth(self.bounds), [self centerPoint].y);
    } completion:^(BOOL finished) {
        [self cleanupAfterHide];
    }];
}

- (void)hideSlideToRight {
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.center = CGPointMake(CGRectGetWidth(_targetView.bounds) + CGRectGetWidth(self.bounds), [self centerPoint].y);
    } completion:^(BOOL finished) {
        [self cleanupAfterHide];
    }];
}

- (void)hideZoomOut {
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.01, 0.01);
            } completion:^(BOOL finished) {
                [self cleanupAfterHide];
            }];
        }];
    }];
}

// 离场动画完成后的清理
- (void)cleanupAfterHide {
    [self removeOverlay];
    [self restoreBackgroundInteraction];
    [self removeFromSuperview];
}

#pragma mark - 工具类
// 计算文字尺寸并刷新布局
- (void)relayoutWithText:(NSString *)text {
    _textLabel.text = text;
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.axcUI_maxWidth, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName: _textLabel.font}
                                     context:nil];
    CGFloat width = ceil(rect.size.width) + self.axcUI_horizontalPadding * 2;
    CGFloat height = ceil(rect.size.height) + self.axcUI_verticalPadding * 2;

    self.bounds = CGRectMake(0, 0, width, height);
    _textLabel.frame = CGRectMake(self.axcUI_horizontalPadding,
                                  self.axcUI_verticalPadding,
                                  width - self.axcUI_horizontalPadding * 2,
                                  height - self.axcUI_verticalPadding * 2);
    self.center = [self centerPoint];

    // 文字滑闪效果：先清除可能残留的蒙层，避免旧尺寸蒙层裁剪文字
    _textLabel.layer.mask = nil;
    if (self.axcUI_shimmeringEnabled) {
        [_textLabel AxcUI_shimmeringEffectStart];
    }
}

// 目标视图中心点
- (CGPoint)centerPoint {
    return CGPointMake(CGRectGetMidX(_targetView.bounds), CGRectGetMidY(_targetView.bounds));
}

- (UIView *)defaultSuperView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows lastObject];
    }
    return window;
}

#pragma mark - 类方法（基于单例）
+ (void)AxcUI_showWithText:(NSString *)text {
    [[AxcUI_TextHUD shared] AxcUI_showWithText:text];
}

+ (void)AxcUI_showWithText:(NSString *)text shimmering:(BOOL)shimmering {
    [[AxcUI_TextHUD shared] AxcUI_showWithText:text shimmering:shimmering];
}

+ (void)AxcUI_showWithText:(NSString *)text inView:(UIView *)view {
    [[AxcUI_TextHUD shared] AxcUI_showWithText:text inView:view];
}

+ (void)AxcUI_showWithText:(NSString *)text inView:(UIView *)view shimmering:(BOOL)shimmering {
    [[AxcUI_TextHUD shared] AxcUI_showWithText:text inView:view shimmering:shimmering];
}

+ (void)AxcUI_updateText:(NSString *)text {
    [[AxcUI_TextHUD shared] AxcUI_updateText:text];
}

+ (void)AxcUI_dismiss {
    [[AxcUI_TextHUD shared] AxcUI_dismiss];
}

@end
