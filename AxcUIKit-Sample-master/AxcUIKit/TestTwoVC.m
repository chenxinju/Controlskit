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
    
}
#pragma mark - 9.通过数据更新UI
- (void)updateSubViews{
    
}
#pragma mark - 10.设置数据源方法

#pragma mark - 11.设置代理方法




@end
