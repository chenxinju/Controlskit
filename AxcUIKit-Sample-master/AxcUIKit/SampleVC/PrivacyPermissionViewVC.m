//
//  PrivacyPermissionViewVC.m
//  PrivacyPermissionExample
//
//  Created by BANYAN on 2017/11/19.
//  Copyright © 2017年 PrivacyPermission. All rights reserved.
//

#import "PrivacyPermissionViewVC.h"
#import "PrivacyPermission.h"

@interface PrivacyPermissionViewVC () <UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *titleArray;
@end

@implementation PrivacyPermissionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI
- (void)initUI {
    _titleArray = @[NSLocalizedString(@"打开相册权限", nil),
                    NSLocalizedString(@"打开相机权限", nil),
                    NSLocalizedString(@"打开媒体资料库权限", nil),
                    NSLocalizedString(@"打开麦克风权限", nil),
                    NSLocalizedString(@"打开位置权限", nil),
                    NSLocalizedString(@"打开蓝牙权限", nil),
                    NSLocalizedString(@"打开推送权限", nil),
                    NSLocalizedString(@"打开语音识别权限", nil),
                    NSLocalizedString(@"打开日历权限", nil),
                    NSLocalizedString(@"打开通讯录权限", nil),
                    NSLocalizedString(@"打开提醒事项权限", nil),
                    NSLocalizedString(@"打开运动与健身权限", nil)
                    ];
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = YES;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textAlignment = 0;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypePhoto completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 1:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypeCamera completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 2:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypeMedia completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 3:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypeMicrophone completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 4:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypeLocation completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 5:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypeBluetooth completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 6:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypePushNotification completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 7:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypeSpeech completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 8:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypeEvent completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 9:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypeContact completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 10:{
            [[PrivacyPermission sharedInstance]accessPrivacyPermissionWithType:PrivacyPermissionTypeReminder completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        default:
            break;
    }
    [tableView reloadData];
}

@end
