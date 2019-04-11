//
//  CSApiManager.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/2.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSApiManager : NSObject

/**
 *  请求验证码接口
 *  @param paramDic 字典信息
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)getMsgCodeWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  注册接口
 *  @param paramDic 字典信息
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)userRegisterWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  修改密码接口
 *  @param paramDic 字典信息
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)forgetPwdWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  登录接口
 *  @param paramDic 字典信息
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)userLoginWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  签到接口
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)daySignCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  我的信息接口
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)myLoginInfoCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取顾问登录信息接口
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)CounselorInfoCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;


/**
 提交我的信息接口

 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)putMyInfoWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 我的PK信息

 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)myPkInfoCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;





/**
 *  获取当前分站接口
 *  @param paramDic 字典信息
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)locationWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取所有分站列表接口
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)substationListCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 *  获取首页广告列表接口
 *  @param substationId 分站ID
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)advListWithSubstationId:(NSString *)substationId CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取首页推荐俱乐部/顾问接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)recommendWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取分页俱乐部接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)clubPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取分页顾问接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)counselorPageeWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 *  获取活动分页接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)activityPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 *  获取文章分页接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)articlePageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取达人分页接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)severeUserPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取收藏分页接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)myArticlePageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取俱乐部详情接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)clubDetailsWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取顾问详情接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)counselorDetailsWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 *  修改顾问简介
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)updateIntroduceWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 添加风采
 @param imageData 图片date
 @param name 名称
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)addMienImageWithImgeData:(NSData *)imageData name:(NSString *)name CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;



/**
 *  获取积分商品分页接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)goodsPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取积分兑换商品接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)exchangeIntegralGoodsWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  积分参加活动接口
 *  @param activityID 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)IntegralSignWithActivityID:(NSString *)activityID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取今日是否签到接口
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)getDayIsSignStatusCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取优惠|拼团商品列表接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)mySpellGoodsListeWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  收藏接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)collectWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  取消收藏接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)deleteCollectWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  发起拼团接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)SpellWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 *  获取积分订单接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)IndentPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取活动订单接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)myActivityPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取拼团订单接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)MySpellPagePageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  活动详情接口接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)activityDetailsWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  活动详情报名人数列表接口
 *  @param paramDic  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)activityDetailsSignPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  支付参加活动接口
 *  @param paramDic  参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)PaySignWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  我的活动订单页面支付参加活动接口
 *  @param paramDic  参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)IndentPayWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  绑定俱乐部接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)BindingClubWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  绑定顾问接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)BindingCounselorWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  莱购商品详情接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)SpellDetailsWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取h文章分享地址接口
 *  @param ID  文章id
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)ShareArticleWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 上传图片

 @param imageData 图片date
 @param name 名称
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)uploadHeaderImageWithImgeData:(NSData *)imageData name:(NSString *)name CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 上传顾问头像

 @param imageData 图片date
 @param name 名称
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)uploadCounselorHeaderImageWithImgeData:(NSData *)imageData name:(NSString *)name CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;


/**
 减肥记录

 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)myWeightWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 增加减肥记录
 
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)addWeightRecordWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 添加 圈子
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)AddPhotoWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 圈子分页
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)PhotoPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 取消积分订单
 
 @param orderID 订单号
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)DeleteIndentWithOrderID:(NSString *)orderID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 删除拼团订单
 
 @param orderID 订单号
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)DeleteSpellUserWithOrderID:(NSString *)orderID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 删除活动订单
 
 @param orderID 订单号
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)DeleteActivityWithOrderID:(NSString *)orderID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取拼团链接接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)SpellUrlWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 修改密码

 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)updatePwdWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  获取活动分享地址接口
 *  @param ID  文章id
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)ActivityUrlWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 顾问推广
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+(void)counselorPromoteWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 会员推广
 
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+(void)userPromoteWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  分享推广
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)SharePromoteCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;

/**
 检查版本更新

 @param callBack 返回成功信息信息
 @param fail  返回失败信息
 */
+ (void )checkUpdateCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 *  分享pk
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)SharePKWithDayNumber:(NSString *)dayNumber CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
/**
 参与pk
 @param pkuser 发起方id
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)userPkWithId:(NSString *)pkuser InfoCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail;
@end

NS_ASSUME_NONNULL_END
