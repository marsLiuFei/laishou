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
//  CSClubDesSessionHeaderModel.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/1.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSClubDesSessionHeaderModel.h"

@implementation CSClubDesSessionHeaderModel
+ (NSArray *)loadModels {
    CSClubDesSessionHeaderModel *model1 = [[CSClubDesSessionHeaderModel alloc] init];
    model1.title = @"金牌顾问";
    model1.rightTitle = @"更多＞";
    model1.iconStr = @"";
    CSClubDesSessionHeaderModel *model2 = [[CSClubDesSessionHeaderModel alloc] init];
    model2.title = @"热门活动";
    model2.rightTitle = @"更多＞";
    model2.iconStr = @"";
    
    return @[model1,model2];
}
@end
