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
//  CSPKInfoModel.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/25.
//  Copyright © 2019年 mars. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CSMyInfoModel.h"
#import "CSPKDataModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CSPKInfoModel : NSObject

/** myInfo */
@property(nonatomic , strong)CSMyInfoModel *myInfo;
/** normChestWai */
@property(nonatomic , strong)NSString *normChestWai;
/** normHipWai */
@property(nonatomic , strong)NSString *normHipWai;
/** normWaistWai */
@property(nonatomic , strong)NSString *normWaistWai;
/** CSPKDataModel */
@property(nonatomic , strong)CSPKDataModel *myPk;
/** CSPKDataModel */
@property(nonatomic , strong)CSPKDataModel *otherPk;


@end

NS_ASSUME_NONNULL_END
