//
//  AppDelegate.m
//  caishou
//
//  Created by 刘飞 on 2019/2/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "AppDelegate.h"
#import "CSBaseTabbarController.h"
#import "XBUMManager.h"
#import "LF_ShowVersionView.h"
#import "UIViewController+Nav.h"

#import "XBStartPageView.h"

#import "CSBenifitGoodsDetailViewController.h"
#import "CSActivityDetailViewController.h"
#import "CSPKViewController.h"
#import "CSGuideViewController.h"

@interface AppDelegate ()<WXApiDelegate>
{
    LF_ShowVersionView *versionView;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [XBUMManager initUmManagerWithLaunchOptions:launchOptions Delegate:self];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self initTabbarController];
    return YES;
}
- (void )initTabbarController{
    
//    XBStartPageView * startPageView = [[XBStartPageView alloc]initWithContentURL:@"viewer_icon" animateSpeciesType:XBLaunchAnimateImage showSkipButton:NO downSeconds:3];
//    startPageView.complete = ^{
//        //倒计时动画完成
//        
//    };
//    [startPageView show];

    NSString *shortVersionStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"shortVersion"];
    NSString* shortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (shortVersionStr==nil || ![shortVersionStr isEqualToString: shortVersion]){
        CSGuideViewController *guideVC = [[CSGuideViewController alloc] init];
        self.window.rootViewController = guideVC;
        [[NSUserDefaults standardUserDefaults] setObject:shortVersion forKey:@"shortVersion"];
    }else{
        self.window.rootViewController = [[CSBaseTabbarController alloc]init];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
/***********************支付宝支付相关*****************************************/

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    if([url.absoluteString rangeOfString:@"wx976d46f7fcb104aa"].location != NSNotFound){
        //微信支付返回
        return  [WXApi handleOpenURL:url delegate:self];
    };
    if (result == FALSE) {
        //支付结果回调
        if ([url.host isEqualToString:@"safepay"]) {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                [NSNotic_Center postNotificationName:ALIPAY object:self userInfo:@{@"resultDic":resultDic}];
                
            }];
        }
    }
    return result;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    NSString *urlStr = url.absoluteString;
    if ([urlStr containsString:@"laishou"]) {
        if ([urlStr containsString:@"share.com/joinactivity"]) {
            //活动 laishou://share.com/joinactivity?id=f79824cb-81b2-42dd-aecf-af42d8787549&random=201903251514492611
            NSRange idRange = [urlStr rangeOfString:@"id="];
            NSString *IDLaterStr = [urlStr substringFromIndex:idRange.location+idRange.length];
            NSRange indentCodeRange = [IDLaterStr rangeOfString:@"&random="];
            NSString *ID = [IDLaterStr substringToIndex:indentCodeRange.location];
            MYLog(@"%@",urlStr);
            CSActivityDetailViewController *vc = [CSActivityDetailViewController new];
            vc.activityID = ID;
            [[UIApplication sharedApplication].keyWindow.rootViewController.myNavigationController pushViewController:vc animated:YES];
        }
        if ([urlStr containsString:@"share.com/discount"]) {
            //拼团 laishou://share.com/discount?id=8cf2affa-bf16-433b-a4d6-6b070b59f96e&indentCode=20190321154614128614
            MYLog(@"%@",urlStr);
            NSRange idRange = [urlStr rangeOfString:@"id="];
            NSString *IDLaterStr = [urlStr substringFromIndex:idRange.location+idRange.length];
            NSRange indentCodeRange = [IDLaterStr rangeOfString:@"&indentCode="];
            NSString *ID = [IDLaterStr substringToIndex:indentCodeRange.location];
            NSString *indentCode = [IDLaterStr substringFromIndex:indentCodeRange.location+indentCodeRange.length];
            
            CSBenifitGoodsDetailViewController *vc = [CSBenifitGoodsDetailViewController new];
            vc.goodsID = ID;
            vc.indentCode = indentCode;
            [[UIApplication sharedApplication].keyWindow.rootViewController.myNavigationController pushViewController:vc animated:YES];

            
            MYLog(@"%@ - %@",ID,indentCode);
        }
        if ([urlStr containsString:@"share.com/pk"]) {
            //PK laishou://share.com/pk?pkuser=29f1bdb2-2101-4caa-92eb-4ca2a5a08470&random=201903251715276698
            MYLog(@"%@",urlStr);
            NSRange idRange = [urlStr rangeOfString:@"pkuser="];
            NSString *IDLaterStr = [urlStr substringFromIndex:idRange.location+idRange.length];
            NSRange indentCodeRange = [IDLaterStr rangeOfString:@"&random="];
            NSString *pkuser = [IDLaterStr substringToIndex:indentCodeRange.location];
            CSPKViewController *vc = [CSPKViewController new];
            vc.pkuser = pkuser;
            [[UIApplication sharedApplication].keyWindow.rootViewController.myNavigationController pushViewController:vc animated:false];
        }
    }
    
    
    //支付结果回调
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [NSNotic_Center postNotificationName:ALIPAY object:self userInfo:@{@"resultDic":resultDic}];
            
        }];
        
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            MYLog(@"授权回调 -----  %@",resultDic);
//            [NSNotic_Center postNotificationName:ALIPAYLogin object:self userInfo:@{@"resultDic":resultDic}];
//        }];
        
    }
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if ([options[@"UIApplicationOpenURLOptionsSourceApplicationKey"] isEqualToString:@"com.tencent.xin"]&& [url.absoluteString containsString:@"pay"]){
        //微信支付返回
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

// 微信支付成功或者失败回调
-(void)onResp:(BaseResp*)resp
{
    NSInteger result = 0;
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
                case WXSuccess:{
                    strMsg = @"恭喜您,支付成功!";
                    result = 1;
                    break;
                }
                case WXErrCodeUserCancel:{
                    strMsg = @"已取消支付!";
                    result = 2;
                    break;
                }
            default:{
                strMsg = [NSString stringWithFormat:@"支付失败!"];
                result = 0;
                break;
            }
        }
        [NSNotic_Center postNotificationName:WXPAY object:nil userInfo:@{@"status":strMsg,@"result":@(result)}];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self checkVersion];
}
- (void )checkVersion{
    
    [CSApiManager checkUpdateCallBack:^(id  _Nonnull data) {
        if (ResultIsCorrect) {
            //获取版本信息成功
            NSDictionary *dict = data[@"data"];
            NSString *updataUrlStr = [NSString stringWithFormat:@"%@",dict[@"downloadUrl"]];
            NSString *str1 = [NSString stringWithFormat:@"%@",dict[@"versionNumber"]];
            [self->versionView removeFromSuperview];
            self->versionView =   [LF_ShowVersionView alterViewWithTitle:[NSString stringWithFormat:@"发现新版本v%@",str1] content:[NSString stringWithFormat:@"%@",dict[@"logContent"]] cancel:@"取消" sure:@"前往更新" cancelBtClcik:^{
                    
            } sureBtClcik:^{
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updataUrlStr]];
            }];
        }
    } fail:^(NSError * _Nonnull error) {
        
    }];
    
    
}


@end
