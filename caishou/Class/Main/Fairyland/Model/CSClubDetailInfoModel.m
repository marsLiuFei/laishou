//
//  CSClubDetailInfoModel.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/10.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSClubDetailInfoModel.h"

@implementation CSClubDetailInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"counselorList":@"CSCounselorPageModel"};
}
@end
