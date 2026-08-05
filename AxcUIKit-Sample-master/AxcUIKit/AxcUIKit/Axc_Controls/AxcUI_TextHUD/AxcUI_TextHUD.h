//
//  AxcUI_TextHUD.h
//  AxcUIKit
//
//  轻量级纯文字加载提示工具
//  参照 AxcUI_ActivityHUD 的文字展示部分（AxcUI_showWithText:shimmering:）
//  精简而来：只展示纯文字，无动画指示器，但保留边框、遮罩、入场/离场动画、
//  交互屏蔽、文字滑闪等属性效果。
//
//  Created by Axc on 2017/6/9.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 背景遮罩类型 */
typedef NS_ENUM(NSInteger, AxcTextHUDOverlayType) {
    AxcTextHUDOverlayTypeNone,        /**< 无遮罩（默认） */
    AxcTextHUDOverlayTypeBlur,        /**< 模糊遮罩 */
    AxcTextHUDOverlayTypeTransparent, /**< 半透明黑遮罩 */
    AxcTextHUDOverlayTypeShadow       /**< 自身阴影 */
};

/** 入场动画 */
typedef NS_ENUM(NSInteger, AxcTextHUDAppearAnimationType) {
    AxcTextHUDAppearAnimationTypeSlideFromTop,
    AxcTextHUDAppearAnimationTypeSlideFromBottom,
    AxcTextHUDAppearAnimationTypeSlideFromLeft,
    AxcTextHUDAppearAnimationTypeSlideFromRight,
    AxcTextHUDAppearAnimationTypeZoomIn,
    AxcTextHUDAppearAnimationTypeFadeIn /**< 默认 */
};

/** 出场动画 */
typedef NS_ENUM(NSInteger, AxcTextHUDDisappearAnimationType) {
    AxcTextHUDDisappearAnimationTypeSlideToTop,
    AxcTextHUDDisappearAnimationTypeSlideToBottom,
    AxcTextHUDDisappearAnimationTypeSlideToLeft,
    AxcTextHUDDisappearAnimationTypeSlideToRight,
    AxcTextHUDDisappearAnimationTypeZoomOut,
    AxcTextHUDDisappearAnimationTypeFadeOut /**< 默认 */
};

/**
 *  轻量级纯文字加载提示工具
 *
 *  支持两种调用方式：
 *  1. 单例类方法快捷调用：+ [AxcUI_TextHUD AxcUI_showWithText:@"努力加载中.."]
 *  2. 实例化调用：与 AxcUI_ActivityHUD 用法一致，可独立创建多个 HUD
 */
@interface AxcUI_TextHUD : UIView

/**
 *  单例对象，配合类方法使用
 */
+ (instancetype)shared;

#pragma mark - 样式属性
/**
 *  文字颜色，默认白色
 */
@property (strong, nonatomic) UIColor *axcUI_textColor;
/**
 *  背景颜色，默认黑色半透明
 */
@property (strong, nonatomic) UIColor *axcUI_backgroundColor;
/**
 *  文字字号，默认14
 */
@property (nonatomic, assign) CGFloat axcUI_fontSize;
/**
 *  圆角值，默认5
 */
@property (nonatomic, assign) CGFloat axcUI_cornerRadius;
/**
 *  左右内边距，默认16
 */
@property (nonatomic, assign) CGFloat axcUI_horizontalPadding;
/**
 *  上下内边距，默认12
 */
@property (nonatomic, assign) CGFloat axcUI_verticalPadding;
/**
 *  文字最大宽度，默认屏幕宽度的1/2.8
 */
@property (nonatomic, assign) CGFloat axcUI_maxWidth;

#pragma mark - 边框属性
/**
 *  边框颜色，默认透明（不显示）
 */
@property (strong, nonatomic) UIColor *axcUI_borderColor;
/**
 *  边框宽度，默认0
 */
@property (nonatomic, assign) CGFloat axcUI_borderWidth;

#pragma mark - 遮罩与交互属性
/**
 *  背景遮罩类型，默认AxcTextHUDOverlayTypeNone
 */
@property (nonatomic, assign) AxcTextHUDOverlayType axcUI_overlayType;
/**
 *  是否屏蔽背景点击（展示时禁用父视图其它控件交互），默认YES
 */
@property (nonatomic, assign) BOOL axcUI_isTheOnlyActiveView;

#pragma mark - 动画属性
/**
 *  入场动画风格，默认FadeIn
 */
@property (nonatomic, assign) AxcTextHUDAppearAnimationType axcUI_appearAnimationType;
/**
 *  退场动画风格，默认FadeOut
 */
@property (nonatomic, assign) AxcTextHUDDisappearAnimationType axcUI_disappearAnimationType;
/**
 *  是否开启文字滑闪效果，默认NO
 */
@property (nonatomic, assign) BOOL axcUI_shimmeringEnabled;

#pragma mark - 实例方法
/**
 *  居中展示于keyWindow
 */
- (void)AxcUI_showWithText:(NSString *)text;
/**
 *  居中展示于keyWindow，并设置是否开启文字滑闪
 */
- (void)AxcUI_showWithText:(NSString *)text shimmering:(BOOL)shimmering;
/**
 *  居中展示于指定View
 */
- (void)AxcUI_showWithText:(NSString *)text inView:(UIView *)view;
/**
 *  居中展示于指定View，并设置是否开启文字滑闪
 */
- (void)AxcUI_showWithText:(NSString *)text inView:(UIView *)view shimmering:(BOOL)shimmering;
/**
 *  刷新展示文字
 */
- (void)AxcUI_updateText:(NSString *)text;
/**
 *  移除展示
 */
- (void)AxcUI_dismiss;

#pragma mark - 类方法（基于单例）
/**
 *  居中展示于keyWindow
 */
+ (void)AxcUI_showWithText:(NSString *)text;
/**
 *  居中展示于keyWindow，并设置是否开启文字滑闪
 */
+ (void)AxcUI_showWithText:(NSString *)text shimmering:(BOOL)shimmering;
/**
 *  居中展示于指定View
 */
+ (void)AxcUI_showWithText:(NSString *)text inView:(UIView *)view;
/**
 *  居中展示于指定View，并设置是否开启文字滑闪
 */
+ (void)AxcUI_showWithText:(NSString *)text inView:(UIView *)view shimmering:(BOOL)shimmering;
/**
 *  刷新展示文字
 */
+ (void)AxcUI_updateText:(NSString *)text;
/**
 *  移除展示
 */
+ (void)AxcUI_dismiss;

@end

NS_ASSUME_NONNULL_END
