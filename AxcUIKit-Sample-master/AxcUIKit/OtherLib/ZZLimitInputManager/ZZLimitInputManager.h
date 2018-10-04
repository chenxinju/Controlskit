//
//  ZZLimitInputManager.h
//  LimitInputManagerDemo
//
//  Created by Harvey on 2018/9/20.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZZLimitInputManager : NSObject

/**
 *  限制输入长度为length
 *  @param view UITextFiel或UITextView对象
 *  @param length 可以输入的最大长度
 */
+ (void)limitInputView:(UIView<UITextInput> *)view maxLength:(NSUInteger)length;

/**
 *  限制输入符合正则表达式regx
 *  @param view UITextFiel或UITextView对象
 *  @param regx 正则表达式
 */
+ (void)limitInputView:(UIView<UITextInput> *)view regX:(NSString *)regx;

@end

