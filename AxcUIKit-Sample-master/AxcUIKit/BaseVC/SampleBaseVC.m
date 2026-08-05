//
//  SampleBaseVC.m
//  AxcUIKit
//
//  Created by Axc on 2017/6/3.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import "SampleBaseVC.h"


@interface SampleBaseVC ()


@property(nonatomic, assign) CGFloat instructionsLabelHeight;


@end

@implementation SampleBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.instructionsLabelHeight = 100;
    
//    if (@available(iOS 11.0, *)) {
//        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        // Fallback on earlier versions
//    }
    
    
    // 设置Bar半透明属性
    //    self.navigationController.navigationBar.translucent               = YES;
    
    // 设置开启Push后右滑返回手势
    //    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    // 设置取消ScrollerView自适应属性
    //    self.automaticallyAdjustsScrollViewInsets                         = NO;
    
    // 设置默认滑动时不隐藏NavBar导航条
    //    self.navigationController.hidesBarsOnSwipe                        = NO;
    
    // 设置子类的NavBar上的渲染颜色
    //    self.navigationController.navigationBar.tintColor         = [UIColor whiteColor];
    
    // 设置NavBar底层View的颜色
    //    self.navigationController.navigationBar.backgroundColor   = [UIColor clearColor];
    
    // 设置NavBar顶层View的颜色
    //    self.navigationController.navigationBar.barTintColor      = [UIColor clearColor];
    
    // 设置子类的Tabbar风格
    //    self.navigationController.navigationBar.barStyle          = UIBarStyleBlack;
    
}
- (void)AxcBase_addRightBarButtonItems:(NSArray *)items{
    NSMutableArray *arr_M = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:obj
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(AxcBase_clickRightItems:)];
        btn.tag = idx + 5324;
        [arr_M addObject:btn];
    }];
    self.navigationItem.rightBarButtonItems = arr_M;
}
- (void)AxcBase_clickRightItems:(UIBarButtonItem *)sender{}


- (void)AxcBase_addRightBarButtonItemSystemItem:(UIBarButtonSystemItem)systemItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:systemItem
                                              target:self
                                              action:@selector(AxcBase_clickRightBtn:)];
}
- (void)AxcBase_clickRightBtn:(UIBarButtonItem *)sender{}


// MARK:Alent函数
// 弹出一个Alent
- (void)AxcBase_PopAlertViewWithTitle:(NSString *)title
                              Message:(NSString *)message
                              Actions:(NSArray <NSString *>*)actions
                              handler:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [actions enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           handler(action);
                                                       }];
        [alertController addAction:action];
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 弹出一个警告框
- (void)AxcBase_PopAlertWarningMessage:(NSString *)message{
    [self AxcBase_PopAlertViewWithTitle:@"警告"
                                Message:message
                                Actions:@[@"确定"]
                                handler:nil];
}
// 弹出一个提示框
- (void)AxcBase_PopAlertPromptMessage:(NSString *)message
                            OKHandler:(void (^ __nullable)(UIAlertAction *action))OKHandler
                        cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler{
    [self AxcBase_PopAlertViewWithTitle:@"提示"
                                Message:message
                                Actions:@[@"确定",@"取消"]
                                handler:^(UIAlertAction * _Nonnull action) {
                                    if ([action.title isEqualToString:@"确定"]) {
                                        OKHandler(action);
                                    }else cancelHandler(action);
                                }];
}


- (UILabel *)instructionsLabel{
    if (!_instructionsLabel) {
        _instructionsLabel = [[AxcUI_Label alloc] init];
        _instructionsLabel.font = [UIFont systemFontOfSize:15];
        _instructionsLabel.textAlignment = NSTextAlignmentCenter;
        _instructionsLabel.textColor = [UIColor AxcUI_AmethystColor];
        _instructionsLabel.backgroundColor = [UIColor AxcUI_CloudColor];
        _instructionsLabel.alpha = 0.8;
        _instructionsLabel.numberOfLines = 0;
        _instructionsLabel.axcUI_textEdgeInsets = UIEdgeInsetsMake(0,10,0,10);
        _instructionsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_instructionsLabel];
        // 用约束固定到底部安全区，避免导航栏调整/视图frame时序问题导致被挤出屏幕
        [NSLayoutConstraint activateConstraints:@[
            [_instructionsLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [_instructionsLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [_instructionsLabel.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
            [_instructionsLabel.heightAnchor constraintEqualToConstant:self.instructionsLabelHeight]
        ]];
    }
    return _instructionsLabel;
}


- (void)dealloc{
    // 只要控制器执行此方法，代表VC以及其控件全部已安全从内存中撤出。
    // ARC除去了手动管理内存，但不代表能控制循环引用，虽然去除了内存销毁概念，但引入了新的概念--对象被持有。
    // 框架在使用后能完全从内存中销毁才是最好的优化
    // 不明白ARC和内存泄漏的请自行谷歌，此示例已加入内存检测功能，如果有内存泄漏会alent进行提示
    NSLog(@"控制器%s调用情况，已销毁%@",__func__,self);
}

@end

#pragma mark - AxcNavigationController

@implementation AxcNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AxcNavigationController axc_applyDefaultAppearanceToNavigationBar:self.navigationBar];
    self.interactivePopGestureRecognizer.enabled = YES;
}

+ (void)axc_applyDefaultAppearanceToNavigationBar:(UINavigationBar *)navigationBar {
    navigationBar.translucent = NO;
    navigationBar.barTintColor = [UIColor whiteColor];
    navigationBar.tintColor = [UIColor blackColor];
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor whiteColor];
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
        appearance.shadowColor = [UIColor colorWithWhite:0.85 alpha:1.0];
        navigationBar.standardAppearance = appearance;
        navigationBar.scrollEdgeAppearance = appearance;
        navigationBar.compactAppearance = appearance;
    }
}

@end

#pragma mark - AxcNavigationTitleView

@interface AxcNavigationTitleView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@end

@implementation AxcNavigationTitleView

+ (instancetype)viewWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 120.0;
    AxcNavigationTitleView *titleView = [[AxcNavigationTitleView alloc] initWithFrame:CGRectMake(0, 0, width, 44.0)];
    titleView.titleLabel.text = title;
    titleView.subtitleLabel.text = subtitle;
    [titleView setNeedsLayout];
    return titleView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_titleLabel];

        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:11.0];
        _subtitleLabel.textColor = [UIColor darkGrayColor];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:_subtitleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.subtitleLabel.text.length > 0) {
        self.titleLabel.frame = CGRectMake(0, 2.0, self.bounds.size.width, 20.0);
        self.subtitleLabel.frame = CGRectMake(0, 22.0, self.bounds.size.width, 16.0);
        self.subtitleLabel.hidden = NO;
    } else {
        self.titleLabel.frame = self.bounds;
        self.subtitleLabel.hidden = YES;
    }
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 44.0);
}

@end
