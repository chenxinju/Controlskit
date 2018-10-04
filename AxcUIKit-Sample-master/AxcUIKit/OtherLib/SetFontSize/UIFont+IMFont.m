//
//  UIFont+IMFont.m
//  OuLianWang
//
//  Created by hzq on 16/7/13.
//  Copyright © 2016年 联科. All rights reserved.
//

#import "UIFont+IMFont.h"
#import "IMSetUserDefaultTool.h"
@implementation UIFont (IMFont)
+ (UIFont *)imFontOfSize:(CGFloat)fontSize{
    
    //
//    NSInteger coefficient = [IMSetUserDefaultTool getFontSizeCoefficient];
//    //0.075*
//    float x = 0.075*(coefficient-2)+1; //改变系数x 为0.925 --1.30
//    return  [UIFont systemFontOfSize:fontSize*x];
    
    
    CGFloat fontScale = [IMSetUserDefaultTool getScaleCoefficient];
    
    CGFloat size = fontSize *fontScale;
    NSLog(@"size--%f",size);
    return  [UIFont italicSystemFontOfSize:size];;

}

@end
