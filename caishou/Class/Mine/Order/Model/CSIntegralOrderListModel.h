//
//  CSIntegralOrderListModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSIntegralOrderListModel : NSObject
/**
 *
 **/
@property(nonatomic, strong)NSString *goodsName;
/**
 *订单ID
 **/
@property(nonatomic, strong)NSString *ID;
/**
 *
 **/
@property(nonatomic, strong)NSString *goodsId;
/**
 *
 **/
@property(nonatomic, strong)NSString *integral;
/**
 *
 **/
@property(nonatomic, strong)NSString *creater;
/**
 *
 **/
@property(nonatomic, strong)NSString *createTime;
/**
 *  状态(1:未领取;2:已领取;3:不能领取;9:删除)
 */
@property(nonatomic, strong)NSString *status;
/**
 *  领取时间
 **/
@property(nonatomic, strong)NSString *receiveTime;
/**
 *
 **/
@property(nonatomic, strong)NSString *operatorId;
/**
 *
 **/
@property(nonatomic, strong)NSString *note;// null
/**
 *商品图片
 **/
@property(nonatomic, strong)NSString *goodsImg;
/**
 *订单号
 **/
@property(nonatomic, strong)NSString *indentCode;
/**
 *兑换数量
 **/
@property(nonatomic, strong)NSString *number;

@end

NS_ASSUME_NONNULL_END

/**
 
 "goodsName;// "积分产品2",
 "id;// "0c14e2a7-1526-42b4-872c-4ab2e1dd8ea8",
 "goodsId;// "ce6f7ae0-ad81-44b6-8d05-16dd1840a6fb",
 "integral;// 30,
 "creater;// "5607a4eb-ca72-42f4-a3dc-005956d95cf1",
 "createTime;// "2019-03-02T15:51:52.263",
 "status;// 1,
 "receiveTime;// null,
 "operatorId;// null,
 "note;// null
 
 */
