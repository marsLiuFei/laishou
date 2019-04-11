//
//  CSCounselorDetailModel.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/10.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorDetailModel.h"

@implementation CSCounselorDetailModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"articleList":[CSArticleListModel class],
             @"mienList":[CSCounselorMienListModel class],
             @"userList":[CSUserMemberModel class]};
}
- (CGFloat)height {
    if (self.introduce) {
        CGFloat height =  [ZYQTool ZYQ_returnHeightAccordingText:self.introduce font:RegularFont(12) width:SCREEN_WIDTH - 20];
        return height;
    }
    return 21;
}
@end
