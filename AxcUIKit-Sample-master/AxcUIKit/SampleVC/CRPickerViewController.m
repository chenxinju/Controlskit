//
//  CRPickerViewController.m
//  AxcUIKit
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 Axc_5324. All rights reserved.
//

#import "CRPickerViewController.h"

#import "CRPrivenceModel.h"
#import "PrivencePickerView.h"
#import "StreetPickerView.h"

@interface CRPickerViewController ()<
UITableViewDelegate,
UITableViewDataSource
>


@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,assign)CGFloat showTime;

//字符串选择
@property (nonatomic, strong) StreetPickerView *operatorPickerView;
//三级地址
@property (nonatomic, strong) NSMutableArray *privences;
@property (nonatomic, strong) PrivencePickerView *privencePickerView;

@end

@implementation CRPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.showTime = 1;
    [self.view addSubview:self.tableView];
}

#pragma mark - 逻辑触发区
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = self.dataArray[indexPath.section];
    NSString *showText = arr[indexPath.row];
    switch (indexPath.section) {
            // 随时可以调用，方便调试时查看各项参数 ************************************************
        case 0: // 顶部
            switch (indexPath.row) {
                case 0:
                    [self.privencePickerView show];
                   
                    break;
                case 1:
                    [self.privencePickerView show];
                    break;
                case 2:
                    [AxcUI_Toast AxcUI_showTopWithText:showText topOffset:100];
                    break;
                case 3:
                    [AxcUI_Toast AxcUI_showTopWithText:showText topOffset:100 duration:_showTime];
                    break;
                default:
                    break;
            }
            break;
        case 1: // 中部
            switch (indexPath.row) {
                case 0:
                   [self.operatorPickerView show];
                    break;
                case 1:
                    [AxcUI_Toast AxcUI_showCenterWithText:showText duration:_showTime];
                    break;
                default:break;
            }
            break;
        case 2: // 下部
            switch (indexPath.row) {
                case 0:[AxcUI_Toast AxcUI_showBottomWithText:showText];break;
                case 1:[AxcUI_Toast AxcUI_showBottomWithText:showText duration:_showTime];break;
                case 2:[AxcUI_Toast AxcUI_showBottomWithText:showText bottomOffset:100];break;
                case 3:[AxcUI_Toast AxcUI_showBottomWithText:showText bottomOffset:100 duration:_showTime];break;
                default:break;
            }
            break;
            
        default:break;
    }
}


#pragma mark - 代理区
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArray[section];
    return arr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Axc"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Axc"];
    }
    NSArray *arr = self.dataArray[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor AxcUI_colorWithHexCode:@"1296db"];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.titleArray[section];
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
#pragma mark - 懒加载区

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"城市选择器",@"字符串类型选择器",@"其他"];
    }
    return _titleArray;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@[@"两级城市",@"三级城市",@"四级城市"],
                       @[@"运营商",@"性别"],
                       @[@"下方显示",@"下方显示+自定义停留时间",@"下方显示+自定义距底端距离",@"下方显示+自定义距底端距离+自定义停留时间"]];
    }
    return _dataArray;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
        _tableView.axcUI_Y = _tableView.axcUI_Y + 10;
        _tableView.axcUI_Height = _tableView.axcUI_Height - 10;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


- (NSMutableArray *)privences{
    if (_privences == nil) {
        NSMutableArray *arrM = [NSMutableArray array];
        //获得文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CityData.json" ofType:nil];
        //将文件数据转化为二进制数据
        NSData *data = [NSData dataWithContentsOfFile:path];
        //把二进制数据转化为字典数组
        NSDictionary *arrJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //遍历字典转模型,将模型添加到数组中
        [arrJson[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CRPrivenceModel *product = [CRPrivenceModel privenceWithDict:obj];
            [arrM addObject:product];
        }];
        _privences = arrM;
    }
    return _privences;
}

- (PrivencePickerView *)privencePickerView {
    if (!_privencePickerView) {
//        @weakify(self)
        _privencePickerView = [PrivencePickerView selectPrivenceWithPrivenceArr:self.privences back:^(NSString *streets,long PrivenceAreaCode,NSString *CityAreaCode) {
            if (![streets isEqualToString:@""] && streets != nil) {
                if ([streets isEqualToString:@"不限      不限"]) {
                    streets = @"不限";
                }
                 [AxcUI_Toast AxcUI_showTopWithText:streets];
            }
        }];
    }
    return _privencePickerView;
}

- (StreetPickerView *)operatorPickerView{
    if (!_operatorPickerView) {
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:@[@"不限",@"移动",@"联通",@"电信"]];
        _operatorPickerView = [StreetPickerView selectStreetWithStreetArr:arrM back:^(NSString *streets, NSInteger OperatorCode) {
            if (![streets isEqualToString:@""] && streets != nil) {
                [AxcUI_Toast AxcUI_showCenterWithText:streets duration:_showTime];
            }
        }];
    }
    return _operatorPickerView;
}

@end
