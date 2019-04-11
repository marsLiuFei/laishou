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
//  CSOrderViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/6.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSOrderViewController.h"

#import "CSIntegralOrderViewController.h"
#import "CSGroupBookingViewController.h"
#import "CSActivityOrderViewController.h"

@interface CSOrderViewController ()
@property(nonatomic,strong)NSArray * titleArray;

@end

@implementation CSOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark -  setupUI
- (void)setupUI {
    self.navigationItem.title = @"我的订单";
    self.titleArray = @[@"积分订单",@"拼团订单",@"活动订单"];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setTabBarFrame:CGRectMake(0, 0, screenSize.width, 44)
        contentViewFrame:CGRectMake(0, 44, screenSize.width, screenSize.height - 44 - kTabBarHeight)];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.itemTitleColor = RGB(102, 102, 102);
    self.tabBar.itemTitleSelectedColor = MainColor;
    self.tabBar.itemTitleFont = RegularFont(16);
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = MainColor;
    [self.tabBar setIndicatorWidth:SCREEN_WIDTH /3 marginTop:40 marginBottom:2 tapSwitchAnimated:true];
//    [self.tabBar setIndicatorWidth:40 marginBottom:2 widthAdditional:0 tapSwitchAnimated:true];
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    [self.tabContentView setContentScrollEnabled:YES tapSwitchAnimated:NO];
    [self.yp_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
    
    [self initViewControllers];
}

- (void)initViewControllers {
    CSIntegralOrderViewController *controller0 = [[CSIntegralOrderViewController alloc] init];
    controller0.yp_tabItemTitle = self.titleArray[0];

    CSGroupBookingViewController *controller1 = [[CSGroupBookingViewController alloc] init];
    controller1.yp_tabItemTitle = self.titleArray[1];

    CSActivityOrderViewController *controller2 = [[CSActivityOrderViewController alloc] init];
    controller2.yp_tabItemTitle = self.titleArray[2];

    self.viewControllers = [NSMutableArray arrayWithObjects:controller0,controller1, controller2, nil];
}

-(void)setSelectedIndx:(NSInteger)selectedIndx{
    _selectedIndx = selectedIndx;
    self.tabBar.selectedItemIndex = self.selectedIndx;
}


@end
