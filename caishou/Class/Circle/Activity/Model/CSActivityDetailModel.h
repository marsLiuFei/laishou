//
//  CSActivityDetailModel.h
//  caishou
//
//  Created by 刘飞 on 2019/3/15.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSMemberInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSActivityDetailModel : NSObject

/**
 *内容
 */
@property(nonatomic, strong)NSString *activityContent ;
/**
 *标题
 */
@property(nonatomic, strong)NSString *activityTitle ;
/**
 *
 */
@property(nonatomic, strong)NSString *activityType;
/**
 *主办方地址
 */
@property(nonatomic, strong)NSString *clubAddress ;
/**
 *
 */
@property(nonatomic, strong)NSString *clubId ;
/**
 *主办方名称
 */
@property(nonatomic, strong)NSString *clubName ;
/**
 *联系电话
 */
@property(nonatomic, strong)NSString *clubPhone;
/**
 *
 */
@property(nonatomic, strong)NSString *createTime ;
/**
 *
 */
@property(nonatomic, strong)NSString *creater ;
/**
 *
 */
@property(nonatomic, strong)NSString *createrType ;
/**
 *
 */
@property(nonatomic, strong)NSString *endTime ;
/**
 *
 */
@property(nonatomic, strong)NSString *ID ;
/**
 *图片
 */
@property(nonatomic, strong)NSString *img ;
/**
 *
 */
@property(nonatomic, strong)NSString *noPassNote ;
/**
 *金额/积分
 */
@property(nonatomic, strong)NSString *price;
/**
 *报名人员信息
 */
@property(nonatomic, strong)NSArray *signList;
/**
 *报名人数
 */
@property(nonatomic, strong)NSString *signTotal;
/**
 *报名方式（1:钱;2:积分）
 */
@property(nonatomic, strong)NSString *signType;
/**
 *
 */
@property(nonatomic, strong)NSString *startTime ;
/**
 *
 */
@property(nonatomic, strong)NSString *status;
/**
 *结束时间
 */
@property(nonatomic, strong)NSString *strEndTime;
/**
 *开始时间
 */
@property(nonatomic, strong)NSString *strStartTime;
/**
 *
 */
@property(nonatomic, strong)NSString *substationId;

/**
 *  标题高
 */
@property(nonatomic, assign)CGFloat titleCellHeight;
/**
 *  内容cell高
 */
@property(nonatomic, assign)CGFloat contentsCellHeight;

@end

NS_ASSUME_NONNULL_END

/**
 
 {
 activityContent = "\U5f88\U597d";
 activityTitle = "\U6253\U724c";
 activityType = 3;
 clubAddress = "\U5408\U80a5\U5929\U9e45\U6e56";
 clubId = "1107e5a1-3a7c-492a-8e9d-7a6fa1d98099";
 clubName = "\U4ff1\U4e50\U90e8";
 clubPhone = 15012345678;
 createTime = "2019-03-11T22:05:49.74";
 creater = "0785166c-fb6f-4f90-801f-f8dba372bc07";
 createrType = 1;
 endTime = "2019-04-01T00:00:00";
 id = "2158e45e-9fb7-485c-9b03-2450ef15e0b6";
 img = "http://47.94.172.208:20192/file/showimg?filename=20190311220532.png";
 noPassNote = "\U5c31\U662f\U4e0d\U60f3\U8ba9\U901a\U8fc7";
 price = 0;
 signList =     (
 
 );
 signTotal = 0;
 signType = 1;
 startTime = "2019-03-11T22:05:00";
 status = 2;
 strEndTime = "2019-04-01 00:00:00";
 strStartTime = "2019-03-11 22:05:00";
 substationId = "9784e38e-2b9f-4b04-8326-1f1eadb00837";
 }
 
 */
