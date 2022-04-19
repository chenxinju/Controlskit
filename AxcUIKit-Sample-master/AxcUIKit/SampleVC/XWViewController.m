//
//  XWViewController.m
//  XWHUDManager
//
//  Created by qxuewei on 08/16/2018.
//  Copyright (c) 2018 qxuewei. All rights reserved.
//

#import "XWViewController.h"

#import "XWHUDManager.h"

@interface XWViewController () <UITableViewDelegate,UITableViewDataSource>{
    NSArray *data;
    NSTimer *timer;
}
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation XWViewController

+ (void)initialize {
    [XWHUDManager configHUDType:XWHUDManagerTypeDark];
    [XWHUDManager configHUDFontSize:12.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    data = @[@"无限展示小菊花",@"在当前View展示一个小菊花",@"loading... 小菊花",@"显示隐藏自定义文本菊花",@"window上显示文本提示框",@"限时隐藏在view展示一个有文本提示框",@"正确提示",@"有文本正确提示",@"错误提示",@"有文本错误提示",@"信息提示",@"警告提示",@"自定义图片",@"序列帧",@"GIF",@"带取消事件GIF",@"自定义提示语",@"自定义View提示带事件"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:@selector(testClick)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)testClick {
    NSLog(@"点击 navigationItem 按钮");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cellID";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.textLabel.text = data[indexPath.row];
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [timer invalidate];
    switch (indexPath.row) {
        case 0:
            [XWHUDManager showHUD];
            break;
        case 1:
            [XWHUDManager showHUDInView];
            break;
        case 2:
            [XWHUDManager showHUDLoadingEN];
            break;
        case 3:
            [XWHUDManager showHUDMessage:@"加载中..." afterDelay:1.5];
            break;
        case 4:
            [XWHUDManager showTipHUD:@"www.qiuxuewei.com && www.qiuxuewei.com && www.qiuxuewei.com" isLineFeed:NO];
            break;
        case 5:
            [XWHUDManager showTipHUDInView:@"极客学伟, 加油! && www.qiuxuewei.com && && www.qiuxuewei.com " isLineFeed:YES afterDelay:3];
            break;
        case 6:
            [XWHUDManager showSuccessHUD];
            break;
        case 7:
            [XWHUDManager showSuccessTipHUD:@"加载成功"];
            break;
        case 8:
            [XWHUDManager showErrorHUD];
            break;
        case 9:
            [XWHUDManager showErrorTipHUD:@"加载失败"];
            break;
        case 10:
            [XWHUDManager showInfoTipHUD:@"信息提示"];
            break;
        case 11:
            [XWHUDManager showWarningTipHUD:@"警告提示"];
            break;
        case 12:
        {
            UIImage *image = [UIImage imageNamed:@"wildcat_gif_1"];
            [XWHUDManager showCustomImageHUD:image message:@"这是张自定义图片"];
            break;
        }
        case 13:
        {
            NSMutableArray *array = [NSMutableArray array];
            for (NSInteger i = 1; i <= 6; i++) {
                [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"wildcat_gif_%zd",i]]];
            }
            [XWHUDManager showCustomImagesHUD:array message:@"拼命加载中..."];
            break;
        }
        case 14:
        {
            UIImage *giftImage = [XWHUDManager imageGIFWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"update_loading" ofType:@"gif"]]];
            [XWHUDManager showGifImageHUDInView:giftImage message:@"\n\n若图片较大/网速较慢，请耐心等待\n" backgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]  textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] textFont:[UIFont systemFontOfSize:10.0] alpha:0.9 timer:0.0];
            break;
        }
        case 15:
        {
            UIImage *giftImage = [XWHUDManager imageGIFWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"update_loading" ofType:@"gif"]]];
            
            [XWHUDManager showGifImageHUDInView:giftImage message:@"\n\n若图片较大/网速较慢，请耐心等待\n" backgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0] textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] textFont:[UIFont systemFontOfSize:10.0] alpha:1 timer:0 isCancel:YES closeBlock:^{
                
                [XWHUDManager showInfoTipHUD:@"取消了"];
            }];
            break;
        }
        case 16:
        {
            
            [XWHUDManager showAlertMessage:@"已添加到下载任务列表" isWindow:YES position:MBProgressHUBPositionBottom timer:2.5 confirmBlock:^{
                [XWHUDManager hideInWindow];
                
                NSLog(@"点确认");
            }];
            
            
            break;
        }
        case 17:
            {
                CGFloat offsetY = [UIScreen mainScreen].bounds.size.height;
                [XWHUDManager showCustomTipHUD:@"这是个自定义的提示框 - 极客学伟加油! 这是个自定义的提示框 - 极客学伟加油!  这是个自定义的提示框 - 极客学伟加油!  这是个自定义的提示框 - 极客学伟加油!" iscustomView:YES position:MBProgressHUBPositionBottom isLineFeed:YES backgroundColor:nil textColor:nil textFont:nil margin:10 offset:CGPointMake(0, offsetY) isWindow:NO timer:2 confirmBlock:^{
                    NSLog(@"去查看");
                }];
                
                break;
            }
            
        default:
            break;
        }
            
            timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(hideMthod) userInfo:nil repeats:NO];
    }

- (void)hideMthod {
    [XWHUDManager hide];
}


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        _tableView.contentInset = UIEdgeInsetsMake(0, 0,0, 0);
    }
    return _tableView;
}
@end
