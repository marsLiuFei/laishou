//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//  CSCouponViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/3.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCouponViewController.h"
#import "CSUnusedCouponController.h"
#import "CSUsedCouponController.h"
#import "CSExpiredCouponController.h"


@interface CSCouponViewController ()

@property(nonatomic,strong)NSArray * titleArray;

@end

@implementation CSCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     [self setupUI];
    
}
#pragma mark -  setupUI
- (void)setupUI {
    self.navigationItem.title = @"菜瘦神券";
    self.titleArray = @[@"未使用",@"已使用",@"已过期"];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setTabBarFrame:CGRectMake(0, 0, screenSize.width, 44)
        contentViewFrame:CGRectMake(0, 44, screenSize.width, screenSize.height - 44 - kTabBarHeight)];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.itemTitleColor = RGB(102, 102, 102);
    self.tabBar.itemTitleSelectedColor = MainColor;
    self.tabBar.itemTitleFont = [UIFont fontWithName:@"PingFangSC-Regular" size: 16];
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = MainColor;
    [self.tabBar setIndicatorWidthFitTextAndMarginTop:40 marginBottom:2 widthAdditional:0 tapSwitchAnimated:true];
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    [self.tabContentView setContentScrollEnabled:YES tapSwitchAnimated:NO];
    [self.yp_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
    
    [self initViewControllers];
}

- (void)initViewControllers {
    CSUnusedCouponController *controller0 = [[CSUnusedCouponController alloc] init];
    controller0.yp_tabItemTitle = self.titleArray[0];
    
    CSUsedCouponController *controller1 = [[CSUsedCouponController alloc] init];
    controller1.yp_tabItemTitle = self.titleArray[1];
    
    CSExpiredCouponController *controller2 = [[CSExpiredCouponController alloc] init];
    controller2.yp_tabItemTitle = self.titleArray[2];
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller0,controller1, controller2, nil];
}


@end
