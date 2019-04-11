//
//  CSRegisterViewController.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/2.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSRegisterViewController.h"

@interface CSRegisterViewController ()
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic,assign)int timeCount;

@property(nonatomic, strong)UITextField *phoneTf;
@property(nonatomic, strong)UITextField *codeTf;
@property(nonatomic, strong)UITextField *psdTf;
//验证码按钮
@property(nonatomic, strong)UIButton *msgCodeBtn;
@end

@implementation CSRegisterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_timer setFireDate:[NSDate distantPast]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer setFireDate:[NSDate distantFuture]];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitleStr:@""];
    self.view.backgroundColor = WhiteColor;
    [self creatUI];
}


- (void )creatUI{
    UILabel *la = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"注册" textColor:MainColor textAlignment:Center font:MediumFont(34)];
    [self.view addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(SIZE(100));
    }];
    
    UIImageView *mobileIcon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"login_phone"];
    [self.view addSubview:mobileIcon];
    [mobileIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(la.mas_bottom).offset(SIZE(60));
        make.left.offset(SIZE(35));
        make.width.height.offset(SIZE(25));
        
    }];
    
    self.phoneTf = [ViewCreate createTextFieldFrame:CGRectMake(0, 0, 0, 0) font:RegularFont(16) textColor:RGB44 placeHolder:@"请输入您的手机号" delegate:nil];
    self.phoneTf.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.phoneTf];
    [self.phoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mobileIcon.mas_right).offset(0);
        make.right.offset(-SIZE(35));
        make.bottom.mas_equalTo(mobileIcon.mas_bottom).offset(0);
        make.height.offset(SIZE(25));
    }];
    
    UIView *line0 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:MainColor];
    [self.view addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mobileIcon.mas_left).offset(0);
        make.height.offset(SIZE(1));
        make.right.mas_equalTo(self.phoneTf.mas_right).offset(0);
        make.top.mas_equalTo(mobileIcon.mas_bottom).offset(SIZE(3));
    }];
    
    UIImageView *codeIcon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"login_psd"];
    [self.view addSubview:codeIcon];
    [codeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line0.mas_bottom).offset(SIZE(30));
        make.left.offset(SIZE(35));
        make.width.height.offset(SIZE(25));
        
    }];
    
    self.msgCodeBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"获取验证码" titleColor:MainColor font:RegularFont(15) backgroundColor:ClearColor touchUpInsideEvent:nil];
    self.msgCodeBtn.tag = 10086;
    [self.msgCodeBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.msgCodeBtn];
    [self.msgCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(35));
        make.bottom.mas_equalTo(codeIcon.mas_bottom).offset(0);
        make.height.offset(SIZE(25));
        make.width.offset(SIZE(100));
    }];
    
    
    self.codeTf = [ViewCreate createTextFieldFrame:CGRectMake(0, 0, 0, 0) font:RegularFont(16) textColor:RGB44 placeHolder:@"请输入您的验证码" delegate:nil];
    [self.view addSubview:self.codeTf];
    [self.codeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(codeIcon.mas_right).offset(0);
        make.right.mas_equalTo(self.msgCodeBtn.mas_left).offset(0);
        make.bottom.mas_equalTo(codeIcon.mas_bottom).offset(0);
        make.height.offset(SIZE(25));
    }];
    
    UIView *line1 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:MainColor];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mobileIcon.mas_left).offset(0);
        make.height.offset(SIZE(1));
        make.right.mas_equalTo(self.msgCodeBtn.mas_right).offset(0);
        make.top.mas_equalTo(codeIcon.mas_bottom).offset(SIZE(2));
    }];
    
    
    
    UIImageView *psdIcon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"login_pwd"];
    [self.view addSubview:psdIcon];
    [psdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(SIZE(30));
        make.left.offset(SIZE(35));
        make.width.height.offset(SIZE(25));
        
    }];
    
    self.psdTf = [ViewCreate createTextFieldFrame:CGRectMake(0, 0, 0, 0) font:RegularFont(16) textColor:RGB44 placeHolder:@"请输入密码" delegate:nil];
    self.psdTf.secureTextEntry = YES;
    [self.view addSubview:self.psdTf];
    [self.psdTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(psdIcon.mas_right).offset(0);
        make.right.offset(-SIZE(35));
        make.bottom.mas_equalTo(psdIcon.mas_bottom).offset(0);
        make.height.offset(SIZE(25));
    }];
    
    UIView *line2 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:MainColor];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mobileIcon.mas_left).offset(0);
        make.height.offset(SIZE(1));
        make.right.mas_equalTo(self.psdTf.mas_right).offset(0);
        make.top.mas_equalTo(psdIcon.mas_bottom).offset(SIZE(2));
    }];
    
    
    
    
    UIButton *loginBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"注册" titleColor:WhiteColor font:MediumFont(14) backgroundColor:MainColor touchUpInsideEvent:nil];
    loginBtn.tag = 10010;
    [loginBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = SIZE(6);
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(SIZE(286));
        make.height.offset(SIZE(44));
        make.centerX.offset(0);
        make.top.mas_equalTo(line2.mas_bottom).offset(SIZE(60));
    }];
    
    
    UIButton *registerBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"登录" titleColor:MainColor font:MediumFont(14) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    registerBtn.tag = 10011;
    [registerBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(SIZE(286));
        make.height.offset(SIZE(44));
        make.centerX.offset(0);
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(SIZE(10));
    }];
}


