//
//  ZYCornerRadiusViewController.m
//  AxcUIKit
//
//  ZYCornerRadius 演示：UIImageView 高效圆角（预裁 UIImage，非 UIView 通用）
//

#import "ZYCornerRadiusViewController.h"
#import "UIImageView+CornerRadius.h"

@interface ZYCornerRadiusViewController ()
@end

@implementation ZYCornerRadiusViewController

- (UIImage *)demoImage {
    UIImage *img = [UIImage imageNamed:@"found_icons_4"];
    if (img) { return img; }
    img = [UIImage imageNamed:@"add_Image"];
    if (img) { return img; }
    CGSize size = CGSizeMake(150, 150);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [[UIColor colorWithRed:0.2 green:0.55 blue:0.85 alpha:1] setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    [[UIColor whiteColor] setFill];
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(35, 35, 80, 80)];
    [circle fill];
    UIImage *generated = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return generated;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:scroll];

    CGFloat w = self.view.bounds.size.width;
    CGFloat x = (w - 150) / 2.0;
    CGFloat y = 12;

    UILabel *note = [[UILabel alloc] initWithFrame:CGRectMake(16, y, w - 32, 10)];
    note.numberOfLines = 0;
    note.font = [UIFont systemFontOfSize:12];
    note.textColor = [UIColor colorWithRed:0.55 green:0.25 blue:0.1 alpha:1];
    note.backgroundColor = [UIColor colorWithRed:1 green:0.95 blue:0.88 alpha:1];
    note.layer.cornerRadius = 6;
    note.clipsToBounds = YES;
    note.text = @"  本库仅适用于 UIImageView。\n"
                @"  原理：KVO 监听 image → Bezier 裁剪路径 → 渲染进位图 → 写回 image。\n"
                @"  不能原样扩成 UIView 分类（按钮/Label 无 image 可裁）。\n"
                @"  通用圆角请看同组「UIView通用圆角」，或扩展类「快速切圆角」。  ";
    note.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    CGSize noteSize = [note sizeThatFits:CGSizeMake(w - 32, CGFLOAT_MAX)];
    note.frame = CGRectMake(16, y, w - 32, noteSize.height + 12);
    [scroll addSubview:note];
    y = CGRectGetMaxY(note.frame) + 16;

    UIImage *image = [self demoImage];

    UILabel *tip1 = [[UILabel alloc] initWithFrame:CGRectMake(20, y, w - 40, 20)];
    tip1.text = @"圆形圆角 (initWithRoundingRectImageView)";
    tip1.font = [UIFont systemFontOfSize:13];
    tip1.textColor = [UIColor darkGrayColor];
    tip1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [scroll addSubview:tip1];
    y += 28;

    UIImageView *imageView = [[UIImageView alloc] initWithRoundingRectImageView];
    imageView.frame = CGRectMake(x, y, 150, 150);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = image;
    [scroll addSubview:imageView];
    y += 150 + 20;

    UILabel *tip2 = [[UILabel alloc] initWithFrame:CGRectMake(20, y, w - 40, 20)];
    tip2.text = @"指定角圆角 (initWithCornerRadiusAdvance:)";
    tip2.font = [UIFont systemFontOfSize:13];
    tip2.textColor = [UIColor darkGrayColor];
    tip2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [scroll addSubview:tip2];
    y += 28;

    UIImageView *imageViewSecond = [[UIImageView alloc] initWithCornerRadiusAdvance:20.f
                                                                     rectCornerType:UIRectCornerBottomLeft | UIRectCornerTopRight];
    imageViewSecond.frame = CGRectMake(x, y, 150, 150);
    imageViewSecond.contentMode = UIViewContentModeScaleAspectFill;
    imageViewSecond.image = image;
    [scroll addSubview:imageViewSecond];
    y += 150 + 20;

    UILabel *tip3 = [[UILabel alloc] initWithFrame:CGRectMake(20, y, w - 40, 20)];
    tip3.text = @"后置设置 + 边框 (zy_cornerRadiusAdvance:)";
    tip3.font = [UIFont systemFontOfSize:13];
    tip3.textColor = [UIColor darkGrayColor];
    tip3.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [scroll addSubview:tip3];
    y += 28;

    UIImageView *imageViewThird = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 150, 150)];
    [imageViewThird zy_cornerRadiusAdvance:20.f rectCornerType:UIRectCornerBottomRight | UIRectCornerTopLeft];
    [imageViewThird zy_attachBorderWidth:5.f color:[UIColor blackColor]];
    imageViewThird.contentMode = UIViewContentModeScaleAspectFill;
    imageViewThird.image = image;
    [scroll addSubview:imageViewThird];
    y += 150 + 40;

    scroll.contentSize = CGSizeMake(w, y);
}

@end
