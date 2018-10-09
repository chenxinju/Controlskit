//
//  UIImage+AxcQRCode.h
//  AxcUIKit
//
//  Created by Axc on 2017/6/29.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AxcQRCode)




/**
 *  1.生成一个二维码
 *
 *  @param string 字符串
 *  @param width  二维码宽度
 *
 *  @return UIImage
 */
+ (UIImage *_Nonnull)AxcUI_codeImageWithString:(NSString *_Nullable)string
                                          size:(CGFloat)width;

/**
 *  2.生成一个二维码
 *
 *  @param string 字符串
 *  @param width  二维码宽度
 *  @param color  二维码颜色
 *
 *  @return UIImage
 */
+ (UIImage *_Nonnull)AxcUI_codeImageWithString:(NSString *_Nullable)string
                                          size:(CGFloat)width
                                         color:(UIColor *_Nullable)color;
/**
 *  3.生成一个二维码
 *
 *  @param string    字符串
 *  @param width     二维码宽度
 *  @param color     二维码颜色
 *  @param icon      头像
 *  @param iconWidth 头像宽度，建议宽度小于二维码宽度的1/4
 *
 *  @return UIImage
 */
+ (UIImage *_Nonnull)AxcUI_codeImageWithString:(NSString *_Nullable)string
                                          size:(CGFloat)width
                                         color:(UIColor *_Nullable)color
                                          icon:(UIImage *_Nullable)icon
                                     iconWidth:(CGFloat)iconWidth;


/**
 生成二维码图片

 @param dataDic 二维码中的信息
 @param size 二维码Size
 @param waterImage 水印图片
 @return 一个二维码图片，水印在二维码中央
 */
+ (UIImage *)qrCodeImageForDataDic:(NSDictionary *)dataDic size:(CGSize)size waterImage:(UIImage *)waterImage;

/**
 修改二维码颜色

 @param image 二维码图片
 @param red red
 @param green green
 @param blue blue
 @return 修改颜色后的二维码图片
 */
+ (UIImage *)changeColorWithQRCodeImage:(UIImage *)image red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;

@end
