//
//  UIView+CKCorner.h
//  AxcUIKit
//
//  UIView 通用圆角：CAShapeLayer mask。
//  与 ZYCornerRadius（预裁 UIImage）原理不同，适用于任意 UIView 子类。
//

#import <UIKit/UIKit.h>

@interface UIView (CKCorner)

/// 指定角圆角（CAShapeLayer mask）。bounds 变化后需再调一次，或放在 layoutSubviews 后调用。
- (void)ck_setCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners;

/// 四角相同圆角的便捷方法
- (void)ck_setCornerRadius:(CGFloat)radius;

/// 系统 layer 圆角（clipsToBounds）。实现简单，复杂场景可能触发离屏渲染。
- (void)ck_setLayerCornerRadius:(CGFloat)radius;

@end
