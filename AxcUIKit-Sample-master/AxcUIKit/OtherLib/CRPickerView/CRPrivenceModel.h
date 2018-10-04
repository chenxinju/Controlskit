//
//  CRPrivenceModel.h
//  PickerViewDemo
//
//  Created by 李岚清 on 2018/6/21.
//  Copyright © 2018年 ButterJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRPrivenceModel : NSObject
@property (nonatomic, strong) NSArray *Children;
//@property (nonatomic, copy) NSNumber *AreaCode;
//@property (nonatomic, copy) NSNumber *AreaType;
@property (nonatomic, assign) long AreaCode;
@property (nonatomic, assign) long AreaType;
@property (nonatomic, copy) NSString *AreaName;
//根据字典创建模型的两个方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)privenceWithDict:(NSDictionary *)dict;
@end
