//
//  XBStartPageViewController.m
//  ShoppingMall
//
//  Created by ahxb on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBStartPageViewController.h"
#import <MediaPlayer/MediaPlayer.h>


@interface XBSkipButton : UIButton

@property (nonatomic, assign) NSInteger remainSec;
@property (nonatomic, strong) UILabel *remainSecLabel;

@end

@implementation XBSkipButton

- (UILabel *)remainSecLabel{
    if (!_remainSecLabel) {
        _remainSecLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, 13)];
        _remainSecLabel.textAlignment = NSTextAlignmentCenter;
        _remainSecLabel.font = [UIFont systemFontOfSize:12];
        _remainSecLabel.text = @"0 s";
    }
    return _remainSecLabel;
}

- (void)setRemainSec:(NSInteger)remainSec{
    _remainSec = remainSec;
    self.remainSecLabel.text = [NSString stringWithFormat:@"%@ s",@(remainSec)];
}

- (instancetype)init{
    CGRect skipButtonBounds = CGRectMake(0, 0, 40, 40);
    self = [super initWithFrame:skipButtonBounds];
    if (self) {
        [self setTitle:@"跳过" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = skipButtonBounds.size.height/2;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 2;
        [self addSubview:self.remainSecLabel];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height/2-13, contentRect.size.width, 13);
}

@end

static const CGFloat kDefaultAnimateDuration = 0.8;
static const CGFloat kDefaultWaitDuration = 3.f;


@interface XBStartPageViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) XBSkipButton *skipButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat timePass;
@property (nonatomic, strong) MPMoviePlayerController * moviePlayer;

@end

@implementation XBStartPageViewController

#pragma mark - lazy load
- (XBSkipButton *)skipButton{
    if (!_skipButton) {
        _skipButton = [[XBSkipButton alloc]init];
        CGRect skipButtonFrame = _skipButton.bounds;
        skipButtonFrame.origin.x = self.view.frame.size.width - _skipButton.frame.size.width - 20;
        skipButtonFrame.origin.y = 40;
        self.skipButton.frame = skipButtonFrame;
    }
    return _skipButton;
}



-(void)setAnimateDuration:(CGFloat)animateDuration{
    _animateDuration = animateDuration;
    _waitDuration = _animateDuration;
}



#pragma mark - init method
- (instancetype)init{
    self = [super init];
    if (self) {
        _animateDuration = kDefaultAnimateDuration;
        _waitDuration = kDefaultWaitDuration;
    }
    return self;
}

- (instancetype)initWithContentView:(UIView *)contentView animateType:(XBLaunchAnimateType)animateType showSkipButton:(BOOL)showSkipButton{
    self = [self init];
    if (self) {
        _contentView = (XBStartPageView *)contentView;
        _animateType = animateType;
        _showSkipButton = showSkipButton;
    }
    return self;
}

#pragma mark - life XBcle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureSubViews];
}

- (void)viewDidAppear:(BOOL)animated{
    [self configureTimer];
}

- (void)configureSubViews{
    NSAssert(_contentView, @"contentView must not be nil!");
    
    self.view.backgroundColor = [UIColor clearColor];
    _contentView.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:_contentView];
    
