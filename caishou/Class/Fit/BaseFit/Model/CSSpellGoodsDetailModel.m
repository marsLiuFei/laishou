//
//  CSSpellGoodsDetailModel.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSpellGoodsDetailModel.h"
#import "CSMemberInfoModel.h"

@implementation CSSpellGoodsDetailModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"userList" :[CSMemberInfoModel class]
             };
}
@end
