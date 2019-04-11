//
//  CSBaseTabbarController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseTabbarController.h"
#import "CSBaseNavigationController.h"
#import "CSLoginViewController.h"
#import "UIViewController+Nav.h"

@interface CSBaseTabbarController ()<UITabBarControllerDelegate>

@end

@implementation CSBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setSubController];
}

- (void)setSubController{
    
    NSArray *VCNameArr = @[@"CSBaseMainViewController",@"CSBaseCircleViewController",@"CSBaseFitViewController",@"CSBaseMineViewController"];
    NSMutableArray *VCNavArr = [NSMutableArray array];
    CSBaseNavigationController *VCNav = nil;
    for (NSString *VCName in VCNameArr) {
        UIViewController *VC = [[NSClassFromString(VCName) alloc] init];
        VC.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:nil];
        VCNav = [[CSBaseNavigationController alloc] initWithRootViewController:VC];
        [VCNavArr addObject:VCNav];
        
        
    }
    
    [self setViewControllers:VCNavArr];
    
    
    NSArray *tabBarTitleArr  = @[@"首页",@"莱瘦圈",@"莱购",@"我的"];
    NSArray *tabBarImgArr = @[@"main",@"circle",@"popular",@"mine"];
    NSArray *tabBarItems = self.tabBar.items;
    
    for (int i = 0; i < tabBarItems.count; i++) {
        UITabBarItem *item = tabBarItems[i];
        item.title = tabBarTitleArr[i];
        item.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",tabBarImgArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_unselected",tabBarImgArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:MainColor,NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
        
    }
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSLog(@"%@" , item);

}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
        if (!ISLOGIN) {
            CSLoginViewController *vc = [CSLoginViewController new];
            CSBaseNavigationController *navi = [[CSBaseNavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:navi animated:YES completion:nil];
            return NO;
        }
        return YES;
    }
    return YES;
}

@end
