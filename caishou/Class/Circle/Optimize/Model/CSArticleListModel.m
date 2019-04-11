//
//  CSArticleListModel.m
//  caishou
//
//  Created by 刘飞 on 2019/3/9.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSArticleListModel.h"

@implementation CSArticleListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
