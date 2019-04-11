//
//  CSGroupBookOrderListModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSGroupBookOrderListModel : NSObject

@property(nonatomic, strong)NSString *ID;//订单id
@property(nonatomic, strong)NSString *goodsId;//商品ID
/**
 *状态(1:未支付；2：已支付;9:删除)
 **/
@property(nonatomic, strong)NSString *states    ;//
@property(nonatomic, strong)NSString *creater    ;//    创建人id
@property(nonatomic, strong)NSString *createTime    ;//    创建时间
@property(nonatomic, strong)NSString *addTime    ;//    拼团时间
/**
 *拼团状态（1:拼团中;2:拼团成功;3:已领取）
 */
@property(nonatomic, strong)NSString *spellStatus    ;
/**
 * 拼团订单号
 **/
@property(nonatomic, strong)NSString *indentCode    ;//
@property(nonatomic, strong)NSString *goodsName    ;//    商品名称
@property(nonatomic, strong)NSString *goodsNote    ;//    商品详情
@property(nonatomic, strong)NSString *goodsUrl    ;//    商品图片集合
@property(nonatomic, strong)NSString *spellNumber    ;//    拼团人数
@property(nonatomic, strong)NSString *receiveAddress    ;//    领取地址
@property(nonatomic, strong)NSString *linkPhone    ;//    联系电话
@property(nonatomic, strong)NSString *substationId    ;//    分站id
@property(nonatomic, strong)NSString *clubId    ;//    俱乐部id
@property(nonatomic, strong)NSString *merchantId    ;//    商家id
/**
 *数量
 */
@property(nonatomic, strong)NSString *number    ;//
/**
 *总价
 */
@property(nonatomic, strong)NSString *totalPrice;//
@property(nonatomic, strong)NSString *inventory;
@property(nonatomic, strong)NSString *thenGroup;
/**
 *规格
 */
@property(nonatomic, strong)NSString *unit;
@property(nonatomic, strong)NSString *rawPrice;

@property(nonatomic, strong)NSString *spellType;
/**
 *状态(1:未支付；2：已支付;9:删除)
 */
@property(nonatomic, strong)NSString *status;
@end

NS_ASSUME_NONNULL_END

/**
 
 {
 addTime = "2019-03-20T23:51:59.477";
 clubId = "9dc3375a-ec52-4fc2-8169-11f03d9fdf26";
 createTime = "2019-03-20T01:39:18.333";
 creater = "f6b60df4-3fb8-4c56-afd7-599141f24be4";
 goodsName = "\U4e03\U5929\U51cf\U4e94\U65a4";
 goodsNote = "<p><img src=\"http://admin.laiscn.comhttp://admin.laiscn.com/upload/image/20190320/6368864271536472722403152.jpg\" title=\"timg (1).jpg\" alt=\"timg (1).jpg\"/></p>";
 goodsUrl = "http://47.99.100.88:81/file/showimg?filename=20190320013844.jpg";
 id = "8cf2affa-bf16-433b-a4d6-6b070b59f96e";
 indentCode = 20190320235159198642;
 inventory = 20000;
 linkPhone = 15956956601;
 merchantId = "5f17d55e-b4b9-43c0-8834-202b6815d66f";
 number = 1;
 price = 1;
 rawPrice = 100;
 receiveAddress = "\U4ebf\U542f\U83b1\U4ff1\U4e50\U90e8";
 spellNumber = 10;
 spellStatus = 1;
 spellType = 1;
 status = 2;
 substationId = "4554081b-aa46-48d4-a5f9-0472a38a6f5f";
 thenGroup = 0;
 totalPrice = 1;
 unit = "\U6b21";
 }
 
 */
