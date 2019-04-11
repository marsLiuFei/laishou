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
//  CSBrowseHistoryViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/2.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBrowseHistoryViewController.h"
#import "CSCounselorBrowseViewController.h"
#import "CSClubBrowseViewController.h"
#import "CSCircleBrowseViewController.h"

@interface CSBrowseHistoryViewController ()


@property(nonatomic,strong)NSArray * titleArray;

@end

@implementation CSBrowseHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

#pragma mark -  setupUI
- (void)setupUI {
    self.navigationItem.title = @"浏览记录";
    self.titleArray = @[@"顾问",@"俱乐部",@"莱瘦圈"];
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
    CSCounselorBrowseViewController *controller0 = [[CSCounselorBrowseViewController alloc] init];
    controller0.yp_tabItemTitle = self.titleArray[0];
    
    CSClubBrowseViewController *controller1 = [[CSClubBrowseViewController alloc] init];
    controller1.yp_tabItemTitle = self.titleArray[1];
    
    CSCircleBrowseViewController *controller2 = [[CSCircleBrowseViewController alloc] init];
    controller2.yp_tabItemTitle = self.titleArray[2];
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller0,controller1, controller2, nil];
}


@end
