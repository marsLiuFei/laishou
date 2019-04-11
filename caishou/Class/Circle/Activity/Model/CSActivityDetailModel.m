//
//  CSActivityDetailModel.m
//  caishou
//
//  Created by 刘飞 on 2019/3/15.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSActivityDetailModel.h"


@implementation CSActivityDetailModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"signList" :[CSMemberInfoModel class]
             };
}


-(CGFloat)titleCellHeight{
    CGFloat height = [XBWCSCommonTool sizeWithText:self.activityTitle font:MediumFont(17) maxW:SCREEN_WIDTH-SIZE(30)].height;
    height = height + SIZE(30);
    return height;
}
-(CGFloat)contentsCellHeight{
    CGFloat height = [XBWCSCommonTool sizeWithText:self.activityTitle font:RegularFont(17) maxW:SCREEN_WIDTH-SIZE(30)].height;
    height = height + SIZE(30);
    return height;
}

@end