//    [self.view addSubview:_moviePlayer];
    
    if(self.showSkipButton){
        self.skipButton.remainSec = _waitDuration;
        [self.view addSubview:self.skipButton];
        [self.skipButton addTarget:self action:@selector(dismissAtOnce) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark --- 定时器
- (void)configureTimer{
    self.timePass = 0.0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
    [timer fire];
}

#pragma mark - control method
- (void)countDown{
    
    _timePass+=0.1;
    _skipButton.remainSec = _waitDuration-_timePass<0?0:_waitDuration-_timePass;
    if(_waitDuration<=_timePass){
        [self.timer invalidate];
        self.timer = nil;
//        [self dismiss];
        [self dismissAtOnce];
    }
}

#pragma mark - The end of the animation
- (void)dismiss{
    
    switch (self.animateType){
        case XBLaunchAnimateTypeFade:{
            CABasicAnimation *animation = [CABasicAnimation animation];
            animation.delegate = self;
            [animation setDuration:1];
            animation.keyPath = @"opacity";
            animation.toValue = @(0);
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [self.view.layer addAnimation:animation forKey:nil];
            break;
        }
        case XBLaunchAnimateTypeFadeAndZoomIn:{
            CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
            groupAnimation.delegate = self;
            [groupAnimation setDuration:1];
            
            CABasicAnimation *fadeAnimation = [CABasicAnimation animation];
            fadeAnimation.keyPath = @"opacity";
            fadeAnimation.toValue = @(0);
            
            CABasicAnimation *zoomInAnimation = [CABasicAnimation animation];
            zoomInAnimation.keyPath = @"transform.scale";
            zoomInAnimation.toValue = @(2.0);
            
            groupAnimation.animations = @[fadeAnimation,zoomInAnimation];
            
            groupAnimation.removedOnCompletion = NO;
            groupAnimation.fillMode = kCAFillModeForwards;
            
            [self.view.layer addAnimation:groupAnimation forKey:nil];
            break;
        }
        case XBLaunchAnimateTypePointZoomOut1:{
            
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            self.view.layer.mask = maskLayer;
            
            CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
            [maskLayerAnimation setDuration:1];
            maskLayerAnimation.delegate = self;
            
            UIBezierPath *beginPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *beginCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:1 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [beginPath appendPath:beginCirclePath];
            maskLayerAnimation.fromValue = (__bridge id)(beginPath.CGPath);
            
            UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *endCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:hypot(screenSize.height, screenSize.width)/2 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [endPath appendPath:endCirclePath];
            maskLayerAnimation.toValue = (__bridge id)((endPath.CGPath));
            
            maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            maskLayerAnimation.removedOnCompletion = NO;
            maskLayerAnimation.fillMode = kCAFillModeForwards;
            
            [maskLayer addAnimation:maskLayerAnimation forKey:nil];
            
            break;
        }
        case XBLaunchAnimateTypePointZoomOut2:{
            
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            self.view.layer.mask = maskLayer;
            
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            
            CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
            [keyFrameAnimation setDuration:1];
            keyFrameAnimation.delegate = self;
            
            UIBezierPath *pathOne = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *pathOneCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:1.0 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [pathOne appendPath:pathOneCircle];
            
            UIBezierPath *pathTwo = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *pathTwoCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:screenSize.width/2*0.7 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [pathTwo appendPath:pathTwoCircle];
            
            UIBezierPath *pathThree = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *pathThreeCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:screenSize.width/2*0.5 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [pathThree appendPath:pathThreeCircle];
            
            UIBezierPath *pathFour = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *pathFourCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:hypot(screenSize.height, screenSize.width)/2 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [pathFour appendPath:pathFourCircle];
            
            keyFrameAnimation.values = @[(__bridge id)(pathOne.CGPath),(__bridge id)(pathTwo.CGPath),(__bridge id)(pathThree.CGPath),(__bridge id)(pathFour.CGPath)];
            keyFrameAnimation.keyTimes = @[@(0),@(0.3),@(0.6),@(1)];
            
            keyFrameAnimation.removedOnCompletion = NO;
            keyFrameAnimation.fillMode = kCAFillModeForwards;
            
            [maskLayer addAnimation:keyFrameAnimation forKey:nil];
            
            break;
        }
        case XBLaunchAnimateTypePointZoomIn1:{
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            self.view.layer.mask = maskLayer;
            
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            
            CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
            [keyFrameAnimation setDuration:1];
            keyFrameAnimation.delegate = self;
            
            UIBezierPath *pathOne = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:hypot(screenSize.height, screenSize.width)/2 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            UIBezierPath *pathTwo = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:screenSize.width/2*0.5 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            UIBezierPath *pathThree = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:screenSize.width/2*0.7 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            UIBezierPath *pathFour = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:1 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            keyFrameAnimation.values = @[(__bridge id)(pathOne.CGPath),(__bridge id)(pathTwo.CGPath),(__bridge id)(pathThree.CGPath),(__bridge id)(pathFour.CGPath)];
            keyFrameAnimation.keyTimes = @[@(0),@(0.5),@(0.9),@(1)];
            
            keyFrameAnimation.removedOnCompletion = NO;
            keyFrameAnimation.fillMode = kCAFillModeForwards;
            
            [maskLayer addAnimation:keyFrameAnimation forKey:nil];
            
            break;
        }
        case XBLaunchAnimateTypePointZoomIn2:{
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            self.view.layer.mask = maskLayer;
            
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            
            CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
            [maskLayerAnimation setDuration:1];
            maskLayerAnimation.delegate = self;
            
            UIBezierPath *beginPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:hypot(screenSize.height, screenSize.width)/2 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:1 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            maskLayerAnimation.fromValue = (__bridge id)(beginPath.CGPath);
            maskLayerAnimation.toValue = (__bridge id)(endPath.CGPath);
            
            maskLayerAnimation.removedOnCompletion = NO;
            maskLayerAnimation.fillMode = kCAFillModeForwards;
            
            [maskLayer addAnimation:maskLayerAnimation forKey:nil];
            
            break;
        }
        default:
            break;
    }
   
}

- (void)dismissAtOnce{
    
    
    
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"测试1" message:@"有新版本更新！" preferredStyle:UIAlertControllerStyleAlert];
//    //UIAlertControllerStyleAlert在中央屏幕。
//    //UIAlertControllerStyleActionSheet在屏幕底部。
//    UIAlertAction *useCamera = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleDefault handler:nil];
//    UIAlertAction *desAction = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    [alertController addAction:useCamera];
//    [alertController addAction:desAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
    
    
    [self.view removeFromSuperview];
    [self.timer invalidate];
    self.timer = nil;
    if (self.complete) {
        self.complete();
    }
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSAssert(window,@"keyWindow must be init!");
    [window addSubview:self.view];
}

#pragma mark - delegate method
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self dismissAtOnce];
}

@end
