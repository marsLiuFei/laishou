//
//  XBStartPageView.m
//  ShoppingMall
//
//  Created by ahxb on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBStartPageView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "XBStartPageViewController.h"
#import "UIImage+GIF.h"

@interface XBStartPageView()

@property(nonatomic ,strong) XBStartPageViewController *launchCtrl;
@property (nonatomic,strong) AVPlayer *player;//视频播放
@end


@implementation XBStartPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithContentURL:(NSString *)contentURL animateSpeciesType:(XBLaunchAnimateSpeciesType)animateSpeciesType showSkipButton:(BOOL)showSkipButton  downSeconds:(CGFloat )downSeconds{
    self = [self init];
    ws(bself);
    if (self) {
        if (animateSpeciesType == XBLaunchAnimateImage) {//广告图片
            UIView *launchView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            launchView.backgroundColor = [UIColor whiteColor];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
            if ([contentURL hasPrefix:@"http"]) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:contentURL]];
            }else{
                imageView.image = [UIImage imageNamed:contentURL];
            }
            
            imageView.center = launchView.center;
            [launchView addSubview:imageView];
            
            _launchCtrl = [[XBStartPageViewController alloc]initWithContentView:launchView animateType:XBLaunchAnimateTypeFade showSkipButton:showSkipButton];
            _launchCtrl.complete = ^{
                if (bself.complete) {
                    bself.complete();
                }
            };
            
             _launchCtrl.animateDuration = downSeconds;
//            [_launchCtrl show];
            
        }else if (animateSpeciesType == XBLaunchAnimateMovie){//广告视频
            
            UIView *launchView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            launchView.backgroundColor = [UIColor whiteColor];
            AVPlayerItem * item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:contentURL]];
            self.player = [AVPlayer playerWithPlayerItem:item];
            AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
            playerLayer.frame = launchView.frame;
            [launchView.layer addSublayer:playerLayer];
            [self.player play];
            _launchCtrl = [[XBStartPageViewController alloc]initWithContentView:launchView animateType:XBLaunchAnimateTypeFade showSkipButton:showSkipButton];
            _launchCtrl.complete = ^{
                if (bself.complete) {
                    bself.complete();
                }
            };
            _launchCtrl.animateDuration = downSeconds;
//            [_launchCtrl show];

        }
    }
    return self;
}

- (void)show{
    [_launchCtrl show];
}

- (void)stop{
    [self.player pause];
    self.player = nil;
}

@end
