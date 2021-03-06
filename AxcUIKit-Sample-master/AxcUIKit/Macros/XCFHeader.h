//
//  XCFHeader.h
//  JiaoProject
//
//  Created by Xinju on 2017/5/14.
//  Copyright © 2017年 deve.com. All rights reserved.
//

#ifndef XCFHeader_h
#define XCFHeader_h

#define XCFUserDefaults [NSUserDefaults standardUserDefaults]
#define XCFScreenBounds [UIScreen mainScreen].bounds
#define XCFScreenWidth [UIScreen mainScreen].bounds.size.width
#define XCFScreenHeight [UIScreen mainScreen].bounds.size.height


#ifdef DEBUG
#define XCFLog(...) NSLog(__VA_ARGS__)
#else
#define XCFLog(...)
#endif

#define XCFLogFunc XCFLog(@"%s", __func__)

#define WeakSelf __weak typeof(self) weakSelf = self;
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
/**
 *  1.返回一个RGBA格式的UIColor对象
 */
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define XCFGlobalBackgroundColor RGB(245, 240, 215)     // 背景颜色
#define XCFLabelColorWhite RGB(255, 255, 255)           // 字体颜色：白色
#define XCFLabelColorGray [UIColor grayColor]           // 字体颜色：灰色
#define XCFCoverViewColor RGBA(0, 0, 0, 0.2)            // 黑色半透明遮盖
#define XCFTabBarNormalColor RGB(170, 170, 170)         // TabBar颜色
#define XCFThemeColor RGB(249, 103, 80)        // TabBar选中颜色
#define XCFSearchBarTintColor RGB(192, 192, 192)        // 搜索按钮背景色
#define XCFDishViewBackgroundColor RGB(235, 235, 226)   // 作品view背景色
#define XCFAddressCellColor RGB(215, 228, 225)          // 收货地址选中颜色



#endif /* XCFHeader_h */
