//
//  EfficientMacroDefinition.h
//  Sunshine Meeting
//
//  Created by Axc_5324 on 17/5/6.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//


#ifndef EfficientMacroDefinition_h
#define EfficientMacroDefinition_h

//-------------------获取设备大小-------------------------

#define IPhoneX_All ({\
int tmp = 0;\
if (@available(iOS 11.0, *)) {\
if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.top > 20) {\
tmp = 1;\
}else{\
tmp = 0;\
}\
}else{\
tmp = 0;\
}\
tmp;\
})

#define MAINSTATUSHEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//状态栏高度
#define NavigationBar_HEIGHT [UIApplication sharedApplication].delegate.window.safeAreaInsets.top
//导航栏高度
#define NavigationHeader_HEIGHT 44 + NavigationBar_HEIGHT

#define Height_TapBar (IPhoneX_All ? 83.0 : 49.0)

#define NAVCENTERY MAINSTATUSHEIGHT + (NavigationHeader_HEIGHT - MAINSTATUSHEIGHT)/2.0

#define Height_TapBarSafeBottomMargin (IPhoneX_All ? 34.0 : 0)

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)




//-------------------打印日志-------------------------
#pragma mark - 自定义AxcLog日志打印
#ifdef DEBUG
# define AxcLog(FORMAT, ...) printf("[%s<%p>行号:%d]:%s\n",__FUNCTION__,self,__LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
# define AxcLog(...);
#endif


#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object     = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object   = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object   = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif


#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


//----------------------系统----------------------------
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif
//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//----------------------图片----------------------------
//读取本地图片
#define ImageBundle(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
//----------------------其他----------------------------
//方正微软雅黑字体定义
#define FONT(F) [UIFont fontWithName:@"Microsoft YaHei" size:F]
//G－C－D
#define axc_dispatch_get_global_queue(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define axc_dispatch_get_main_queue(block) dispatch_async(dispatch_get_main_queue(),block)
//NSUserDefaults 实例化
#define Axc_StandardUserDefaults [NSUserDefaults standardUserDefaults]


#define USERMASSAGEKEY @"USERMASSAGEKEY"
#define Axc_Token @"token"


#endif
