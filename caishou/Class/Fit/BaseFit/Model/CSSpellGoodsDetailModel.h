//
//  CSSpellGoodsDetailModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSSpellGoodsDetailModel : NSObject
/**
 *
 **/
@property(nonatomic, strong)NSString *clubId;
/**
 *
 **/
@property(nonatomic, strong)NSString *createTime;
/**
 *
 **/
@property(nonatomic, strong)NSString *creater;
/**
 *
 **/
@property(nonatomic, strong)NSString *goodsName;
/**
 *
 **/
@property(nonatomic, strong)NSString *goodsNote;
/**
 *
 **/
@property(nonatomic, strong)NSString *ID;
/**
 *
 **/
@property(nonatomic, strong)NSString *goodsUrl;
/**
 *库存
 **/
@property(nonatomic, strong)NSString *inventory;
/**
 *
 **/
@property(nonatomic, strong)NSString *linkPhone;
/**
 *
 **/
@property(nonatomic, strong)NSString *merchantId;

/**
 *
 **/
@property(nonatomic, strong)NSString *price;
/**
 *原价
 **/
@property(nonatomic, strong)NSString *rawPrice;
/**
 *
 **/
@property(nonatomic, strong)NSString *receiveAddress;

/**
 *
 **/
@property(nonatomic, strong)NSString *spellType;
/**
 *
 **/
@property(nonatomic, strong)NSString *status;
/**
 *
 **/
@property(nonatomic, strong)NSString *substationId;
/**
 *已团
 **/
@property(nonatomic, strong)NSString *thenGroup;
/**
 *
 **/
@property(nonatomic, strong)NSString *unit;
/**
 *满多少人可拼团
 **/
@property(nonatomic, strong)NSString *spellNumber;
/**
 *
 **/
@property(nonatomic, strong)NSArray *userList;


//下面两字段是为了展示自行添加的字段
/**
 *总数量
 **/
@property(nonatomic, strong)NSString *goodsCount;
/**
 *总价
 **/
@property(nonatomic, strong)NSString *totalPrice;



/**
 *  浏览量
 **/
@property(nonatomic, strong)NSString *likeNumber;
/**
 *  分享量
 **/
@property(nonatomic, strong)NSString *browseNumber;
@end

NS_ASSUME_NONNULL_END

/*
 
 
 clubId = "9dc3375a-ec52-4fc2-8169-11f03d9fdf26";
 createTime = "2019-03-20T01:39:18.333";
 creater = "f6b60df4-3fb8-4c56-afd7-599141f24be4";
 goodsName = "\U4e03\U5929\U51cf\U4e94\U65a4";
 goodsNote = "<p><img src=\"http://admin.laiscn.comhttp://admin.laiscn.com/upload/image/20190320/6368864271536472722403152.jpg\" title=\"timg (1).jpg\" alt=\"timg (1).jpg\"/></p>";
 goodsUrl = "http://47.99.100.88:81/file/showimg?filename=20190320013844.jpg";
 id = "8cf2affa-bf16-433b-a4d6-6b070b59f96e";
 inventory = 20000;
 linkPhone = 15956956601;
 merchantId = "5f17d55e-b4b9-43c0-8834-202b6815d66f";
 price = 1;
 rawPrice = 100;
 receiveAddress = "\U4ebf\U542f\U83b1\U4ff1\U4e50\U90e8";
 spellNumber = 10;
 spellType = 1;
 status = 2;
 substationId = "4554081b-aa46-48d4-a5f9-0472a38a6f5f";
 thenGroup = 0;
 unit = "\U6b21";
 userList =     (
 );
 
 **/
