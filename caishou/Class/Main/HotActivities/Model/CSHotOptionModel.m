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
//  CSHotOptionModel.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHotOptionModel.h"

@implementation CSHotOptionModel

+ (NSArray *)loadDatas {
    CSHotOptionModel *model1 = [[CSHotOptionModel alloc] init];
    model1.title = @"毅行";
    model1.iconStr = @"voyager";
    CSHotOptionModel *model2 = [[CSHotOptionModel alloc] init];
    model2.title = @"公益";
    model2.iconStr = @"benefit";
    CSHotOptionModel *model3 = [[CSHotOptionModel alloc] init];
    model3.title = @"聚会";
    model3.iconStr = @"meet";
    CSHotOptionModel *model4 = [[CSHotOptionModel alloc] init];
    model4.title = @"培训";
    model4.iconStr = @"train";
    CSHotOptionModel *model5 = [[CSHotOptionModel alloc] init];
    model5.title = @"旅游";
    model5.iconStr = @"travel";
    CSHotOptionModel *model6 = [[CSHotOptionModel alloc] init];
    model6.title = @"运动";
    model6.iconStr = @"sport";
    CSHotOptionModel *model7 = [[CSHotOptionModel alloc] init];
    model7.title = @"美容";
    model7.iconStr = @"beauty";
    CSHotOptionModel *model8 = [[CSHotOptionModel alloc] init];
    model8.title = @"才艺";
    model8.iconStr = @"acqierement";
    CSHotOptionModel *model9 = [[CSHotOptionModel alloc] init];
    model9.title = @"电影";
    model9.iconStr = @"movie";
    CSHotOptionModel *model10 = [[CSHotOptionModel alloc] init];
    model10.title = @"全部";
    model10.iconStr = @"all";
    return @[model1,model2,model3,model4,model5,model6,model7,model8,model9,model10];
    
}


@end
