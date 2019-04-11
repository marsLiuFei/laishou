//
//  CSSpellGoodsModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/10.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSSpellGoodsModel : NSObject
@property(nonatomic, strong)NSString *ID;

@property(nonatomic, strong)NSString *goodsName;
/**
 *商品详情
 */
@property(nonatomic, strong)NSString *goodsNote;
/**
 *商品图片
 */
@property(nonatomic, strong)NSString *goodsUrl;
/**
 *
 */
@property(nonatomic, strong)NSString *spellNumber;
/**
 *产地
 */
@property(nonatomic, strong)NSString *receiveAddress;
/**
 *
 */
@property(nonatomic, strong)NSString *linkPhone;
/**
 *
 */
@property(nonatomic, strong)NSString *status;
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
@property(nonatomic, strong)NSString *substationId;
@property(nonatomic, strong)NSString *clubId;
/**
 *现价
 */
@property(nonatomic, strong)NSString *price;
/**
 *原价
 */
@property(nonatomic, strong)NSString *rawPrice;
/**
 *单位描述
 */
@property(nonatomic, strong)NSString *unit;
/**
 *库存剩余
 */
@property(nonatomic, strong)NSString *inventory;
/**
 *已团数量
 */
@property(nonatomic, strong)NSString *thenGroup;
/**
 *
 */
@property(nonatomic, strong)NSString *merchantId;


/**
 *是否收藏，本人添加，后台无此字段
 */
@property(nonatomic, strong)NSString *isCollect;

/**
 *商品数量，商品详情页增加字段，用来记录商品拼团数量
 */
@property(nonatomic, strong)NSString *goodsCount;
@end

NS_ASSUME_NONNULL_END

/**
 
 {
 "id": "e6ba7245-5635-4ac1-a8bc-1909cf17d3b5",
 "goodsName": "拼团商品1",
 "goodsNote": "拼团介绍",
 "goodsUrl": "http://47.94.172.208:20192/file/showimg?filename=20190302094654.jpg",
 "spellNumber": 12,
 "receiveAddress": "安徽省合肥是瑶海区",
 "linkPhone": "0551-8888888",
 "status": 2,
 "creater": "5607a4eb-ca72-42f4-a3dc-005956d95cf1",
 "createTime": "2019-03-02T17:12:25.107",
 "substationId": "9784e38e-2b9f-4b04-8326-1f1eadb00837",
 "clubId": "ccf2effb-8f4d-421f-9f13-63e8405d125c",
 "price": 10.99,
 "rawPrice": 20.56,
 "unit": "120g/盒",
 "inventory": 100,
 "thenGroup": 0,
 "merchantId": "c562a881-bf69-4b65-b20d-06b4ff68974c"
 }
 
 */
