//
//  RadarViewController.m
//  RadarDemo
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 吴凯锋 QQ:24272779. All rights reserved.
//

#import "RadarViewController.h"
#import "WKFRadarView.h"
@interface RadarViewController ()

@end

@implementation RadarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"雷达扫描";
    float KMainWidth = [UIScreen mainScreen].bounds.size.width;
    float KMainHeight = [UIScreen mainScreen].bounds.size.height;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    WKFRadarView*  radarView = [[WKFRadarView alloc]initWithFrame:CGRectMake(0, (KMainHeight-KMainWidth)/2, KMainWidth, KMainWidth) andThumbnail:@"logo"];
    [self.view addSubview:radarView];
    
   
    [NSTimer scheduledTimerWithTimeInterval:1 target:radarView selector:@selector(addOrReplaceItem) userInfo:nil repeats:YES];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
