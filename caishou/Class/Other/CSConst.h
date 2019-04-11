//
//  CSConst.h
//  caishou
//
//  Created by 刘飞 on 2019/2/19.
//  Copyright © 2019年 mars. All rights reserved.
//http://47.99.100.88:81/api/secret

#ifndef CSConst_h
#define CSConst_h

//#define BaseUrl @"http://47.94.172.208:20192/api/"
//#define SERVICEURL @"http://47.94.172.208:20192"

#define BaseUrl @"http://47.99.100.88:81/api/"
#define SERVICEURL @"http://47.99.100.88:81"

//是否登录通过authkey来a判断
#define AuthKey  @"authkey"
//登录者身份类型
#define LoginType  @"loginType"
#define ISLOGIN (!isEmptyStr([UDefault getObject:AuthKey]))
//当前分站ID
#define NowSiteId @"NowSiteId"
//当前经纬度信息
#define NowLocationDic @"NowLocationDic"

//1:首页顶部，2：中间广告大图，3/4：中间小图，5：俱乐部顶部图片，6：顾问顶部图片，7：活动，8-莱购
////顾问分页海报
//#define CounselorPagePosterImg @"CounselorPosterImg"
//俱乐部分页海报
//#define ClubPagePosterImgDic @"ClubPagePosterImgDic"
//活动分页海报
//#define ActivityPosterImg @"ActivityPosterImg"
//莱购分页海报
//#define FitPosterImg @"FitPosterImg"




#define ws(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define StrongSelf(type)  __strong typeof(type) type     = weak##type;

//TabBar Nav  高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

#define NAV_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define SafeAreaHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)

//屏幕大小、宽高
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define BOTTOM_HEIGHT (([UIScreen mainScreen].bounds.size.width)>375?65:52)   //SCREEN_WIDTH/5

//颜色 Color
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define NAV_COLOR RGB(48,192,63) //导航颜色
#define MainColor RGB(48,192,63)

#define LineCOLOE RGB(239,239,239) //线颜色
#define COMMON_BACK_COLOR RGB(247,247,247)//背景颜色
#define COMMON_TITLE_COLOE RGB(27,112,255)
#define COMMON_LIGHT_COLOR RGB(27,112,255)
#define PlaceImg [UIImage imageNamed:@""]//占位图
#define kColorTableBG RGB(250,250,250)
#define NORMAL_BGCOLOR RGB(248, 248, 248)
#define StarsColor RGB(254,171,6)


#define RGB44 RGB(44, 44, 44)
#define RGB102 RGB(102, 102, 102)
#define RGB153 RGB(153, 153, 153)

//DeBugLog
#define MYLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])

//空判断相关
#define isEmptyStr(str) (!str||[str isKindOfClass:[NSNull class]]||[str isEqualToString:@""]) //判断是否空字符串
#define isEmptyArr(arr) (!arr||((NSArray *)arr).count==0) //判断是否空数组
#define isEmptyDic(dic) (!dic||[dic isKindOfClass:[NSNull class]]|| dic.allKeys.count == 0) //判断是否空字典
#define isNull(str)     (!str||[str isKindOfClass:[NSNull class]])


#define SIZE(S)  [MyAdapter laDapter:S]
#define FONT(S)  [MyAdapter lfontADapter:S]
#define  MediumFont(x) [UIFont fontWithName:@"PingFangSC-Medium" size:SIZE(x)]
#define  RegularFont(x) [UIFont fontWithName:@"PingFangSC-Regular" size:SIZE(x)]

//返回结果正确
#define ResultIsCorrect [[NSString stringWithFormat:@"%@",data[@"code"]] isEqualToString:@"200"]
//返回的提示信息
#define BackMessage [NSString stringWithFormat:@"%@",data[@"message"]]




//通知中心
#define NSNotic_Center [NSNotificationCenter defaultCenter]
//支付回调
#define WXPAY @"weixinPaystatusSuccess"
#define ALIPAY @"listenAlipayResults"
#define LOGINSUCCESS @"LOGINSUCCESS"
#define OrderPaySuccess @"orderPaySuccess"
#define PayIntegralGoodsSuccess @"PayIntegralGoodsSuccess"

#endif /* CSConst_h */
