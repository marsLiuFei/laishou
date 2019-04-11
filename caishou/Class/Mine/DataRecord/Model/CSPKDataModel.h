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
//  CSPKDataModel.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/25.
//  Copyright © 2019年 mars. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSPKDataModel : NSObject
/** age */
@property(nonatomic , assign)NSNumber *age;
/** birthday */
@property(nonatomic , strong)NSString *birthday;
/** bmi */
@property(nonatomic , strong)NSString *bmi;
/** endTime */
@property(nonatomic , strong)NSString *endTime;
/** fatRate */
@property(nonatomic , strong)NSString *fatRate;
/** headImg */
@property(nonatomic , strong)NSString *headImg;
/** id */
@property(nonatomic , strong)NSString *ID;
/** loginId */
@property(nonatomic , strong)NSString *loginId;
/** pkId */
@property(nonatomic , strong)NSString *pkId;
/** result */
@property(nonatomic , assign)NSNumber *result;
/** roleType */
@property(nonatomic , assign)NSNumber *roleType;
/** weight */
@property(nonatomic , assign)NSNumber *weight;
/** startTime */
@property(nonatomic , assign)NSString *startTime;
/** currentWeight */
@property(nonatomic , strong)NSNumber *currentWeight;
@end

NS_ASSUME_NONNULL_END
