//
//  CSShareAlertView.m
//  caishou
//
//  Created by 刘飞 on 2019/4/10.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSShareAlertView.h"
#import "LLUtils.h"

#define LFTuanNumViewHight 350.0
#define UI_View_Width  [UIScreen mainScreen].bounds.size.width
#define UI_View_Height [UIScreen mainScreen].bounds.size.height

@interface CSShareAlertView()
{
    UIImageView *_contentView;
    UIImageView *codeImageView;//要展示的二维码图片
}
@end

@implementation CSShareAlertView

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupContent];
    }
    return self;
}

- (void)setupContent {
    self.frame = CGRectMake(0, 0, UI_View_Width,UI_View_Height);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];//点击空白地方移除视图
    
    if (_contentView == nil){
        _contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        _contentView.clipsToBounds = YES;
        _contentView.contentMode = UIViewContentModeScaleAspectFill;
        _contentView.image = [UIImage imageNamed:@"shareBg"];
        _contentView.userInteractionEnabled = YES;
        [_contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];//点击空白地方移除视图
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        
        codeImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
        [_contentView addSubview:codeImageView];
        [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(-SIZE(100));
            make.width.height.offset(SIZE(100));
        }];
    }
}

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view shareUrl:(NSString *)shareUrl {
    if (!view) {
        return;
    }
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    _contentView.alpha=0;
    _contentView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    
    codeImageView.image = [LLUtils qrImageForString:shareUrl imageSize:200 logoImageSize:0];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        self->_contentView.alpha = 1;
        self->_contentView.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:nil];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView {
    [_contentView setFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    _contentView.transform = CGAffineTransformMakeScale(1, 1);
    _contentView.alpha = 1;
    //    self.alpha=1.0;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0.0;
                         [self->_contentView setFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
                         self->_contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         self->_contentView.alpha=0.0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [self->_contentView removeFromSuperview];
                         
                     }];
    
}
@end
