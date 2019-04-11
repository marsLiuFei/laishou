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
//  CSMyInfoViewController.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/3.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSPersonalInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSMyInfoViewController : CSBaseViewController
@property(nonatomic, strong)void (^needRefreshBlock)(void );
@property(nonatomic, strong)CSPersonalInfoModel *userInfoModel;
@end

NS_ASSUME_NONNULL_END
