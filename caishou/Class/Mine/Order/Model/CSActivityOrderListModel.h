//
//  CSActivityOrderListModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSActivityOrderListModel : NSObject
/**
 *    订单id
 */
@property(nonatomic, strong)NSString *ID;
/**
 *    状态(1:未支付；2：已支付;9:删除)
 */
@property(nonatomic, strong)NSString *states ;
/**
 *   创建人id
 */
@property(nonatomic, strong)NSString *creater  ;
/**
 *    创建时间
 */
@property(nonatomic, strong)NSString *createTime ;
/**
 *    活动标题
 */
@property(nonatomic, strong)NSString *activityTitle  ;
/**
 *    活动类型（1:毅行;2:公益;3:聚会;4:培训;5:旅游;6:运动;7:美容;8:才艺;9:电影;）
 */
@property(nonatomic, strong)NSString *activityType  ;
/**
 *    活动id
 */
@property(nonatomic, strong)NSString *activityId ;
/**
 *    参与方式(1:金额;2:积分)
 */
@property(nonatomic, strong)NSString *signType ;
/**
 *   金额/积分数
 */
@property(nonatomic, strong)NSString *price ;
/**
 *    活动图片
 */
@property(nonatomic, strong)NSString *img;
/**
 *    报名状态（1:未支付;2:已支付;）
 */
@property(nonatomic, strong)NSString *appStatus ;
/**
 *    活动状态（1:未开始;2:进行中;3:已结束;）
 */
@property(nonatomic, strong)NSString *appActivityStatus ;
/**
 *    活动内容
 */
@property(nonatomic, strong)NSString *activityContent ;
/**
 *    俱乐部地址
 */
@property(nonatomic, strong)NSString *clubAddress;
/**
 *  俱乐部名称
 */
@property(nonatomic, strong)NSString *clubName ;
/**
 *    俱乐部联系电话
 */
@property(nonatomic, strong)NSString *clubPhone;


//以下为缺少字段
@property(nonatomic, strong)NSString *indentCode;

@property(nonatomic, strong)NSString *myIndent;
@property(nonatomic, strong)NSString *strEndTime;
@property(nonatomic, strong)NSString *strStartTime;
@end





/**
 activityContent
 activityId = "21bb7865-7685-4de2-a2aa-a1ec0ca9d4f6";
 activityTitle = "\U4e00\U5206\U94b1\U51cf20\U516c\U65a4";
 activityType = 2;
 appActivityStatus = 2;
 appStatus = 2;
 clubAddress = "\U5b89\U5fbd\U7701\U5408\U80a5\U5e02\U897f\U4e00\U73af\U897f38\U6240\U56fd\U9632\U901a\U9053\U4e94\U91cc\U5546\U53a6";
 clubName = "\U683c\U683c\U751f\U6d3b\U9986";
 clubPhone = 15956956601;
 createTime = "2019-03-22T12:48:01.803";
 creater = "29f1bdb2-2101-4caa-92eb-4ca2a5a08470";
 endTime = "2019-03-27T20:09:00";
 id = "d62bae9e-4914-48e4-aab3-c7b512d5b07d";
 img = "http://47.99.100.88:81/file/showimg?filename=20190320201133.jpg";
 myIndent = "<null>";
 price = "0.01";
 signType = 1;
 startTime = "2019-03-20T20:09:00";
 status = 2;
 strEndTime = "<null>";
 strStartTime = "<null>";
 
 */



NS_ASSUME_NONNULL_END
