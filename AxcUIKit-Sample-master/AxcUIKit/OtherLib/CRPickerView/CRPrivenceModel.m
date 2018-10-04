//
//  CRPrivenceModel.m
//  PickerViewDemo
//
//  Created by 李岚清 on 2018/6/21.
//  Copyright © 2018年 ButterJie. All rights reserved.
//

#import "CRPrivenceModel.h"

@implementation CRPrivenceModel
//根据字典创建模型的两个方法
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)privenceWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
