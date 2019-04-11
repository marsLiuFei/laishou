//
//  XBStartPageViewController.h
//  ShoppingMall
//
//  Created by ahxb on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBStartPageView.h"
//消失状态
typedef NS_ENUM(NSInteger, XBLaunchAnimateType){
    XBLaunchAnimateTypeNone = 0,
    XBLaunchAnimateTypeFade,
    XBLaunchAnimateTypeFadeAndZoomIn,
    XBLaunchAnimateTypePointZoomIn1,
    XBLaunchAnimateTypePointZoomIn2,
    XBLaunchAnimateTypePointZoomOut1,
    XBLaunchAnimateTypePointZoomOut2
};



typedef void(^CompleteBlock)(void);

@interface XBStartPageViewController : UIViewController
@property (nonatomic, strong) XBStartPageView *contentView;
@property (nonatomic, assign) XBLaunchAnimateType animateType;
@property (nonatomic, assign) CGFloat animateDuration;
@property (nonatomic, assign) CGFloat waitDuration;
@property (nonatomic, copy) CompleteBlock complete;
@property (nonatomic, assign) BOOL showSkipButton;



- (instancetype)initWithContentView:(UIView *)contentView animateType:(XBLaunchAnimateType)animateType showSkipButton:(BOOL)showSkipButton;

- (void)show;
- (void)dismissAtOnce;
@end
