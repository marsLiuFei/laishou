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
//  CSMessageSettingModel.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/14.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMessageSettingModel.h"

@implementation CSMessageSettingModel
+ (NSArray *)loadDatas {
    CSMessageSettingModel *model1 = [[CSMessageSettingModel alloc] init];
    model1.title = @"新消息通知";
    model1.subTitle =@"已关闭";
    model1.showBtn = false;
    
    CSMessageSettingModel *model2 = [[CSMessageSettingModel alloc] init];
    model2.title = @"免打扰模式";
    model2.showBtn = true;
    
    CSMessageSettingModel *model3 = [[CSMessageSettingModel alloc] init];
    model3.title = @"声音";
    model3.showBtn = true;
    
    CSMessageSettingModel *model4 = [[CSMessageSettingModel alloc] init];
    model4.title = @"震动";
    model4.showBtn = true;
    
    return @[@[model1],@[model2],@[model3,model4]];
}
@end
