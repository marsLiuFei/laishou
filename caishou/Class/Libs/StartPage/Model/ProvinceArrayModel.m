//
//  ProvinceArrayModel.m
//  ShoppingMall
//
//  Created by ahxb on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "ProvinceArrayModel.h"

@implementation ProvinceArrayModel

static ProvinceArrayModel * _provinceArrayModel = nil;
static dispatch_once_t onceToken;

+ (ProvinceArrayModel *)sharedProvinceArrayModel {
    dispatch_once(&onceToken, ^{
        _provinceArrayModel = [[super allocWithZone:NULL] init];
        _provinceArrayModel.provinceArray = [[NSMutableArray alloc]init];
    });
    return _provinceArrayModel;
}
+(id) allocWithZone:(struct _NSZone *)zone
{
    return [ProvinceArrayModel sharedProvinceArrayModel];
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [ProvinceArrayModel sharedProvinceArrayModel];
}

@end
