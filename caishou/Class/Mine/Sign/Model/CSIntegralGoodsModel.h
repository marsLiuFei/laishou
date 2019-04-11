//
//  CSIntegralGoodsModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/10.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSIntegralGoodsModel : NSObject



/**
 *商品积分
 */
@property(nonatomic, strong)NSString *integral;
/**
 *
 */
@property(nonatomic, strong)NSString *ID;
/**
 *
 */
@property(nonatomic, strong)NSString *goodsName;
/**
 *
 */
@property(nonatomic, strong)NSString *goodsContent;

/**
 *领取时间
 */
@property(nonatomic, strong)NSString *receiveAddress;
/**
 *
 */
@property(nonatomic, strong)NSString *receivePhone;
/**
 *
 */
@property(nonatomic, strong)NSString *creater;
/**
 *
 */
@property(nonatomic, strong)NSString *createTime;
/**
 *状态(0:正常;9:删除)
 */
@property(nonatomic, strong)NSString *status;
/**
 *
 */
@property(nonatomic, strong)NSString *goodsImg;
@end

NS_ASSUME_NONNULL_END

/*
 {
 "id": "ce6f7ae0-ad81-44b6-8d05-16dd1840a6fb",
 "goodsName": "积分产品2",
 "goodsContent": "好用到爆",
 "integral": 30,
 "receiveAddress": "安徽省合肥市瑶海区",
 "receivePhone": "0551-7777779",
 "creater": "0785166c-fb6f-4f90-801f-f8dba372bc07",
 "createTime": "2019-03-02T15:49:42.443",
 "status": 0,
 "goodsImg": "20190302094640.jpg"
 }
 
 
 */
