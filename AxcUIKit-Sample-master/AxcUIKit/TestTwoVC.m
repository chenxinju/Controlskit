//
//  TestTwoVC.m
//  AxcUIKit
//
//  Created by Axc on 2017/6/3.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//


/**
 
 这个是测试控件属性和运行情况的VC，如果控件各项属性设置正常即可创建一个示例VC作为展示组，此VC不为展示使用
 
 */
#import "TestTwoVC.h"
#import "FMGlobal.h"


@interface TestTwoVC ()

{
    UIView *view;
    UIImageView *imageV;
}
@property (strong, nonatomic) NSDictionary *barrageDic;


@end

@implementation TestTwoVC


#pragma mark - 1.懒加载数据

#pragma mark - 2.初始化控制器

#pragma mark - 3.控制器的声明周期
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //如果有多个设置，用setup开头，如果有多个加载网络数据，用load开头
    //生成子控件
    [self setupSubViews];
    //设置基本属性
    [self setupBasicAttr];
    //获取网络数据
    [self loadNewData];
    //设置tableview
    [self setupTableView];
}
#pragma mark - 4.生成子控件
- (void)setupSubViews{
    
}
#pragma mark - 4.5 设置tableview
- (void)setupTableView{
    
}
#pragma mark - 5.设置通知，观察者，navigation，items,tableview等基本属性
- (void)setupBasicAttr{
    
}
#pragma mark - 6.私有方法

#pragma mark - 7.对外的方法

#pragma mark - 8.加载网络数据
- (void)loadNewData{
    
    
   // NSString *testStr = @"mRQuTBb+Y8fHTkIkNVyeRw3W5zEVKDrv3gROmxB5Qs2pJ3q/s8ME2RBLw+0JhNTM0UQlkqbcDYjPXDqZvnVBsA/K82bp1Ozxn38coSDbtmomqhnLXmdyBs0i+XpOUlC62xaCsFOh2VUhjsvU9EePWpBrMZSAh+uvrord2VwcBqU=uOBY6Olp93bizAVURzdVlse4cYI70RbVRYmL4a6ez8eQSYb1hTW4s+2gg+Zj39xhCXFP5wntaDwsqaL6RYw1muNE5oyjtiZZPCYrTfag3qHPjgTjFGtI8MflBe4JWTuCvw/sVKX9Xoc8lwtOVyhOaPXOANsTUeh8bQLSUsozvQQ=Tshtv8r0XPAe1PzQoxwW/pDJwysxRweeOvsKp4NrSBVMGlk3UmtgTRcaN8EdnYzdaPlMbrSmnvtPpoadr32fkva8U/S4lZqTiPo3WbVTMQ0r/xplHDbG1Wk/o25xMM8RoM+5hd9KYw4q5tAum9PDhtb8EnASAvawxg3ijQlJYEo=BqwGp1MaUyYMgpKEB3cZyxqq/zngbKSekAx9HuLYUbjD3fATdhDDKs+HQOCxApJi0gRSFSjOZgg96vlWwpw1C2Rie8XCRrgctNHz12huMd6ULQfot9MTA63mV6XrBlqij2zIsFM0TRhjz4EeYukN7EsK3zQ9w+SweK7B8VScwI8=toe8PIlLukTNQn3qPOposxQtg+r5U4TrRUIouXGoCOvyUe4BOx+ABBQU9ToQT5iSUiUqDJ0oXfUMHs35pHsDuGGmG3qYJBoHkPa6XVPqrSB2GYzw5FrRr3KJivCOSrttzOMuiPw29k+21zPlbt/+7KwtB0fekRk4L8yTyoV4u2s=vZ5uPtBCHXeE8leFn182mul6GKnxPRevyGvuGZalR3j9NVleIiHJ/rd0uaqWhw+Qn44CGeuUVRPyhBDmvXp7SxJyKRU4qj5pCQNHmHPqtwzY6yc/5QKEZeIok9A4tOyLmnUN05/NK8Lpxm7FB/Z732mIaN1bYmAcKdq+K5UldCE=ZgvqjEBoOh+sBVAywhtVVpmQ5JcBnWY4otf1xCxJQPRp82uBMmNg7+47GLmJcnNU0eascxhLCbMq+21vftQUpOO9ST2p7Eh1A7M/vmRQU7CXy8E3pbOHIADbWG+oMzHnM6+vSNnWGDk/Pq48TqZDVqRDZn+26ZxYlB9OmvDHTZ8=ZzfhKfYtt6mbSftMTy/sZradn+7CR4SQJmjZ0IoqaQtX/uZ/TgYcJ2U4auNkcaec/k+L8GdiuzkRMpAtaOR669PzajsAkbHH1kivLpBs94MEVslphTj6jCUpl7ilIrW5z7e0Cnjv5oKaPV5q3k2MsNK5Kmz99d0wy9riaxBU+hY=";
    
//    NSDictionary *dic =  [FMGlobal getRealDicOf:testStr];
//
//    NSLog(@"解密 --------%@",dic);
    
      NSString *test  = @"测定时的弧度忘掉速度爱的撒旦坚实的尽快哈市抠脚大汉看见爱上大健康";
      NSLog(@"加密文字--%@",test);
      NSString *jiami  =  [FMGlobal encryptString:test];
      NSLog(@"加密前---%@",jiami);
    
    
      NSString *jiemi  =  [FMGlobal decryptString:jiami];
      NSLog(@"解密后---%@",jiemi);
    
    
    
    
    
}
#pragma mark - 9.通过数据更新UI
- (void)updateSubViews{
    
}
#pragma mark - 10.设置数据源方法

#pragma mark - 11.设置代理方法




@end
