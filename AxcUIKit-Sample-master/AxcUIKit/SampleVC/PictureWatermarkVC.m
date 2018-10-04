//
//  PictureWatermarkVC.m
//  PictureWatermark
//
//  Created by AD-iOS on 15/8/3.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import "PictureWatermarkVC.h"
#import "UIImage+WaterMark.h"

@interface PictureWatermarkVC ()

@end

@implementation PictureWatermarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *baseImage = [UIImage imageNamed:@"placeholder.jpg"];
    
   // UIImage *resultImage = [baseImage imageWaterMarkWithString:@"陈新菊" point:CGPointMake(self.view.frame.size.width-50, 50) attribute:@{NSForegroundColorAttributeName:[UIColor purpleColor],NSFontAttributeName:[UIFont systemFontOfSize:18]} image:[UIImage imageNamed:@"airplane"] imagePoint:CGPointMake(90,90) alpha:0.2];
    
    UIImage *resultImage = [UIImage getWaterMarkImage:baseImage andTitle:@"图片水印" andMarkFont:[UIFont systemFontOfSize:18] andMarkColor:[UIColor whiteColor]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = resultImage;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
