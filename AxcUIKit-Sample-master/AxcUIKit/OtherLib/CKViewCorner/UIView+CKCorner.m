//
//  UIView+CKCorner.m
//  AxcUIKit
//

#import "UIView+CKCorner.h"

@implementation UIView (CKCorner)

- (void)ck_setCornerRadius:(CGFloat)radius {
    [self ck_setCornerRadius:radius corners:UIRectCornerAllCorners];
}

- (void)ck_setCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners {
    if (CGRectIsEmpty(self.bounds)) {
        [self layoutIfNeeded];
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.frame = self.bounds;
    mask.path = path.CGPath;
    self.layer.mask = mask;
}

- (void)ck_setLayerCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    // 清掉可能存在的 shape mask，避免两套圆角叠在一起
    if ([self.layer.mask isKindOfClass:[CAShapeLayer class]]) {
        self.layer.mask = nil;
    }
}

@end
