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
//  CSPasswordModel.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/13.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSPasswordModel.h"

@implementation CSPasswordModel

+ (NSArray *)loadDatas {
    CSPasswordModel *model1 = [[CSPasswordModel alloc] init];
    model1.title = @"旧密码";
    model1.placeholder =@"请填写旧密码";
    
    CSPasswordModel *model2 = [[CSPasswordModel alloc] init];
    model2.title = @"新密码";
    model2.placeholder =@"请输入新密码";
    
    CSPasswordModel *model3 = [[CSPasswordModel alloc] init];
    model3.title = @"密码确认";
    model3.placeholder =@"请再次输入新密码";
    return @[model1,model2,model3];
}


@end