- (void )clickBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 10010:
            //注册
            [self registerMobile];
            break;
        case 10011:
            //登录
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 10086:
            //点击获取验证码
            [self getMsgCode];
            break;
            
        default:
            break;
    }
}


#pragma mark -- 注册按钮被点击
- (void )registerMobile{
    ws(bself);
    if (isEmptyStr(self.phoneTf.text)) {
        [Dialog toastCenter:@"请输入手机号"];
        return;
    }
    if (self.phoneTf.text.length!=11) {
        [Dialog toastCenter:@"请输入正确的手机号"];
        return;
    }
    if (isEmptyStr(self.codeTf.text)) {
        [Dialog toastCenter:@"请输入验证码"];
        return;
    }
    if (isEmptyStr(self.psdTf.text)) {
        [Dialog toastCenter:@"请输入验密码"];
        return;
    }
    NSDictionary *paramDic = @{
                               @"userName":isEmptyStr(self.phoneTf.text)?@"":self.phoneTf.text,
                               @"password":isEmptyStr(self.psdTf.text)?@"":[self.psdTf.text md5],
                               @"authCode":isEmptyStr(self.codeTf.text)?@"":self.codeTf.text
                               };
    [CSApiManager userRegisterWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        MYLog(@"%@",data);
        if (ResultIsCorrect) {
            [Dialog toastCenter:@"恭喜您,注册成功!"];
            [bself.navigationController popViewControllerAnimated:YES];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}








#pragma mark -- 点击获取验证码接口
- (void )getMsgCode{
    ws(bself);
    if (isEmptyStr(self.phoneTf.text)) {
        [Dialog toastCenter:@"请输入手机号"];
        return;
    }
    if (self.phoneTf.text.length!=11) {
        [Dialog toastCenter:@"请输入正确的手机号"];
        return;
    }
    NSDictionary *paramDic = @{
                               @"userName":isEmptyStr(self.phoneTf.text)?@"":self.phoneTf.text,
                            };
    
    [CSApiManager getMsgCodeWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        MYLog(@"%@",data);
        if (ResultIsCorrect) {
            //验证码发送成功
            [Dialog toastCenter:@"验证码已发送"];
            bself.timer;
        }else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}


-(NSTimer *)timer
{
    _timeCount = 60;
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
        //将定时器添加到runloop中
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
-(void)timeDown{
    
    
    self.msgCodeBtn.userInteractionEnabled = NO;
    NSString *string = [NSString stringWithFormat:@"%ds",_timeCount];
    [self.msgCodeBtn setTitle:string forState:UIControlStateNormal];
    
    _timeCount-- ;
    if (_timeCount < 0) {
        [_timer invalidate];
        _timer = nil;
        
        self.msgCodeBtn.userInteractionEnabled = YES;
        [self.msgCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
}








@end

