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
//  CSSettingModel.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/12.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSettingModel.h"

@implementation CSSettingModel

+ (NSArray *)loadDatas {
    CSSettingModel *model1 = [[CSSettingModel alloc] init];
    model1.title = @"消息通知";
    model1.pushVc = @"CSMessageNotificationViewController";
    
    CSSettingModel *model11 = [[CSSettingModel alloc] init];
    model11.title = @"隐私";
    
    CSSettingModel *model2 = [[CSSettingModel alloc] init];
    model2.title = @"修改密码";
    model2.pushVc = @"CSChangePasswordViewController";
    
    CSSettingModel *model3 = [[CSSettingModel alloc] init];
    model3.title = @"清除缓存";
    model3.subTitle = @"正在计算";
    
    CSSettingModel *model4 = [[CSSettingModel alloc] init];
    model4.title = @"微信";
    model4.subTitle = @"未绑定";
    CSSettingModel *model5 = [[CSSettingModel alloc] init];
    model5.title = @"QQ";
    model5.subTitle = @"时光荏苒";
    
    CSSettingModel *model6 = [[CSSettingModel alloc] init];
    model6.title = @"分享莱瘦";
    CSSettingModel *model7 = [[CSSettingModel alloc] init];
    model7.title = @"关于莱瘦";
//    model7.pushVc = @"CSAboutAppViewController";
   
    
    return @[@[model1,model11,model2] ,@[model3],/*@[model4,model5],*/@[/*model6,*/model7]];
}

@end
