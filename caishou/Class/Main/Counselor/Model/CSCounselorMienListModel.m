//
//  CSCounselorMienListModel.m
//  caishou
//
//  Created by 刘飞 on 2019/3/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorMienListModel.h"

@implementation CSCounselorMienListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

+ (CSCounselorMienListModel *)addMoreModel {
    CSCounselorMienListModel *addModel = [[CSCounselorMienListModel alloc] init];
    addModel.picture = @"addPicture";
    return addModel;
}
@end
