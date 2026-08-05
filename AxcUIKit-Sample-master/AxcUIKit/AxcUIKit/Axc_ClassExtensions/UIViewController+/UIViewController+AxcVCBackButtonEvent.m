//
//  UIViewController+AxcVCBackButtonEvent.m
//  AxcUIKit
//
//  Created by Axc on 2017/7/26.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import "UIViewController+AxcVCBackButtonEvent.h"
#import <objc/runtime.h>

@implementation UIViewController (AxcVCBackButtonEvent)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originSelector = @selector(viewWillDisappear:);
        SEL swizzledSelector = @selector(axc_viewWillDisappear:);

        Method originMethod = class_getInstanceMethod(class, originSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        if (originMethod && swizzledMethod) {
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)axc_viewWillDisappear:(BOOL)animated {
    [self axc_viewWillDisappear:animated];

    if (!self.isMovingFromParentViewController) {
        return;
    }

    if ([self respondsToSelector:@selector(AxcUI_navigationShouldPopOnBackButton)]) {
        [(id<AxcVCBackButtonEventProtocol>)self AxcUI_navigationShouldPopOnBackButton];
    }
    if ([self respondsToSelector:@selector(navigationBarWillReturn)]) {
        [(id)self navigationBarWillReturn];
    }
}

@end
