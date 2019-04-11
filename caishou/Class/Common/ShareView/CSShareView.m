//
//  CSShareView.m
//  caishou
//
//  Created by 刘飞 on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSShareView.h"


#define LFTuanNumViewHight 140.0
#define UI_View_Width  [UIScreen mainScreen].bounds.size.width
#define UI_View_Height [UIScreen mainScreen].bounds.size.height

@interface CSShareView()
{
    UIView *_contentView;
    
}
@end

@implementation CSShareView

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
    
    if (_contentView == nil) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, UI_View_Height, UI_View_Width, LFTuanNumViewHight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
//        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
//        CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
//        maskLayer.frame = _contentView.bounds;
//        maskLayer.path = maskPath.CGPath;
//        _contentView.layer.mask = maskLayer;
        
        UIView *topBg = [ViewCreate createLineFrame:CGRectMake(0, 0, UI_View_Width, 95) backgroundColor:COMMON_BACK_COLOR];
        [_contentView addSubview:topBg];
        
        
        CGFloat width = (SCREEN_WIDTH-SIZE(30))/4.f;
        NSArray *icons  = @[@"frends_icon",@"wechat_icon",@"QQ",@"QQZone_icon"/*,@"sina_icon"*/];
        NSArray *titles = @[@"微信朋友圈",@"微信好友",@"QQ",@"QQ空间"/*,@"微博"*/];
        for (int i=0; i<icons.count; i++) {
            CostomButton *btn = [[CostomButton alloc] initWithFrame:CGRectMake(i * width+15, 15, width, 70)];
            btn.imageName = icons[i];
            btn.textLable = titles[i];
            [btn setTitleColor:RGB102 forState:UIControlStateNormal];
            [topBg addSubview:btn];
            
            btn.tag = i+100;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 95, UI_View_Width, 45)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:cancelBtn];
    }
}
-(void)cancelAction{
    
    [self disMissView];
    
}

- (void )clickBtn:(UIButton *)sender{
    if (self.clickBtnBlock) {
        self.clickBtnBlock(sender.tag-100);
    }
    [self disMissView];
}








//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    [view addSubview:self];
    [view addSubview:_contentView];
    
    
    _contentView.alpha=0;
    
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        self->_contentView.alpha = 1;
        [self->_contentView setFrame:CGRectMake(0, UI_View_Height - LFTuanNumViewHight, UI_View_Width, LFTuanNumViewHight)];
        
    } completion:nil];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView {
    _contentView.alpha = 1;
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0.0;
                         [self->_contentView setFrame:CGRectMake(0, UI_View_Height , UI_View_Width, 0)];
                         self->_contentView.alpha=0.0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [self->_contentView removeFromSuperview];
                         
                     }];
    
}

@end
