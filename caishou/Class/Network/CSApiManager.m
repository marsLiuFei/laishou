//
//  CSApiManager.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/2.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSApiManager.h"
#import "CSNetwork.h"

@implementation CSApiManager

/**
 *  请求验证码接口
 *  @param paramDic 字典信息
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)getMsgCodeWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Register/SendAuthCode" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  注册接口
 *  @param paramDic 字典信息
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)userRegisterWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Register/UserRegister" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  修改密码接口
 *  @param paramDic 字典信息
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)forgetPwdWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Register/ForgetPwd" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  登录接口
 *  @param paramDic 字典信息
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)userLoginWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Login/UserLogin" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  签到接口
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)daySignCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/DaySign" param:@{} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  我的信息接口
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)myLoginInfoCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/MyLoginInfo" param:@{} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  获取顾问登录信息接口
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)CounselorInfoCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/CounselorInfo" param:@{} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

+ (void)putMyInfoWithParamDic:(NSDictionary *)paramDic CallBack:(void (^)(id _Nonnull))callBack fail:(void (^)(NSError * _Nonnull))fail
{
    [CSNetwork postWithUrl:@"User/UpdateUser" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 我的PK信息
 
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)myPkInfoCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"/User/MyPK" param:@{} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  获取当前分站接口
 *  @param paramDic 字典信息
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)locationWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Home/Location" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  获取所有分站列表接口
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)substationListCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Home/SubstationList" param:@{} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取首页广告列表接口
 *  @param substationId 分站ID
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)advListWithSubstationId:(NSString *)substationId CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Home/AdvList" param:@{@"substationId":substationId} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取首页推荐俱乐部/顾问接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)recommendWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Home/Recommend" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取分页推荐俱乐部接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)clubPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Home/ClubPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取分页顾问接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)counselorPageeWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Home/CounselorPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}


/**
 *  获取热门活动分页接口
 *  @param paramDic 参数  articleType 活动类型（1:毅行;2:公益;3:聚会;4:培训;5:旅游;6:运动;7:美容;8:才艺;9:电影;0:全部））
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)activityPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Activity/ActivityPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}


/**
 *  获取文章分页接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)articlePageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Article/ArticlePage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取达人分页接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)severeUserPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Article/SevereUserPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取收藏分页接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)myArticlePageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/MyArticlePage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取俱乐部详情接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)clubDetailsWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Club/ClubDetails" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  获取顾问详情接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)counselorDetailsWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Counselor/CounselorDetails" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  修改顾问简介
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)updateIntroduceWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/UpdateIntroduce" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];

}
/**
 添加风采
 @param imageData 图片date
 @param name 名称
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)addMienImageWithImgeData:(NSData *)imageData name:(NSString *)name CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork uplodatImageWithpath:@"Upload/UploadImg" imgeData:imageData name:name Block:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (!error) {
            NSString *fileName = data[@"data"][@"fileName"];
            [CSNetwork postWithUrl:@"User/AddMien" param:@{@"picture":fileName} block:^(id  _Nonnull data) {
                callBack(data);
            } fail:^(NSError * _Nonnull errorString) {
                fail(errorString);
            }];
        }else {
            fail(error);
        }
    }];
}


/**
 *  获取积分商品分页接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)goodsPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Goods/GoodsPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取积分兑换商品接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)exchangeIntegralGoodsWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/Exchange" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  积分参加活动接口
 *  @param activityID 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)IntegralSignWithActivityID:(NSString *)activityID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/IntegralSign" param:@{@"id":isEmptyStr(activityID)?@"":activityID} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  获取今日是否签到接口
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)getDayIsSignStatusCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/DayIsSign" param:@{} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取优惠|拼团商品列表接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)mySpellGoodsListeWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"SpellGoods/SpellPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}


/**
 *  收藏接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)collectWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/Collect" param:@{@"id":isEmptyStr(ID)?@"":ID} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  取消收藏接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)deleteCollectWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/DeleteMyCollect" param:@{@"id":isEmptyStr(ID)?@"":ID} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  发起拼团接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)SpellWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/Spell" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取积分订单接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)IndentPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/IndentPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取活动订单接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)myActivityPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/MyActivityPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取拼团订单接口
 *  @param paramDic 参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)MySpellPagePageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/MySpellPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  活动详情接口接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)activityDetailsWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Activity/ActivityDetails" param:@{@"id":isEmptyStr(ID)?@"":ID} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  活动详情报名人数列表接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)activityDetailsSignPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"Activity/SignPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  支付参加活动接口
 *  @param paramDic  参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)PaySignWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/PaySign" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  我的活动订单页面支付参加活动接口
 *  @param paramDic  参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)IndentPayWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/IndentPay" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  绑定俱乐部接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)BindingClubWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    NSString *substationId = [UDefault getObject:NowSiteId];
    [CSNetwork postWithUrl:@"User/BindingClub" param:@{@"clubId":isEmptyStr(ID)?@"":ID,@"substationId":substationId} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  绑定顾问接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)BindingCounselorWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    NSString *substationId = [UDefault getObject:NowSiteId];
    [CSNetwork postWithUrl:@"User/BindingCounselor" param:@{@"counselorId":isEmptyStr(ID)?@"":ID,@"substationId":substationId} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 上传图片
 
 @param imageData 图片date
 @param name 名称
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)uploadHeaderImageWithImgeData:(NSData *)imageData name:(NSString *)name CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork uplodatImageWithpath:@"Upload/UploadImg" imgeData:imageData name:name Block:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (!error) {
            NSString *fileName = data[@"data"][@"fileName"];
            [CSNetwork postWithUrl:@"User/UploadHead" param:@{@"headImg":fileName} block:^(id  _Nonnull data) {
                callBack(data);
            } fail:^(NSError * _Nonnull errorString) {
                fail(errorString);
            }];
        }else {
             fail(error);
        }
    }];
}
/**
 上传顾问头像
 
 @param imageData 图片date
 @param name 名称
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)uploadCounselorHeaderImageWithImgeData:(NSData *)imageData name:(NSString *)name CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork uplodatImageWithpath:@"User/CounselorHead" imgeData:imageData name:name Block:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (!error) {
            NSString *fileName = data[@"data"][@"fileName"];
            [CSNetwork postWithUrl:@"/User/CounselorHead" param:@{@"headImg":fileName} block:^(id  _Nonnull data) {
                callBack(data);
            } fail:^(NSError * _Nonnull errorString) {
                fail(errorString);
            }];
        }else {
            fail(error);
        }
    }];
}

/**
 减肥记录
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)myWeightWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/LoseWeightPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 增加减肥记录
 
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)addWeightRecordWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/LoseWeight" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}


/**
 *  莱购商品详情接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)SpellDetailsWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    NSString *substationId = [UDefault getObject:NowSiteId];
    [CSNetwork postWithUrl:@"SpellGoods/SpellDetails" param:@{@"id":isEmptyStr(ID)?@"":ID,@"substationId":substationId} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}


/**
 添加 圈子
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)AddPhotoWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/AddPhoto" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 圈子分页
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)PhotoPageWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/PhotoPage" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}



/**
 取消积分订单
 
 @param orderID 订单号
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)DeleteIndentWithOrderID:(NSString *)orderID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/DeleteIndent" param:@{@"id":isEmptyStr(orderID)?@"":orderID} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 删除拼团订单
 
 @param orderID 订单号
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)DeleteSpellUserWithOrderID:(NSString *)orderID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/DeleteSpellUser" param:@{@"id":isEmptyStr(orderID)?@"":orderID} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 删除活动订单
 
 @param orderID 订单号
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)DeleteActivityWithOrderID:(NSString *)orderID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/DeleteActivity" param:@{@"id":isEmptyStr(orderID)?@"":orderID} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 *  获取拼团链接接口
 *  @param ID  收藏对象的ID参数
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)SpellUrlWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail
{
    [CSNetwork postWithUrl:@"User/SpellUrl" param:@{@"id":isEmptyStr(ID)?@"":ID} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取文章分享地址接口
 *  @param ID  文章id
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)ShareArticleWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/ShareArticle" param:@{@"id":isEmptyStr(ID)?@"":ID} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 修改密码
 
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)updatePwdWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/UpdatePwd" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 顾问推广
 
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+(void)counselorPromoteWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/CounselorPromote" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 会员推广
 
 @param paramDic 参数
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+(void)userPromoteWithParamDic:(NSDictionary *)paramDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/UserPromote" param:paramDic block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  分享推广
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)SharePromoteCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/SharePromote" param:@{} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 *  获取活动分享地址接口
 *  @param ID  文章id
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)ActivityUrlWithID:(NSString *)ID CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail{
    [CSNetwork postWithUrl:@"Activity/ActivityUrl" param:@{@"id":isEmptyStr(ID)?@"":ID} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}
/**
 检查版本更新
 @param callBack 返回成功信息信息
 @param fail  返回失败信息
 */
+ (void )checkUpdateCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    NSDictionary *params = @{
                             @"appType":@"ios",
                             @"versionNumber":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]};
    [CSNetwork postWithUrl:@"Version/CheckVersion" param:params block:^(id data) {
       callBack(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
/**
 *  分享pk
 *  @param callBack 返回成功信息信息
 *  @param fail     返回失败信息
 */
+ (void)SharePKWithDayNumber:(NSString *)dayNumber CallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/SharePK" param:@{@"dayNumber":dayNumber} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

/**
 参与pk
 @param pkuser 发起方id
 @param callBack 返回成功信息信息
 @param fail 返回失败信息
 */
+ (void)userPkWithId:(NSString *)pkuser InfoCallBack:(void(^)(id data))callBack fail:(void(^)(NSError *error))fail {
    [CSNetwork postWithUrl:@"User/PK" param:@{@"pkId":pkuser} block:^(id  _Nonnull data) {
        callBack(data);
    } fail:^(NSError * _Nonnull errorString) {
        fail(errorString);
    }];
}

@end
