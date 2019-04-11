//
//  LF_ShowVersionView.m
//  FullAndFresh
//
//  Created by 刘飞 on 2018/5/15.
//  Copyright © 2018年 Miles. All rights reserved.
//

#import "LF_ShowVersionView.h"

@interface  LF_ShowVersionView()<UIWebViewDelegate>
{
    UIView *bottomHLine;
    UIView *bottomVLine;
}
@property(nonatomic,strong)UIView *alterView;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIWebView *contentWebView;
@property(nonatomic,strong)UIButton *cancelBt;
@property(nonatomic,strong)UIButton *sureBt;

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *cancel;
@property(nonatomic,copy)NSString *sure;
@property (nonatomic,strong)UIView *baseView;

@end

@implementation LF_ShowVersionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        __weak typeof (self)bself = self;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        
        _baseView = [UIView new];
        [self addSubview:_baseView];
        
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.layer.masksToBounds = YES;
        _baseView.layer.cornerRadius = 10;
        
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"version_update_icon"];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.centerX.offset(0);
            make.left.mas_equalTo(self->_baseView.mas_left).offset(0);
            make.right.mas_equalTo(self->_baseView.mas_right).offset(0);
            make.centerY.equalTo(self->_baseView.mas_top);
            make.height.mas_equalTo([MyAdapter laDapter:120]);//SIZEFIT(120)
        }];
        
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = RGB(45, 45, 45);
        _titleLb.font = FONT(15);
        //        _titleLb = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(45, 45, 45) textAlignment:Center font:kFont15];
        [_baseView addSubview:_titleLb];
        
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(imageView.mas_bottom).offset(10);
            make.left.offset([MyAdapter laDapter:20]);
            make.right.offset(-[MyAdapter laDapter:20]);
        }];
        
        //内容
        
        self.contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.contentWebView.backgroundColor = [UIColor whiteColor];
        self.contentWebView.scrollView.showsVerticalScrollIndicator = NO;
        self.contentWebView.scrollView.showsHorizontalScrollIndicator = NO;
        self.contentWebView.opaque = NO;
        self.contentWebView.backgroundColor = [UIColor clearColor];
        self.contentWebView.delegate = self;
        [_baseView addSubview:self.contentWebView];
        
        
        
        bottomHLine= [[UIView alloc] init];
        bottomHLine.backgroundColor = RGB(222, 222, 222);
        //        bottomHLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(222, 222, 222)];
        [_baseView addSubview:bottomHLine];
        [bottomHLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0.6);
            make.centerX.offset(0);
            make.bottom.offset(0);
            make.height.offset([MyAdapter laDapter:40]);
        }];
        
        //        bottomVLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(222, 222, 222)];
        bottomVLine= [[UIView alloc] init];
        bottomVLine.backgroundColor = RGB(222, 222, 222);
        [_baseView addSubview:bottomVLine];
        
        [bottomVLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.offset(0.6);
            make.bottom.offset(-[MyAdapter laDapter:40]);
        }];
        
        
        
        [self.contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_titleLb.mas_bottom).offset(9);
            make.left.offset([MyAdapter laDapter:20]);
            make.right.offset(-[MyAdapter laDapter:20]);
            make.bottom.mas_equalTo(self->bottomVLine.mas_top).offset(0);
        }];
        
        
        
        //取消按钮
        
        _cancelBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBt setTitleColor:RGB(75, 75, 75) forState:UIControlStateNormal];
        _cancelBt.backgroundColor = [UIColor whiteColor];
        [_cancelBt addTarget:self action:@selector(cancelBtClick) forControlEvents:UIControlEventTouchUpInside];
        
        //        _cancelBt = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"" titleColor: RGB(75, 75, 75) font:kFont16 backgroundColor:WhiteColor touchUpInsideEvent:^(UIButton *sender) {
        //            [bself cancelBtClick];
        //        }];
        [_baseView addSubview:_cancelBt];
        [_cancelBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.offset(0);
            make.top.equalTo(self->bottomVLine.mas_bottom);
            make.right.equalTo(self->bottomHLine.mas_left);
        }];
        
        //确定按钮
        
        _sureBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBt setTitleColor:RGB(75, 75, 75) forState:UIControlStateNormal];
        _sureBt.backgroundColor = [UIColor whiteColor];
        [_sureBt addTarget:self action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
        //        _sureBt = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"" titleColor:RGB(75, 75, 75) font:kFont16 backgroundColor:WhiteColor touchUpInsideEvent:^(UIButton *sender) {
        //            [bself sureBtClick];
        //        }];
        
        [_baseView addSubview:_sureBt];
        [_sureBt mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.bottom.offset(0);
            make.top.equalTo(self->bottomVLine.mas_bottom);
            make.left.equalTo(self->bottomHLine.mas_right);
        }];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [bself.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.centerY.offset(0);
                make.left.offset([MyAdapter laDapter:70]);
                make.right.offset(-[MyAdapter laDapter:70]);
                make.height.offset([MyAdapter laDapter:250]);
            }];
            
        }];
    }
    return self;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 禁止用户复制粘贴
    [self.contentWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}



#pragma mark----实现类方法
+(instancetype)alterViewWithTitle:(NSString *)title content:(NSString *)content cancel:(NSString *)cancel sure:(NSString *)sure cancelBtClcik:(cancelBlock)cancelBlock sureBtClcik:(sureBlock)sureBlock{
    
    LF_ShowVersionView *alterView=[[LF_ShowVersionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    alterView.title=title;
    alterView.content=content;
    alterView.cancel=cancel;
    alterView.sure=sure;
    alterView.cancel_block=cancelBlock;
    alterView.sure_block=sureBlock;
    
    [[[UIApplication sharedApplication].delegate window] addSubview:alterView];
    
    return alterView;
}
#pragma mark--给属性重新赋值
-(void)setTitle:(NSString *)title
{
    _titleLb.text=title;
}
-(void)setContent:(NSString *)content
{
    [self.contentWebView loadHTMLString:content baseURL:nil];
}
-(void)setSure:(NSString *)sure
{
    [_sureBt setTitle:sure forState:UIControlStateNormal];
}
-(void)setCancel:(NSString *)cancel
{
    if (![cancel isEqualToString:@""]) {
        [_cancelBt setTitle:cancel forState:UIControlStateNormal];
    }else{
        _cancelBt.hidden = YES;
        bottomHLine.hidden = YES;
        [_sureBt mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.offset(0);
            make.top.equalTo(self->bottomVLine.mas_bottom);
            make.left.equalTo(self->_cancelBt.mas_left);
        }];
    }
    
}
#pragma mark----取消按钮点击事件
-(void)cancelBtClick
{
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
    self.cancel_block();
}
#pragma mark----确定按钮点击事件
-(void)sureBtClick
{
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
    self.sure_block();
}

@end
