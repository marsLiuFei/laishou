//
//  CSBaseCircleViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseCircleViewController.h"
#import "CSOptimizeViewController.h"//精选
#import "CSExpertViewController.h"//达人
#import "CSActivityViewController.h"//活动
#import "CSSpecialInterviewViewController.h"//专访

@interface CSBaseCircleViewController ()
@property(nonatomic,strong)NSArray * titleArray;
@end

@implementation CSBaseCircleViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"莱瘦圈";
    
    UIImageView *imgView =  [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    imgView.hidden = YES;    
    
    self.titleArray = @[@"达人",@"攻略",@"莱课堂",@"莱视界"];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setTabBarFrame:CGRectMake(0, 0, screenSize.width, 44)
        contentViewFrame:CGRectMake(0, 44, screenSize.width, screenSize.height - 44 - kTabBarHeight)];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.itemTitleColor = [UIColor blackColor];
    self.tabBar.itemTitleSelectedColor = MainColor;
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:18];
//    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:18];
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    [self.tabBar setIndicatorWidthFitTextAndMarginTop:8 marginBottom:8 widthAdditional:20 tapSwitchAnimated:NO];
    [self.tabContentView setContentScrollEnabled:YES tapSwitchAnimated:NO];
    
    [self.yp_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
    
    [self initViewControllers];
    
}

//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (void)initViewControllers {
    CSExpertViewController *controller0 = [[CSExpertViewController alloc] init];
    controller0.yp_tabItemTitle = self.titleArray[0];
    
    CSActivityViewController *controller1 = [[CSActivityViewController alloc] init];
    controller1.yp_tabItemTitle = self.titleArray[1];
    
    CSOptimizeViewController *controller2 = [[CSOptimizeViewController alloc] init];
    controller2.yp_tabItemTitle = self.titleArray[2];
    
    
    
    
    
    CSSpecialInterviewViewController *controller3 = [[CSSpecialInterviewViewController alloc] init];
    controller3.yp_tabItemTitle = self.titleArray[3];
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller0,controller1, controller2, controller3, nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
