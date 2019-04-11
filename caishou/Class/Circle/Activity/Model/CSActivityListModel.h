//
//  CSActivityListModel.h
//  caishou
//
//  Created by 刘飞 on 2019/3/9.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSActivityListModel : NSObject
/**
 *
 */
@property(nonatomic, strong)NSString *strStartTime;
/**
 *
 */
@property(nonatomic, strong)NSString *strEndTime;
/**
 *
 */
@property(nonatomic, strong)NSString *ID;
/**
 *
 */
@property(nonatomic, strong)NSString *substationId;
/**
 *
 */
@property(nonatomic, strong)NSString *clubId;
/**
 *
 */
@property(nonatomic, strong)NSString *activityTitle;
/**
 *
 */
@property(nonatomic, strong)NSString *activityContent;
/**
 *报名方式（1:钱;2:积分）
 */
@property(nonatomic, strong)NSString *signType;
/**
 *
 */
@property(nonatomic, strong)NSString *price;
/**
 *
 */
@property(nonatomic, strong)NSString *status;
/**
 *
 */
@property(nonatomic, strong)NSString *noPassNote;
/**
 *
 */
@property(nonatomic, strong)NSString *creater;
/**
 *
 */
@property(nonatomic, strong)NSString *createrType;
/**
 *
 */
@property(nonatomic, strong)NSString *createTime;
/**
 *
 */
@property(nonatomic, strong)NSString *startTime;
/**
 *
 */
@property(nonatomic, strong)NSString *endTime;
/**
 *
 */
@property(nonatomic, strong)NSString *activityType;
/**
 *活动状态（1:未开始;2:进行中;3:已结束）
 */
@property(nonatomic, strong)NSString *appActivityStatus;
/**
 *
 */
@property(nonatomic, strong)NSString *clubAddress;
/**
 *
 */
@property(nonatomic, strong)NSString *clubName;
/**
 *
 */
@property(nonatomic, strong)NSString *clubPhone;
/**
 *报名人数
 */
@property(nonatomic, strong)NSString *signNumber;
/**
 *
 */
@property(nonatomic, strong)NSString *img;
@end

NS_ASSUME_NONNULL_END

/**
 
 {
 activityContent = "\U5468\U672b\U6d3b\U52a8";
 activityTitle = "\U5468\U672b\U6d3b\U52a8";
 activityType = 3;
 appActivityStatus = 3;
 clubAddress = "\U5408\U80a5\U5929\U9e45\U6e56";
 clubId = "fb21ba49-8d28-48f5-a66b-6372c72c9503";
 clubName = "\U4ff1\U4e50\U90e8";
 clubPhone = 15012345678;
 createTime = "2019-03-14T11:22:28.923";
 creater = "0785166c-fb6f-4f90-801f-f8dba372bc07";
 createrType = 1;
 endTime = "2019-03-14T12:21:00";
 id = "af1958a7-91a0-4fe0-bacf-b2e87f787346";
 img = "http://47.94.172.208:20192/file/showimg?filename=20190314112206.png";
 noPassNote = "<null>";
 price = "0.01";
 signNumber = 0;
 signType = 1;
 startTime = "2019-03-14T11:21:00";
 status = 2;
 strEndTime = "2019-03-14 12:21:00";
 strStartTime = "2019-03-14 11:21:00";
 substationId = "9784e38e-2b9f-4b04-8326-1f1eadb00837";
 }
 
 */
