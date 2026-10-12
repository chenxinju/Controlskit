//
//  UIViewCornerDemoViewController.m
//  AxcUIKit
//
//  演示：为何 ZYCornerRadius 不能直接扩到 UIView，以及 UIView 通用圆角怎么做。
//

#import "UIViewCornerDemoViewController.h"
#import "UIView+CKCorner.h"
#import "AxcUIKit-Swift.h"

@interface UIViewCornerDemoViewController ()
@end

@implementation UIViewCornerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:scroll];

    CGFloat w = self.view.bounds.size.width;
    CGFloat y = 16;

    y = [self addSectionTitle:@"结论：ZY 不能原样做成 UIView 分类"
                       detail:@"ZYCornerRadius 监听 image，用 UIBezierPath 裁路径后把图层画进位图，再写回 image。\n高效点在于「预烘焙圆角图」，避免 masksToBounds 离屏渲染。\nUIView / UIButton / UILabel 没有可裁的 image 内容，同一套手法不适用。"
                        atY:y width:w inScroll:scroll];

    y = [self addSectionTitle:@"方案 A：CAShapeLayer mask（支持指定角）"
                       detail:@"适用于任意 UIView 子类。项目内 AxcUI_rectCorner / UIView+CKCorner 同此思路。"
                        atY:y width:w inScroll:scroll];

    // UIView
    UIView *box = [[UIView alloc] initWithFrame:CGRectMake(24, y, 100, 70)];
    box.backgroundColor = [UIColor colorWithRed:0.25 green:0.55 blue:0.95 alpha:1];
    [scroll addSubview:box];
    [self addCaption:@"UIView" under:box inScroll:scroll];

    // UIButton
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(140, y, 100, 70);
    btn.backgroundColor = [UIColor colorWithRed:0.2 green:0.75 blue:0.45 alpha:1];
    [btn setTitle:@"Button" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scroll addSubview:btn];
    [self addCaption:@"UIButton" under:btn inScroll:scroll];

    // UILabel
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(256, y, 100, 70)];
    lab.backgroundColor = [UIColor colorWithRed:0.95 green:0.45 blue:0.25 alpha:1];
    lab.text = @"Label";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    [scroll addSubview:lab];
    [self addCaption:@"UILabel" under:lab inScroll:scroll];

    // apply after frames set
    [box ck_setCornerRadius:16 corners:UIRectCornerTopLeft | UIRectCornerBottomRight];
    [btn ck_setCornerRadius:16 corners:UIRectCornerAllCorners];
    [lab ck_setCornerRadius:16 corners:UIRectCornerTopRight | UIRectCornerBottomLeft];

    y += 70 + 28 + 16;

    y = [self addSectionTitle:@"方案 B：layer.cornerRadius + masksToBounds"
                       detail:@"最简单。四角相同、不指定个别角时足够。复杂列表里可能有离屏渲染成本。"
                        atY:y width:w inScroll:scroll];

    UIView *layerBox = [[UIView alloc] initWithFrame:CGRectMake(24, y, 120, 70)];
    layerBox.backgroundColor = [UIColor colorWithRed:0.55 green:0.35 blue:0.9 alpha:1];
    [scroll addSubview:layerBox];
    [layerBox ck_setLayerCornerRadius:20];
    [self addCaption:@"layer 圆角" under:layerBox inScroll:scroll];

    UIButton *layerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    layerBtn.frame = CGRectMake(160, y, 120, 70);
    layerBtn.backgroundColor = [UIColor colorWithRed:0.9 green:0.2 blue:0.4 alpha:1];
    [layerBtn setTitle:@"圆角按钮" forState:UIControlStateNormal];
    [layerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scroll addSubview:layerBtn];
    [layerBtn ck_setLayerCornerRadius:20];
    [self addCaption:@"UIButton" under:layerBtn inScroll:scroll];

    y += 70 + 28 + 16;

    y = [self addSectionTitle:@"Swift API（同等能力，UIView+CKCorner.swift）"
                       detail:@"OC：ck_setCornerRadius: / ck_setLayerCornerRadius:\nSwift：ck_applyCornerRadius / ck_applyLayerCornerRadius\n（命名错开，避免与桥接进来的 OC 方法重名）"
                        atY:y width:w inScroll:scroll];

    UIView *swiftBox = [[UIView alloc] initWithFrame:CGRectMake(24, y, 120, 70)];
    swiftBox.backgroundColor = [UIColor colorWithRed:0.15 green:0.65 blue:0.85 alpha:1];
    [scroll addSubview:swiftBox];
    // Swift extension，@objc 暴露给 OC
    [swiftBox ck_applyCornerRadius:18 corners:UIRectCornerTopLeft | UIRectCornerTopRight];
    [self addCaption:@"Swift shape" under:swiftBox inScroll:scroll];

    UILabel *swiftLab = [[UILabel alloc] initWithFrame:CGRectMake(160, y, 120, 70)];
    swiftLab.backgroundColor = [UIColor colorWithRed:0.35 green:0.55 blue:0.2 alpha:1];
    swiftLab.text = @"Swift layer";
    swiftLab.textAlignment = NSTextAlignmentCenter;
    swiftLab.textColor = [UIColor whiteColor];
    swiftLab.font = [UIFont systemFontOfSize:13];
    [scroll addSubview:swiftLab];
    [swiftLab ck_applyLayerCornerRadius:18];
    [self addCaption:@"Swift layer" under:swiftLab inScroll:scroll];

    y += 70 + 28 + 16;

    y = [self addSectionTitle:@"和本项目已有能力的关系"
                       detail:@"• 扩展类 →「快速切圆角」= UIView+AxcRectCorner（CAShapeLayer）\n• 本组「ZYCornerRadius」= 仅 UIImageView 预裁图\n• 本组本页 = UIView 通用方案对照演示（OC + Swift）"
                        atY:y width:w inScroll:scroll];

    scroll.contentSize = CGSizeMake(w, y + 40);
}

- (CGFloat)addSectionTitle:(NSString *)title detail:(NSString *)detail atY:(CGFloat)y width:(CGFloat)w inScroll:(UIScrollView *)scroll {
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(16, y, w - 32, 22)];
    t.text = title;
    t.font = [UIFont boldSystemFontOfSize:15];
    t.textColor = [UIColor colorWithRed:0.1 green:0.35 blue:0.7 alpha:1];
    t.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [scroll addSubview:t];
    y += 26;

    UILabel *d = [[UILabel alloc] initWithFrame:CGRectMake(16, y, w - 32, 10)];
    d.text = detail;
    d.numberOfLines = 0;
    d.font = [UIFont systemFontOfSize:12];
    d.textColor = [UIColor darkGrayColor];
    d.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    CGSize sz = [d sizeThatFits:CGSizeMake(w - 32, CGFLOAT_MAX)];
    d.frame = CGRectMake(16, y, w - 32, sz.height);
    [scroll addSubview:d];
    return CGRectGetMaxY(d.frame) + 12;
}

- (void)addCaption:(NSString *)text under:(UIView *)view inScroll:(UIScrollView *)scroll {
    UILabel *c = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.origin.x, CGRectGetMaxY(view.frame) + 4, view.frame.size.width, 18)];
    c.text = text;
    c.font = [UIFont systemFontOfSize:11];
    c.textColor = [UIColor grayColor];
    c.textAlignment = NSTextAlignmentCenter;
    [scroll addSubview:c];
}

@end
