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
//  CSInfoModel.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/5.
//  Copyright © 2019年 mars. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CSPersonalInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MyInfoType) {
    MyInfoTypeDef,
    MyInfoTypeSelect,
    MyInfoTypeOther
};

@interface CSInfoModel : NSObject

/** title */
@property(nonatomic , strong)NSString *title;
/** iconStr */
@property(nonatomic , strong)NSString *iconStr;
/** placeholder */
@property(nonatomic , strong)NSString *placeholder;
/** text */
@property(nonatomic , strong)NSString *text;
/** subArr */
@property(nonatomic , strong)NSArray   *subArr;
/** selectTag */
@property(nonatomic , strong)NSString *selectTag;
/** tag */
@property(nonatomic , assign)NSInteger tag;


/** type */
@property(nonatomic , assign)MyInfoType type;

+ (NSArray *)loadDatasWithNormalModel:(CSPersonalInfoModel *)infoModel;


@end

NS_ASSUME_NONNULL_END
