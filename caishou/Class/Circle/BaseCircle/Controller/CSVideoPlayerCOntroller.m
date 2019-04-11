//
//  CSVideoPlayerCOntroller.m
//  caishou
//
//  Created by 刘飞 on 2019/3/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSVideoPlayerCOntroller.h"

#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"

@interface CSVideoPlayerCOntroller()
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) UIView *playerView;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) SelVideoPlayer *newplayer;
@end

@implementation CSVideoPlayerCOntroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    
//    [self playBtnClick];
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = YES;
    configuration.supportedDoubleTap = YES;
    configuration.shouldAutorotate = YES;
    configuration.repeatPlay = YES;
    configuration.statusBarHideState = SelStatusBarHideStateFollowControls;
    configuration.sourceUrl = [NSURL URLWithString:self.videoUrl];
    configuration.videoGravity = SelVideoGravityResizeAspect;
    
    _newplayer = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16) configuration:configuration];
    [self.view addSubview:_newplayer];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_newplayer _deallocPlayer];
}












#pragma mark - 播放下载的直播
- (void)playBtnClick {
    if (self.player == nil) {
        //没有创建播放器
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.videoUrl]];
        //添加监听
        [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 9.0 / 16.0);
        self.playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.playerLayer.frame), CGRectGetHeight(self.playerLayer.frame))];
        self.playerView.backgroundColor = [UIColor whiteColor];
        [self.playerView.layer addSublayer:self.playerLayer];
        [self.view addSubview:self.playerView];
    } else {
        //已经创建过播放器
        NSLog(@"已经创建过播放器，继续播放");
    }
}
#pragma mark - 监听回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        
    }else if ([keyPath isEqualToString:@"status"]){
        //获取播放状态
        if (playerItem.status == AVPlayerItemStatusReadyToPlay){
            [self.player play];
            NSLog(@"开始播放");
        } else{
            NSLog(@"播放失败%@", playerItem.error);
        }
    }
    
}
-(void)dealloc{
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    self.player = nil;
}



@end
