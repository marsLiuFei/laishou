//
//  CSconvertSuccessViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/3/1.
//  Copyright © 2019年 mars. All rights reserved.
//  兑换成功页面

#import "CSconvertSuccessViewController.h"
#import "CSOrderViewController.h"

@interface CSconvertSuccessViewController ()

@end

@implementation CSconvertSuccessViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitleStr:@"兑换成功"];
    self.view.backgroundColor = COMMON_BACK_COLOR;
    [self creatUI];
}



- (void )creatUI{
    UILabel *la = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"恭喜您，兑换成功！" textColor:MainColor textAlignment:Center font:MediumFont(19)];
    [self.view addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(SIZE(50));
    }];
    
    
    UIImageView *icon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"buySuccess"];
    [self.view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(la.mas_bottom).offset(SIZE(20));
    }];
    
    
    UILabel *la1 = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"订单已交至后台处理" textColor:RGB102 textAlignment:Center font:RegularFont(14)];
    [self.view addSubview:la1];
    [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(icon.mas_bottom).offset(SIZE(20));
    }];
    
    
    UIButton *checkOrderBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"查看订单" titleColor:WhiteColor font:MediumFont(16) backgroundColor:MainColor touchUpInsideEvent:nil];
    checkOrderBtn.tag = 200;
    [checkOrderBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    checkOrderBtn.layer.masksToBounds = YES;
    checkOrderBtn.layer.cornerRadius = SIZE(20);
    [self.view addSubview:checkOrderBtn];
    [checkOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(la1.mas_bottom).offset(SIZE(50));
        make.width.offset(SIZE(250));
        make.height.offset(SIZE(40));
    }];
    
    
    
    UIButton *backBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"立即拿货" titleColor:MainColor font:MediumFont(16) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    backBtn.layer.masksToBounds = YES;
    backBtn.layer.cornerRadius = SIZE(20);;
    [self.view addSubview:backBtn];
    backBtn.tag = 201;
    [backBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(checkOrderBtn.mas_bottom).offset(SIZE(20));
        make.width.offset(SIZE(250));
        make.height.offset(SIZE(40));
    }];
}


- (void )btnClick:(UIButton *)sender{
    if (sender.tag == 200) {
        //查看订单
         [self.navigationController pushViewController:[CSOrderViewController new] animated:YES];;
    }else{
        //立即拿货没有，直接回根视图
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
   
}



@end
