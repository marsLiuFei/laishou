//
//  CSPersonalInfoModel.h
//  caishou
//
//  Created by 刘飞 on 2019/3/6.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSPersonalInfoModel : NSObject
/**
 * 会员头像
 */
@property(nonatomic, strong)NSString *headImg;
/**
 * 平台注册多少天
 */
@property(nonatomic, strong)NSString *registerDay;

/**
 * 分站ID
 */
@property(nonatomic, strong)NSString *substationId;
/**
 *俱乐部名称
 */
@property(nonatomic, strong)NSString *clubName;
/**
 *俱乐部地址
 */
@property(nonatomic, strong)NSString *clubAddress;
/**
 *顾问姓名
 */
@property(nonatomic, strong)NSString *counselorName;
/**
 *顾问手机号
 */
@property(nonatomic, strong)NSString *counselorMobile;
/**
 *顾问标签
 */
@property(nonatomic, strong)NSString *label;
/**
 *订单数
 */
@property(nonatomic, strong)NSString *indentNumber;
/**
 *收藏数
 */
@property(nonatomic, strong)NSString *collectNumber;
/**
 * 顾问ID
 */
@property(nonatomic, strong)NSString *ID;
/**
 *俱乐部id
 */
@property(nonatomic, strong)NSString *clubId;
/**
 *登录id
 */
@property(nonatomic, strong)NSString *loginId;


/**
 *会员姓名
 */
@property(nonatomic, strong)NSString *name;
/**
 *会员手机号
 */
@property(nonatomic, strong)NSString *mobile;
/**
 *顾问id
 */
@property(nonatomic, strong)NSString *counselorId;
/**
 *推荐人id
 */
@property(nonatomic, strong)NSString *recommendId;
/**
 *剩余积分
 */
@property(nonatomic, strong)NSString *integral;
/**
 *最后签到时间
 */
@property(nonatomic, strong)NSString *lastSignTime;
/**
 *状态（0:正常;1:删除）
 */
@property(nonatomic, strong)NSString *states;
/**
 *创建人id
 */
@property(nonatomic, strong)NSString *creater;
/**
 *创建时间
 */
@property(nonatomic, strong)NSString *createTime;
/**
 *性别(0:女;1:男)
 */
@property(nonatomic, strong)NSString *sex;
/**
 *出生日期
 */
@property(nonatomic, strong)NSString *birthday;

/**
 *身高
 */
@property(nonatomic, strong)NSString *height;
/**
 *当前体重
 */
@property(nonatomic, strong)NSString *weight;
/**
 *喜好集合
 */
@property(nonatomic, strong)NSString *befond;
/**
 *所属行业
 */
@property(nonatomic, strong)NSString *industry;
/**
 *工作职位
 */
@property(nonatomic, strong)NSString *job;
/**
 *目标体重
 */
@property(nonatomic, strong)NSString *targetWeight;
/**
 *今日是否签到（true:已签到;false:未签到）
 */
@property(nonatomic, strong)NSString *isSign;
/**
 *
 */
@property(nonatomic, strong)NSString *bmi;
/**
 * 胸围
 */
@property(nonatomic, strong)NSString *chestWai;
/**
 *顾问头像
 */
@property(nonatomic, strong)NSString *counselorHeadImg;
/**
 *
 */
@property(nonatomic, strong)NSString *fatRate;
/**
 * 臀围
 */
@property(nonatomic, strong)NSString *hipWai;
/**
 *
 */
@property(nonatomic, strong)NSString *strCreateTime;
/**
 *
 */
@property(nonatomic, strong)NSString *thenLose;
/**
 *俱乐部人数
 */
@property(nonatomic, strong)NSString *userNumber;
/**
 * 腰围
 */
@property(nonatomic, strong)NSString *waistWai;



/**
 * 顾问信息里面的备注信息
 */
@property(nonatomic, strong)NSString *introduce;
/**
 *顾问标签
 */
//@property(nonatomic, strong)NSString *label;
@property(nonatomic, assign)BOOL isRecommend;
@end

NS_ASSUME_NONNULL_END

/**
 
 befond = "\U8db3\U7403,";
 birthday = "2019-03-19";
 bmi = "6.53";
 chestWai = "<null>";
 clubAddress = "<null>";
 clubId = "00000000-0000-0000-0000-000000000000";
 clubName = "<null>";
 collectNumber = 0;
 counselorHeadImg = "http://47.99.100.88:81/file/showimg?filename=201903061111.jpg";
 counselorId = "00000000-0000-0000-0000-000000000000";
 counselorMobile = "<null>";
 counselorName = "<null>";
 createTime = "2019-03-18T20:35:19.257";
 creater = "29f1bdb2-2101-4caa-92eb-4ca2a5a08470";
 fatRate = "-8.359999999999999";
 headImg = "http://47.99.100.88:81/file/showimg?filename=201903211429404177.png";
 height = 175;
 hipWai = "<null>";
 id = "2de0bac2-4e22-460a-80f7-a5d38f8136c9";
 indentNumber = 0;
 industry = "IT\U8ba1\U7b97\U673a";
 integral = 30;
 isSign = 1;
 job = "\U662f";
 label = "<null>";
 lastSignTime = "2019-03-21T09:26:22.537";
 loginId = "29f1bdb2-2101-4caa-92eb-4ca2a5a08470";
 mobile = 13075505025;
 name = "\U5f20\U4e09";
 recommendId = "00000000-0000-0000-0000-000000000000";
 registerDay = 3;
 sex = 1;
 states = 0;
 strCreateTime = "<null>";
 targetWeight = "<null>";
 thenLose = "-2483";
 userNumber = 0;
 waistWai = "<null>";
 weight = 20;
 */
