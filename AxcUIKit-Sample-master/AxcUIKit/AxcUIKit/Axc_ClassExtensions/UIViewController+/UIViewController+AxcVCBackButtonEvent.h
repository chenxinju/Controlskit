//
//  UIViewController+AxcVCBackButtonEvent.h
//  AxcUIKit
//
//  Created by Axc on 2017/7/26.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AxcVCBackButtonEventProtocol <NSObject>
@optional
// 页面即将被 pop 时触发，用于释放资源；不再拦截系统返回动画
- (BOOL)AxcUI_navigationShouldPopOnBackButton;
@end

@interface UIViewController (AxcVCBackButtonEvent) <AxcVCBackButtonEventProtocol>

@end
