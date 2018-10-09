//
//  UIImage+XJIamge.m
//  AxcUIKit
//
//  Created by mac on 2018/9/1.
//  Copyright © 2018年 Axc_5324. All rights reserved.
//

#import "UIImage+XJIamge.h"

@implementation UIImage (XJIamge)



/**
 图片裁剪，适用于圆形头像之类
 
 @param image 要切圆的图片
 @param borderWidth 边框的宽度
 @param color 边框的颜色
 @return 切圆的图片
 */
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color
{
    // 图片的宽度和高度
    CGFloat imageWH = image.size.width;
    
    // 设置圆环的宽度
    CGFloat border = borderWidth;
    
    // 圆形的宽度和高度
    CGFloat ovalWH = imageWH + 2 * border;
    
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    // 2.画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [color set];
    
    [path fill];
    
    // 3.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [clipPath addClip];
    
    // 4.绘制图片
    [image drawAtPoint:CGPointMake(border, border)];
    
    // 5.获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    return clipImage;
}


/**
 根据文字生成水印图片
 
 @param imageName 图片
 @param str 水印文字
 @param point 绘制水印文字的起始点
 @param dict 水印文字的属性字典
 @return 返回图片
 */
+ (UIImage *)imageWithWaterMarkImage:(NSString *)imageName text:(NSString *)str textPoint:(CGPoint)point textAttributes:(NSDictionary *)dict
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //把图片画上去
    [image drawAtPoint:CGPointZero];
    
    //绘制文字到图片
    [str drawAtPoint:point withAttributes:dict];
    
    // 从上下文获取图片
    UIImage *imageWater = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return imageWater;
}

/**
 根据图片生成水印图片
 
 @param image 图片
 @param waterImage 水印图片
 @param rect 水印图片的位置
 @return 返回图片
 */
+ (UIImage *)imageWithWaterMarkImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect{
    
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

/**
 截屏或者截取某个view视图
 
 @param captureView 要截取的view视图
 @return 返回截图
 */
+ (UIImage *)imageWithCaptureView:(UIView *)captureView
{
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, NO, 0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把控件上的图层渲染到上下文
    [captureView.layer renderInContext:ctx];
    
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return screenImage;
    
}


/**
 根据颜色生成图片
 
 @param color 颜色
 @param size 图片的尺寸
 @return 返回生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 图片的等比例缩放
 
 @param image 图片
 @param defineWidth 要缩放到的宽度
 @return 返回与原图片等宽高比的图片
 */
+ (UIImage *)imageWithOriginImage:(UIImage *)image scaleToWidth:(CGFloat)defineWidth
{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

/**
 根据图片名返回一张能够自由拉伸的图片
 
 @param name 图片名
 @param width 自由拉伸的宽度
 @param height 自由拉伸的高度
 @return 返回图片
 */
+ (UIImage *)imageWithResizedImage:(NSString *)name capWidth:(CGFloat)width capHeight:(CGFloat)height
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:width topCapHeight:height];
}



@end
