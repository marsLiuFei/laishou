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
//  CSSettingModel.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/12.
//  Copyright © 2019年 mars. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSSettingModel : NSObject

/** title */
@property(nonatomic , strong)NSString *title;
/** subTitle */
@property(nonatomic , strong)NSString *subTitle;


/** pushVc */
@property(nonatomic , strong)NSString *pushVc;


+ (NSArray *)loadDatas;




@end

NS_ASSUME_NONNULL_END
