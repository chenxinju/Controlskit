//
//  UIImage+CA.h
//  Charles
//
//  Created by Charles on 15-10-26.
//  Copyright (c) 2015年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CA)

#pragma mark - ImageName
//According to the different equipment return different images
//根据不同设备返回不同图片
//还是调用[UIImage imageNamed:@"demo"];这个方法

#pragma mark - Strech and Resize
//Drawing pictures
//拉伸图片
+ (UIImage *)compressImage:(UIImage *)imgSrc toSize:(CGSize)size;
//Specify the middle area drawing pictures
//指定中间区域拉伸图片
+ (UIImage *)strechImageWithName:(NSString *)imageName;
//For drawing pictures in a particular area
//制定特定区域拉伸图片
+ (UIImage *)strechImageWithName:(NSString *)imageName posX:(CGFloat)x posY:(CGFloat)y;

#pragma mark - ScreenShot
//screenshots
//截屏
+ (UIImage *)screenshot;
#pragma mark - AddImage
//Add a watermark
//添加水印
+ (UIImage *)addImage:(UIImage *)image addMsakImage:(UIImage *)maskImage maskFrame:(CGRect)pos;

#pragma mark - Color
//color
//颜色
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - Blur
//The fuzzy parameters of 0.0 ~ 1.0
//模糊 参数0.0~1.0
+ (UIImage *)blurImage:(UIImage *)src amount:(CGFloat)amount;

@end
