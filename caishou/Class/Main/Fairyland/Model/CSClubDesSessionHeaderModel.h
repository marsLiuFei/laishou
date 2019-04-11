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
//  CSClubDesSessionHeaderModel.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/1.
//  Copyright © 2019年 mars. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSClubDesSessionHeaderModel : NSObject
/** title */
@property(nonatomic , strong)NSString *title;
/** rightTitle */
@property(nonatomic , strong)NSString *rightTitle;
/** iconStr */
@property(nonatomic , strong)NSString *iconStr;

+ (NSArray *)loadModels;



@end

NS_ASSUME_NONNULL_END
