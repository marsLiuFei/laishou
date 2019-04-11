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
//  CSHomeSessionHeaderModel.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHomeSessionHeaderModel.h"

@implementation CSHomeSessionHeaderModel
+ (NSArray *)loadModels {
    CSHomeSessionHeaderModel *model1 = [[CSHomeSessionHeaderModel alloc] init];
    model1.title = @"推荐俱乐部";
    model1.rightTitle = @"更多 >";
    model1.iconStr = @"";
    CSHomeSessionHeaderModel *model2 = [[CSHomeSessionHeaderModel alloc] init];
    model2.title = @"推荐顾问";
    model2.rightTitle = @"更多 >";
    model2.iconStr = @"";
    CSHomeSessionHeaderModel *model3 = [[CSHomeSessionHeaderModel alloc] init];
    model3.title = @"热门推荐";
    model3.rightTitle = @"更多 >";
    model3.iconStr = @"";
    
    return @[model3,model1,model2];
}

@end
