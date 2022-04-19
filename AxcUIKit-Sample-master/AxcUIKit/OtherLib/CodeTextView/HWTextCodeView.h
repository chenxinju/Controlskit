//
//  CodeTextDemo
//
//  Created by Harvey on 2018/9/20.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 完善版 - 加入动画 - 下划线
 */
@interface HWTextCodeView : UIView

@property (nonatomic, copy) void(^editBlcok)(NSString *text);

/// 当前输入的内容
@property (nonatomic, copy, readonly) NSString *code;

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end



// ------------------------------------------------------------------------
// -----------------------------HWTC_lineView------------------------------
// ------------------------------------------------------------------------


@interface HWTC_lineView : UIView

@property (nonatomic, weak) UIView *colorView;

- (void)animation;

@end

NS_ASSUME_NONNULL_END
