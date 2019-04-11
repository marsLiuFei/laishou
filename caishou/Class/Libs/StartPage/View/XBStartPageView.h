//
//  XBStartPageView.h
//  ShoppingMall
//
//  Created by ahxb on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

//启动图种类
typedef NS_ENUM(NSInteger, XBLaunchAnimateSpeciesType){
    XBLaunchAnimateImage = 0,
    XBLaunchAnimateMovie
};

typedef void(^CompleteBlock)(void);

@interface XBStartPageView : UIView

/** 广告倒计时完了的回调block **/
@property (nonatomic, copy) CompleteBlock complete;
#pragma mark --- contentURL：播放地址  animateSpeciesType：播放类型 showSkipButton：是否需要跳过按钮
- (instancetype)initWithContentURL:(NSString *)contentURL animateSpeciesType:(XBLaunchAnimateSpeciesType)animateSpeciesType showSkipButton:(BOOL)showSkipButton downSeconds:(CGFloat )downSeconds;

- (void)show;

- (void)stop;
@end
