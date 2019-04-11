//
//  CSBaseNavigationController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseNavigationController.h"

@interface CSBaseNavigationController ()

@end

@implementation CSBaseNavigationController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgView =  [self findHairlineImageViewUnder:self.navigationBar];
    imgView.hidden = YES;
}
-(id)initWithRootViewController:(UIViewController *)rootViewController{
    
    if (self = [super initWithRootViewController:rootViewController]) {
        self.navigationBar.translucent = NO;
        self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
        self.navigationBar.barTintColor = WhiteColor;
        self.navigationBar.tintColor = MainColor;
    }
    return self;
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

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count != 0) {
        
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    [super pushViewController:viewController animated:animated];
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
