//
//  CSLoginViewController.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/1.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSLoginViewController.h"
#import "CSRegisterViewController.h"
#import "CSForgetPsdViewController.h"

@interface CSLoginViewController ()
@property(nonatomic, strong)UITextField *phoneTf;
@property(nonatomic, strong)UITextField *psdTf;
@end

@implementation CSLoginViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavWithTitle:@"" isShowBack:YES];
    self.view.backgroundColor = WhiteColor;
    [self creatUI];
}


- (void )creatUI{
    UILabel *la = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"登录" textColor:MainColor textAlignment:Center font:MediumFont(34)];
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
    
    UIImageView *psdIcon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"login_psd"];
    [self.view addSubview:psdIcon];
    [psdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line0.mas_bottom).offset(SIZE(30));
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
    
    UIView *line1 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:MainColor];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mobileIcon.mas_left).offset(0);
        make.height.offset(SIZE(1));
        make.right.mas_equalTo(self.psdTf.mas_right).offset(0);
        make.top.mas_equalTo(psdIcon.mas_bottom).offset(SIZE(2));
    }];
    
    
    UIButton *forgetPsdBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"忘记密码" titleColor:RGB102 font:RegularFont(14) backgroundColor:ClearColor touchUpInsideEvent:nil];
    forgetPsdBtn.tag = 10086;
    [forgetPsdBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPsdBtn];
    [forgetPsdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(line1.mas_right).offset(0);
        make.top.mas_equalTo(line1.mas_bottom).offset(SIZE(5));
    }];
    
    
    UIButton *loginBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"登录" titleColor:WhiteColor font:MediumFont(14) backgroundColor:MainColor touchUpInsideEvent:nil];
    loginBtn.tag = 10087;
    [loginBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = SIZE(6);
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(SIZE(286));
        make.height.offset(SIZE(44));
        make.centerX.offset(0);
        make.top.mas_equalTo(forgetPsdBtn.mas_bottom).offset(SIZE(90));
    }];
    
    
    UIButton *registerBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"注册" titleColor:MainColor font:MediumFont(14) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    registerBtn.tag = 10088;
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
        case 10086:
            //忘记密码
            [self.navigationController pushViewController:[CSForgetPsdViewController new] animated:YES];
            break;
        case 10087:
            //登录
            [self login];
            break;
        case 10088:
            //注册
        {
            [self.navigationController pushViewController:[CSRegisterViewController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
}


- (void )login{
    ws(bself);
    if (isEmptyStr(self.phoneTf.text)) {
        [Dialog toastCenter:@"请输入手机号"];
        return;
    }
    if (self.phoneTf.text.length!=11) {
        [Dialog toastCenter:@"请输入正确的手机号"];
        return;
    }
    if (isEmptyStr(self.psdTf.text)) {
        [Dialog toastCenter:@"请输入密码"];
        return;
    }
    NSDictionary *paramDic = @{
                               @"userName":isEmptyStr(self.phoneTf.text)?@"":self.phoneTf.text,
                               @"password":isEmptyStr(self.psdTf.text)?@"":[self.psdTf.text md5]
                               };
    [CSApiManager userLoginWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        MYLog(@"%@",data);
        if (ResultIsCorrect) {
            [Dialog toastCenter:@"恭喜您,登录成功!"];
            NSDictionary *dic = data[@"data"];
            NSString *loginType = [NSString stringWithFormat:@"%@",dic[@"loginType"]];
            [UDefault setObject:[NSString stringWithFormat:@"%@",loginType] keys:LoginType];//存储登录者类型
            [UDefault setObject:[NSString stringWithFormat:@"%@",dic[@"token"]] keys:AuthKey];//authkey
            [NSNotic_Center postNotificationName:LOGINSUCCESS object:nil];
            if (bself.isFromPk) {
                [bself.navigationController popViewControllerAnimated:YES];
                [bself dismissViewControllerAnimated:true completion:nil];
            }else{
                [bself.navigationController popToRootViewControllerAnimated:YES];
                [bself dismissViewControllerAnimated:true completion:nil];
            }
            
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}


@end
