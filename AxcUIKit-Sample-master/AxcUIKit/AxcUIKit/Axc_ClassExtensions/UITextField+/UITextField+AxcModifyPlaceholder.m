//
//  UITextField+AxcModifyPlaceholder.m
//  AxcUIKit
//
//  Created by Axc on 2017/6/4.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//
//  说明：新版系统禁止访问 UITextField 的私有 _placeholderLabel，
//  改为通过公开API attributedPlaceholder 实现占位文字的自定义样式。

#import "UITextField+AxcModifyPlaceholder.h"

#import <objc/runtime.h>

static const char *kAxcPlaceholderColorKey = "axcUI_placeholderColor";
static const char *kAxcPlaceholderFontKey = "axcUI_placeholderFont";
static const char *kAxcPlaceholderAlignmentKey = "axcUI_placeholderTextAlignment";


@implementation UITextField (AxcModifyPlaceholder)

#pragma mark - 占位文字
- (void)setAxcUI_placeholder:(NSString *)axcUI_placeholder {
    self.placeholder = axcUI_placeholder;
    [self axcUI_applyPlaceholderStyle];
}

- (NSString *)axcUI_placeholder {
    return self.placeholder;
}

#pragma mark - 占位颜色
- (void)setAxcUI_placeholderColor:(UIColor *)axcUI_placeholderColor {
    objc_setAssociatedObject(self, kAxcPlaceholderColorKey,
                             axcUI_placeholderColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self axcUI_applyPlaceholderStyle];
}

- (UIColor *)axcUI_placeholderColor {
    return objc_getAssociatedObject(self, kAxcPlaceholderColorKey);
}

#pragma mark - 占位字体
- (void)setAxcUI_placeholderFont:(UIFont *)axcUI_placeholderFont {
    objc_setAssociatedObject(self, kAxcPlaceholderFontKey,
                             axcUI_placeholderFont,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self axcUI_applyPlaceholderStyle];
}

- (UIFont *)axcUI_placeholderFont {
    return objc_getAssociatedObject(self, kAxcPlaceholderFontKey);
}

#pragma mark - 占位对齐
- (void)setAxcUI_placeholderTextAlignment:(NSTextAlignment)axcUI_placeholderTextAlignment {
    objc_setAssociatedObject(self, kAxcPlaceholderAlignmentKey,
                             @(axcUI_placeholderTextAlignment),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self axcUI_applyPlaceholderStyle];
}

- (NSTextAlignment)axcUI_placeholderTextAlignment {
    NSNumber *num = objc_getAssociatedObject(self, kAxcPlaceholderAlignmentKey);
    return num ? num.integerValue : NSTextAlignmentNatural;
}

#pragma mark - 应用占位样式
- (void)axcUI_applyPlaceholderStyle {
    NSString *text = self.placeholder;
    if (text.length == 0) {
        return;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    if (self.axcUI_placeholderColor) {
        attributes[NSForegroundColorAttributeName] = self.axcUI_placeholderColor;
    }
    if (self.axcUI_placeholderFont) {
        attributes[NSFontAttributeName] = self.axcUI_placeholderFont;
    }
    NSTextAlignment alignment = self.axcUI_placeholderTextAlignment;
    if (alignment != NSTextAlignmentNatural) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = alignment;
        attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text
                                                                           attributes:attributes];
    self.attributedPlaceholder = attributedString;
}

@end
