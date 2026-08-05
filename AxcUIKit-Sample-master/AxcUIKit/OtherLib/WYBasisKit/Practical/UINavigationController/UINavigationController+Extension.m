//
//  UINavigationController+Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/19.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "UINavigationController+Extension.h"
#include <objc/runtime.h>

@implementation UINavigationController (Extension)

- (void)navigationBarTransparent {
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationBar.translucent = YES;
}

- (void)navigationBarOpaque {
    
    self.navigationBar.translucent = NO;
    [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:nil];
}

- (UIColor *)titleColor {
    
    UIColor *obj = objc_getAssociatedObject(self, &@selector(titleColor));
    
    return obj;
}
- (void)setTitleColor:(UIColor *)titleColor {
    
    objc_setAssociatedObject(self, &@selector(titleColor), titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : (titleColor ? titleColor : [UIColor blackColor]),
                                                 NSFontAttributeName : (self.titleFont ? self.titleFont : [UIFont fontWithName:@"Helvetica-Bold" size:17])}];
}

- (UIFont *)titleFont {
    
    UIFont *obj = objc_getAssociatedObject(self, &@selector(titleFont));
    
    return obj;
}
- (void)setTitleFont:(UIFont *)titleFont {
    
    objc_setAssociatedObject(self, &@selector(titleFont), titleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : (self.titleColor ? self.titleColor : [UIColor blackColor]),
                                                 NSFontAttributeName : (titleFont ? titleFont : [UIFont fontWithName:@"Helvetica-Bold" size:17])}];
}

- (UIColor *)barBackgroundColor {
    
    UIColor *obj = objc_getAssociatedObject(self, &@selector(barBackgroundColor));
    
    return obj;
}
- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    
    objc_setAssociatedObject(self, &@selector(barBackgroundColor), barBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationBar setBackgroundImage:[UIImage createImage:barBackgroundColor] forBarMetrics:UIBarMetricsDefault];
}

- (UIImage *)barBackgroundImage {
    
    UIImage *obj = objc_getAssociatedObject(self, &@selector(barBackgroundImage));
    
    return obj;
}

- (void)setBarBackgroundImage:(UIImage *)barBackgroundImage {

    objc_setAssociatedObject(self, &@selector(barBackgroundImage), barBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationBar setBackgroundImage:barBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)hidesNavigationBarsOnSwipe {
    
    self.hidesBarsOnSwipe = YES;
}

- (UIImage *)barReturnButtonImage {
    
    UIImage *obj = objc_getAssociatedObject(self, &@selector(barReturnButtonImage));
    
    return obj;
}

- (void)setBarReturnButtonImage:(UIImage *)barReturnButtonImage {
    
    objc_setAssociatedObject(self, &@selector(barReturnButtonImage), barReturnButtonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.navigationBar.backIndicatorTransitionMaskImage = barReturnButtonImage;
    self.navigationBar.backIndicatorImage = barReturnButtonImage;
}

- (UIColor *)barReturnButtonColor {
    
    UIColor *obj = objc_getAssociatedObject(self, &@selector(barReturnButtonColor));
    
    return obj;
}

- (void)setBarReturnButtonColor:(UIColor *)barReturnButtonColor {
    
    objc_setAssociatedObject(self, &@selector(barReturnButtonColor), barReturnButtonColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self.navigationBar setTintColor:barReturnButtonColor];
}

- (void)barReturnButtonHide:(BOOL)hide navigationItem:(UINavigationItem *)navigationItem {
    
    navigationItem.hidesBackButton = hide;
}

- (void)pushControllerBarReturnButtonTitle:(NSString *)barReturnButtonTitle navigationItem:(UINavigationItem *)navigationItem {
    
    if(navigationItem.backBarButtonItem == nil) {
        
        navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:barReturnButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    }else {
        
        navigationItem.backBarButtonItem.title = barReturnButtonTitle;
    }
}

@end
