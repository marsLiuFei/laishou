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
//  CSBannerModel.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/20.
//  Copyright © 2019年 mars. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSBannerModel : NSObject
/**
 *广告id
 */
@property(nonatomic, strong)NSString *ID;
/**
 *分站id
 */
@property(nonatomic, strong)NSString *substationId;
/**
 *广告名称
 */
@property(nonatomic, strong)NSString *advName;
/**
 *广告图片名称
 */
@property(nonatomic, strong)NSString *advUrl;
/**
 *广告类型 1首页头部 2首页大图 3首页小左图 4首页小右图 5俱乐部海报 6顾问海报
 */
@property(nonatomic, strong)NSString *advType;
/**
 *创建人id
 */
@property(nonatomic, strong)NSString *creater;
/**
 *创建时间
 */
@property(nonatomic, strong)NSString *createTime;

/**
 *跳转链接
 */
@property(nonatomic, strong)NSString *url;
@end

NS_ASSUME_NONNULL_END
/**
 
 {
 "id": "420ba9a3-501b-4ed7-b5c2-140a40bbeeb0",
 "substationId": "9784e38e-2b9f-4b04-8326-1f1eadb00837",
 "advName": "广告3",
 "advUrl": "20190302094646.jpg",
 "advType": 2,
 "creater": "0785166c-fb6f-4f90-801f-f8dba372bc07",
 "createTime": "2019-03-02T09:53:13.047"
 }
 
 */
