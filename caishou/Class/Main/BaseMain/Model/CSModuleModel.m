//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//
//
//  CSModuleModel.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSModuleModel.h"

@implementation CSModuleModel

+ (NSArray *)loadModels {
    CSModuleModel *model1 = [[CSModuleModel alloc] init];
    model1.title = @"热门活动";
    model1.imgStr = @"hotActive";
    CSModuleModel *model2 = [[CSModuleModel alloc] init];
    model2.title = @"莱瘦顾问";
    model2.imgStr = @"counselor";
    CSModuleModel *model3 = [[CSModuleModel alloc] init];
    model3.title = @"莱瘦乐园";
    model3.imgStr = @"fairyland";
    CSModuleModel *model4 = [[CSModuleModel alloc] init];
    model4.title = @"每日签到";
    model4.imgStr = @"signIn";
    return @[model1,model2,model3,model4];
}



@end
