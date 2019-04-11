//
//  CSCounselorPageModel.h
//  caishou
//
//  Created by 刘飞 on 2019/3/6.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSCounselorPageModel : NSObject
/**
 *顾问头像
 */
@property(nonatomic, strong)NSString *headImg;
/**
 *顾问所在俱乐部
 */
@property(nonatomic, strong)NSString *clubName;
/**
 *--顾问id
 */
@property(nonatomic, strong)NSString *ID;
/**
 *--俱乐部id
 */
@property(nonatomic, strong)NSString *clubId;
/**
 *--顾问id
 */
@property(nonatomic, strong)NSString *loginId;
/**
 *--顾问姓名
 */
@property(nonatomic, strong)NSString *name;
/**
 *--顾问手机号
 */
@property(nonatomic, strong)NSString *mobile;
/**
 *--顾问标签
 */
@property(nonatomic, strong)NSString *label;
/**
 *状态（0:正常;1:删除）
 */
@property(nonatomic, strong)NSString *states;
/**
 *创建人id
 */
@property(nonatomic, strong)NSString *creater;
/***
 *创建时间
 */
@property(nonatomic, strong)NSString *createTime;
/**
 *是否推荐(0:非;1:是)
 */
@property(nonatomic, strong)NSString *isRecommend;
/**
 *推荐时间
 */
@property(nonatomic, strong)NSString *recommendTime;

/**
 *--所在俱乐部名称
 */
@property(nonatomic, strong)NSString *substationId;
/**
 *--会员数
 */
@property(nonatomic, strong)NSString *userNumber;
/**
 *--评分
 */
@property(nonatomic, strong)NSString *score;

@end

NS_ASSUME_NONNULL_END

/**
 
 {
 "id": "394d0c0b-78c4-483c-aab2-74b047565409",
 "clubId": "c919de8b-6bfd-43b1-bb67-1e810a74c0f7",
 "loginId": "0785166c-fb6f-4f90-801f-f8dba372bc07",
 "name": "张三",
 "mobile": "12331111",
 "label": "11,112,3，2，3",
 "states": 0,
 "creater": "0785166c-fb6f-4f90-801f-f8dba372bc07",
 "createTime": "2019-02-27T11:46:14.153",
 "isRecommend": 1,
 "recommendTime": "2019-02-28T14:08:23.453",
 "substationId": "9784e38e-2b9f-4b04-8326-1f1eadb00837",
 "userNumber": 1000,
 "score": 5
 }
 
 */
