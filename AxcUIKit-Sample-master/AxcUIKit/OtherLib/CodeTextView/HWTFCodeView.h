//
//  CodeTextDemo
//
//  Created by Harvey on 2018/9/20.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 * 基础版 - 下划线
 */
@interface HWTFCodeView : UIView

/// 当前输入的内容
@property (nonatomic, copy, readonly) NSString *code;

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end



NS_ASSUME_NONNULL_END
