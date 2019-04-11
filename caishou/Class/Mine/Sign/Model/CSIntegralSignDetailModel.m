//
//  CSIntegralSignDetailModel.m
//  caishou
//
//  Created by 刘飞 on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSIntegralSignDetailModel.h"


@implementation CSIntegralSignDetailModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":[CSIntegralGoodsModel class],
             @"signLogList":[CSSignRecordsModel class]
             };
}
@end
