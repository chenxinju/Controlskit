//
//  UIImage+XJIamge.h
//  AxcUIKit
//
//  Created by mac on 2018/9/1.
//  Copyright © 2018年 Axc_5324. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XJIamge)


/**
 图片裁剪，适用于圆形头像之类
 
 @param image 要切圆的图片
 @param borderWidth 边框的宽度
 @param color 边框的颜色
 @return 切圆的图片
 */
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;

/**
 根据文字生成水印图片
 
 @param imageName 图片
 @param str 水印文字
 @param point 绘制水印文字的起始点
 @param dict 水印文字的属性字典
 @return 返回图片
 */
+ (UIImage *)imageWithWaterMarkImage:(NSString *)imageName text:(NSString *)str textPoint:(CGPoint)point textAttributes:(NSDictionary *)dict;

/**
 根据图片生成水印图片
 
 @param image 图片
 @param waterImage 水印图片
 @param rect 水印图片的位置
 @return 返回图片
 */
+ (UIImage *)imageWithWaterMarkImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect;


/**
 截屏或者截取某个view视图
 
 @param captureView 要截取的view视图
 @return 返回截图
 */
+ (UIImage *)imageWithCaptureView:(UIView *)captureView;


/**
 根据颜色生成图片
 
 @param color 颜色
 @param size 图片的尺寸
 @return 返回生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 图片的等比例缩放
 
 @param image 图片
 @param defineWidth 要缩放到的宽度
 @return 返回与原图片等宽高比的图片
 */
+ (UIImage *)imageWithOriginImage:(UIImage *)image scaleToWidth:(CGFloat)defineWidth;


/**
 根据图片名返回一张能够自由拉伸的图片
 
 @param name 图片名
 @param width 自由拉伸的宽度
 @param height 自由拉伸的高度
 @return 返回图片
 */
+ (UIImage *)imageWithResizedImage:(NSString *)name capWidth:(CGFloat)width capHeight:(CGFloat)height;

@end
