//
//  CSClubDetailInfoModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/10.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSClubDetailInfoModel : NSObject
@property(nonatomic, strong)NSString *ID;
@property(nonatomic, strong)NSString *substationId;
@property(nonatomic, strong)NSString *clubName;
@property(nonatomic, strong)NSString *clubAddress;
@property(nonatomic, strong)NSString *states;
@property(nonatomic, strong)NSString *creater;
@property(nonatomic, strong)NSString *businessTime;
@property(nonatomic, strong)NSString *createTime;
@property(nonatomic, strong)NSString *isRecommend;
@property(nonatomic, strong)NSString *recommendTime;
@property(nonatomic, strong)NSString *lng;
@property(nonatomic, strong)NSString *lat;
@property(nonatomic, strong)NSString *iconType;
@property(nonatomic, strong)NSString *label;
@property(nonatomic, strong)NSString *userNumber;
@property(nonatomic, strong)NSString *score;
@property(nonatomic, strong)NSString *logo;
@property(nonatomic, strong)NSString *clubPhone;

@property(nonatomic, strong)NSArray *counselorList;

@end

NS_ASSUME_NONNULL_END

/*
 
 {
 "id": "1107e5a1-3a7c-492a-8e9d-7a6fa1d98099",
 "substationId": "9784e38e-2b9f-4b04-8326-1f1eadb00837",
 "clubName": "俱乐部名称",
 "clubAddress": "俱乐部地址",
 "states": 0,
 "creater": "0785166c-fb6f-4f90-801f-f8dba372bc07",
 "createTime": "2019-03-02T09:39:05.5",
 "isRecommend": 1,
 "recommendTime": "2019-03-04T10:27:25.02",
 "lng": 117.331566,
 "lat": 31.899535,
 "iconType": "1,2,3,4",
 "label": "顾问多多,优惠多多",
 "userNumber": 1000,
 "score": 5,
 "logo": null,
 "clubPhone": "18355803837"
 }
 
 */
