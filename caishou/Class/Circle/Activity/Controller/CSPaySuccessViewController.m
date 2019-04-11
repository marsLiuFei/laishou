//
//  CSPaySuccessViewController.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/17.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSPaySuccessViewController.h"

@interface CSPaySuccessViewController ()

@end
@implementation CSPaySuccessViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = COMMON_BACK_COLOR;
    UIImageView *icon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"paySuccess_icon"];
    [self.view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(SIZE(45));
    }];
    
    UILabel *la0 = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"恭喜您！支付成功" textColor:RGB44 textAlignment:Center font:MediumFont(16)];
    [self.view addSubview:la0];
    [la0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(icon.mas_bottom).offset(SIZE(30));
    }];
    
    UILabel *la1 = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"记得准时参加活动哦～" textColor:RGB44 textAlignment:Center font:RegularFont(12)];
    [self.view addSubview:la1];
    [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(la1.mas_bottom).offset(SIZE(20));
    }];
    
    
}



@end
