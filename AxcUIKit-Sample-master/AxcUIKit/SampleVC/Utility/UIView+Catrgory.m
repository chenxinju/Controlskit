//
//  UIView+Catrgory.m
//  JobProject
//
//  Created by Graduation on 16/12/14.
//  Copyright © 2016年 Graduation. All rights reserved.
//

#import "UIView+Catrgory.h"

@implementation UIView (Catrgory)

#pragma mark - Metric properties

- (CGFloat)leftX
{
    return self.frame.origin.x;
}
- (void)setLeftX:(CGFloat)leftX
{
    self.frame = CGRectMake(leftX, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)rightX
{
    return self.frame.origin.x + self.bounds.size.width;
}
- (void)setRightX:(CGFloat)rightX
{
    self.frame = CGRectMake(rightX-self.bounds.size.width, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}


- (CGFloat)topY
{
    return self.frame.origin.y;
}
- (void)setTopY:(CGFloat)topY
{
    self.frame = CGRectMake(self.frame.origin.x, topY, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)bottomY
{
    return self.frame.origin.y + self.bounds.size.height;
}
- (void)setBottomY:(CGFloat)bottomY
{
    self.frame = CGRectMake(self.frame.origin.x, bottomY-self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
}


- (CGFloat)width
{
    return self.bounds.size.width;
}
- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.bounds.size.height);
}

- (CGFloat)height
{
    return self.bounds.size.height;
}
- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, height);
}


- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGSize)size
{
    return self.bounds.size;
}
- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}



#pragma mark - Image content

- (UIImage *)imageRep
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



#pragma mark - Placing

- (void)occupySuperview
{
    if ( self.superview ) {
        self.frame = self.superview.bounds;
    }
}

- (void)moveToCenterOfSuperview
{
    if ( self.superview ) {
        CGRect frm = CGRectMake((self.superview.bounds.size.width - self.bounds.size.width) / 2.0,
                                (self.superview.bounds.size.height - self.bounds.size.height) / 2.0,
                                self.bounds.size.width,
                                self.bounds.size.height);
        self.frame = frm;
    }
}

- (void)moveToVerticalCenterOfSuperview
{
    if ( self.superview ) {
        CGRect frm = CGRectMake(self.frame.origin.x,
                                (self.superview.bounds.size.height - self.bounds.size.height) / 2.0,
                                self.bounds.size.width,
                                self.bounds.size.height);
        self.frame = frm;
    }
}

- (void)moveToHorizontalCenterOfSuperview
{
    if ( self.superview ) {
        CGRect frm = CGRectMake((self.superview.bounds.size.width - self.bounds.size.width) / 2.0,
                                self.frame.origin.y,
                                self.bounds.size.width,
                                self.bounds.size.height);
        self.frame = frm;
    }
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

- (void)drawRectDashLineViewWithLineColor:(UIColor *)color {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 2;
    shapeLayer.lineDashPattern = @[@4, @4];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = color.CGColor;
    
    shapeLayer.bounds = self.bounds;
    shapeLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shapeLayer.bounds];
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)removeDashLine {
    
    CALayer *layer = [self.layer.sublayers firstObject];
    if (layer != nil && [layer isKindOfClass:[CAShapeLayer class]]) {
        CAShapeLayer *shapeLayer = (CAShapeLayer *)layer;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        shapeLayer.opacity = 0.0;
        [shapeLayer removeFromSuperlayer];
    }
}

@end
