//
//  YCShadowViewController.m
//  AxcUIKit
//
//  YCShadowView 演示：圆角 + 阴影
//

#import "YCShadowViewController.h"
#import "YCShadowView.h"

@interface YCShadowViewController ()
@end

@implementation YCShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scroll.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:scroll];

    YCShadowView *v1 = [[YCShadowView alloc] initWithFrame:CGRectMake(50, 40, 100, 100)];
    v1.backgroundColor = [UIColor whiteColor];
    [v1 yc_shaodw];
    [v1 yc_cornerRadius:10];
    [self addLabel:@"四周阴影\n四周圆角" toView:v1];
    [scroll addSubview:v1];

    YCShadowView *v2 = [[YCShadowView alloc] initWithFrame:CGRectMake(200, 40, 100, 100)];
    v2.backgroundColor = [UIColor whiteColor];
    [v2 yc_shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeZero byShadowSide:YCShadowSideAllSides];
    [v2 yc_cornerRadius:10 byRoundingCorners:UIRectCornerTopLeft];
    [self addLabel:@"四周阴影\n单个圆角" toView:v2];
    [scroll addSubview:v2];

    YCShadowView *v3 = [[YCShadowView alloc] initWithFrame:CGRectMake(50, 190, 100, 100)];
    v3.backgroundColor = [UIColor whiteColor];
    [v3 yc_verticalShaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeZero];
    [v3 yc_cornerRadius:10 byRoundingCorners:UIRectCornerTopRight];
    [self addLabel:@"上下阴影\n单个圆角" toView:v3];
    [scroll addSubview:v3];

    YCShadowView *v4 = [[YCShadowView alloc] initWithFrame:CGRectMake(200, 190, 100, 100)];
    v4.backgroundColor = [UIColor whiteColor];
    [v4 yc_shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeZero byShadowSide:YCShadowSideRight];
    [v4 yc_cornerRadius:10 byRoundingCorners:UIRectCornerBottomLeft];
    [self addLabel:@"单边阴影\n单个圆角" toView:v4];
    [scroll addSubview:v4];

    YCShadowView *v5 = [[YCShadowView alloc] initWithFrame:CGRectMake(50, 340, 100, 100)];
    v5.backgroundColor = [UIColor whiteColor];
    [v5 yc_shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeZero byShadowSide:YCShadowSideTop];
    [v5 yc_cornerRadius:10 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    [self addLabel:@"上边阴影\n上边圆角" toView:v5];
    [scroll addSubview:v5];

    YCShadowView *v6 = [[YCShadowView alloc] initWithFrame:CGRectMake(200, 340, 100, 100)];
    v6.backgroundColor = [UIColor whiteColor];
    [v6 yc_shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeZero byShadowSide:YCShadowSideBottom];
    [v6 yc_cornerRadius:10 byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    [self addLabel:@"下边阴影\n下边圆角" toView:v6];
    [scroll addSubview:v6];

    CGFloat h = MAX(CGRectGetMaxY(v6.frame) + 80, self.view.bounds.size.height + 1);
    scroll.contentSize = CGSizeMake(self.view.bounds.size.width, h);
}

- (void)addLabel:(NSString *)text toView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.text = text;
    label.numberOfLines = 2;
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [view addSubview:label];
}

@end
