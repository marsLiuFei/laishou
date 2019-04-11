//
//  CSClubListModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/5.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSClubListModel : NSObject

@property(nonatomic, strong)NSString *logo;
/**
 *--俱乐部id
 */
@property(nonatomic, strong)NSString *ID;
/**
 *--俱乐部名称
 */
@property(nonatomic, strong)NSString *clubName;
/**
 *--俱乐部地址
 */
@property(nonatomic, strong)NSString *clubAddress;
/**
 *--图标类型集合（1:活;2:惠;3:团;4:火）
 */
@property(nonatomic, strong)NSString *iconType;
/**
 *--俱乐部标签
 */
@property(nonatomic, strong)NSString *label;
/**
 *--会员数
 */
@property(nonatomic, strong)NSString *userNumber;
/**
 *--评分
 */
@property(nonatomic, strong)NSString *score;
/**
 *--经度
 */
@property(nonatomic, strong)NSString *lng;
/**
 *--纬度
 */
@property(nonatomic, strong)NSString *lat;
/**
 *"> 3公里" --附近说明
 */
@property(nonatomic, strong)NSString *nearInfo;






//下面字段是分页俱乐部列表包含的字段
/**
 *
 */
@property(nonatomic, strong)NSString *substationId;
/**
 *
 */
@property(nonatomic, strong)NSString *states;
/**
 *
 */
@property(nonatomic, strong)NSString *creater;
/**
 *
 */
@property(nonatomic, strong)NSString *createTime;
/**
 *
 */
@property(nonatomic, strong)NSString *isRecommend;

/**
 *
 */
@property(nonatomic, strong)NSString *recommendTime;
@end

NS_ASSUME_NONNULL_END

/**
 
 {
 "id": "1107e5a1-3a7c-492a-8e9d-7a6fa1d98099", --俱乐部id
 "clubName": "俱乐部名称", --俱乐部名称
 "clubAddress": "俱乐部地址", --俱乐部地址
 "iconType": "1,2,3,4", --图标类型集合（1:活;2:惠;3:团;4:火）
 "label": "顾问多多,优惠多多", --俱乐部标签
 "userNumber": 1000, --会员数
 "score": 5, --评分
 "lng": 117.331566, --经度
 "lat": 31.899535, --纬度
 "nearInfo": "> 3公里" --附近说明
 }
 
 
 
 
 {
 "id": "1107e5a1-3a7c-492a-8e9d-7a6fa1d98099",
 "clubName": "俱乐部名称",
 "clubAddress": "俱乐部地址",
 "iconType": "1,2,3,4",
 "label": "顾问多多,优惠多多",
 "userNumber": 1000,
 "score": 5
 "lng": 117.331566,
 "lat": 31.899535,
 
 "substationId": "9784e38e-2b9f-4b04-8326-1f1eadb00837",
 "states": 0,
 "creater": "0785166c-fb6f-4f90-801f-f8dba372bc07",
 "createTime": "2019-03-02T09:39:05.5",
 "isRecommend": 1,
 "recommendTime": "2019-03-04T10:27:25.02",
 }
 
 */
