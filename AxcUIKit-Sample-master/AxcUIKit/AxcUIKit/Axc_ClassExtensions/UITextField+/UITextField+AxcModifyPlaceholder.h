//
//  UITextField+AxcModifyPlaceholder.h
//  AxcUIKit
//
//  Created by Axc on 2017/6/4.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (AxcModifyPlaceholder)

/**
 *  占位文字（同placeholder，通过此属性设置可保留自定义样式）
 */
@property (nonatomic, strong) NSString *axcUI_placeholder;

/**
 *  占位文字颜色（通过公开API attributedPlaceholder 实现）
 */
@property (nonatomic, strong) UIColor *axcUI_placeholderColor;

/**
 *  占位文字字体
 */
@property (nonatomic, strong) UIFont *axcUI_placeholderFont;

/**
 *  占位文字对齐方式
 */
@property (nonatomic, assign) NSTextAlignment axcUI_placeholderTextAlignment;

@end
