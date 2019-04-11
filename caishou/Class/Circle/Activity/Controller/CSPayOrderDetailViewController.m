//
//  CSPayOrderDetailViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/3/15.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSPayOrderDetailViewController.h"
#import "CSPaySuccessViewController.h"

#import "CSChoosePayModeModel.h"

#import "CSPayDetailInfoCell.h"
#import "CSChoosePayModeView.h"

@interface CSPayOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UILabel *priceLabel;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UITableView *tableView;
/**
 *
 **/
@property(nonatomic, strong)NSArray *payModes;
/**
 *当前支付方式
 **/
@property(nonatomic, strong)NSString *nowPayMode;
@end

@implementation CSPayOrderDetailViewController
-(NSArray *)payModes{
    if (!_payModes) {
        NSArray *arr = @[/*@"微信支付",*/@"支付宝支付"];
        NSArray *arr0 = @[/*@"wechat_pay",*/@"alipay_icon"];
        NSArray *arr1 = @[/*@"微信安全支付",*/@"线上支付宝支付"];
        NSMutableArray *arrM = [NSMutableArray new];
        for (int i=0; i<arr.count; i++) {
            CSChoosePayModeModel *model = [CSChoosePayModeModel new];
            model.name = arr[i];
            model.iconName = arr0[i];
            model.des = arr1[i];
            if (i==0) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
            [arrM addObject:model];
        }
        _payModes = arrM;
    }
    return _payModes;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitleStr:@""];
//    self.nowPayMode = @"微信支付";
    self.nowPayMode = @"支付宝支付";
    [self creatBottomView];
    [self initTableView];
    [self listenNotification];
}


#pragma mark -- 处理回调
- (void )listenNotification{
    [NSNotic_Center addObserver:self selector:@selector(weixin:) name:WXPAY object:nil];
    [NSNotic_Center addObserver:self selector:@selector(aliPayBack:) name:ALIPAY object:nil];
}


#pragma mark -- 阿里支付
- (void )aliPayWithOrder:(NSString *)order{
    ws(bself);
    [[AlipaySDK defaultService] payOrder:order fromScheme:@"LaiShouApp" callback:^(NSDictionary *resultDic) {
        NSInteger orderState=[resultDic[@"resultStatus"] integerValue];
        if (orderState==9000) {
            [bself paySuccess];
        }else{
            NSString *returnStr;
            switch (orderState) {
                    case 8000:
                    returnStr=@"订单正在处理中";
                    break;
                    case 4000:
                    returnStr=@"订单支付失败";
                    break;
                    case 6001:
                    returnStr=@"已取消支付!";
                    break;
                    case 6002:
                    returnStr=@"网络连接出错";
                    break;
                default:
                    break;
            }
            [Dialog toastCenter:returnStr];
        }
    }];
}
//阿里支付杀死app回调
- (void)aliPayBack:(NSNotification *)notify{
    NSDictionary *resultDic = notify.userInfo;
    NSDictionary * userInfo = resultDic[@"resultDic"];
    NSInteger orderState=[userInfo[@"resultStatus"] integerValue];
    if (orderState==9000) {
        [self paySuccess];
    }else{
        NSString *returnStr;
        switch (orderState) {
                case 8000:
                returnStr=@"订单正在处理中";
                break;
                case 4000:
                returnStr=@"订单支付失败";
                break;
                case 6001:
                returnStr=@"已取消支付!";
                break;
                case 6002:
                returnStr=@"网络连接出错";
                break;
            default:
                break;
        }
        [Dialog toastCenter:returnStr];
    }
}

#pragma mark -- 微信支付
- (void )wxpayWithOrder:(NSDictionary *)dict{
    //    {
    //        appid = wx976d46f7fcb104aa;
    //        package = "Sign=WXPay";
    //        partnerid = 1511399011;
    //        prepayid = wx161809253091950268bc8c142600668895;
    //        sign = 1380B3E3F2F2255B98A037190C971208512F4F3582932B881E4223D7F1C7573C;
    //        timestamp = 1534414166;
    //    }
    if ([dict isKindOfClass:[NSNull class]]) {
        [Dialog toastCenter:@"支付参数错误，请联系管理员"];
        return;
    }
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayid"];
    req.package             = [dict objectForKey:@"package"];
    req.nonceStr            = [dict objectForKey:@"noncestr"];
    req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
    req.sign                = [dict objectForKey:@"sign"];
    [WXApi sendReq:req];
}

- (void)weixin:(NSNotification *)notify{
    NSDictionary * userInfo = notify.userInfo;
    if ([userInfo[@"status"] isEqualToString:@"恭喜您,支付成功!"]) {
        [self paySuccess];
    }
    if ([userInfo[@"status"] isEqualToString:@"已取消支付!"]) {
        [Dialog toastCenter:@"已取消支付!"];
    }
    if ([userInfo[@"status"] isEqualToString:@"支付失败!"]) {
        [Dialog toastCenter:@"已取消支付!"];
    }
}






//支付成功回调，需要通知后台支付成功
- (void )paySuccess{
     if (self.isNeedPay) {
         //订单列表页支付成功后发送通知活动订单列表刷新
         [NSNotic_Center postNotificationName:OrderPaySuccess object:nil];
     }
    CSPaySuccessViewController *vc = [CSPaySuccessViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -- 底部付费按钮
//普通管理状态下会有审核按钮，驾驶员无按钮
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
        
        self.priceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:[NSString stringWithFormat:@"¥%@元",isEmptyStr(self.activityDetailModel.price)?@"":self.activityDetailModel.price] textColor:MainColor textAlignment:Left font:MediumFont(SIZE(18))];
        [_bottomView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(SIZE(15));
            make.top.bottom.offset(0);
            make.width.offset(SIZE(100));
        }];
        
        UIButton *unaccessBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"提交" titleColor:WhiteColor font:MediumFont(SIZE(16)) backgroundColor:MainColor touchUpInsideEvent:nil];
        [unaccessBtn addTarget:self action:@selector(submitOrderBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:unaccessBtn];
        [unaccessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.top.bottom.offset(0);
            make.width.offset(SIZE(100));
        }];
        
        
    }
    return _bottomView;
}
//点击提交按钮
- (void )submitOrderBtnClick{
    ws(bself);
    if (self.isNeedPay) {
        //付方式（1:支付宝;2:微信）
        [CSApiManager IndentPayWithParamDic:@{@"id":isEmptyStr(self.orderID)?@"":self.orderID,@"payType":[self.nowPayMode isEqualToString:@"微信支付"]?@"2":@"1"} CallBack:^(id  _Nonnull data) {
            [Dialog toastCenter:BackMessage];
            if (ResultIsCorrect) {
                if ([self.nowPayMode isEqualToString:@"微信支付"]) {
                    [bself wxpayWithOrder:data[@"data"]];
                }else{
                    [bself aliPayWithOrder:[NSString stringWithFormat:@"%@",data[@"data"]]];
                }
                
            }
        } fail:^(NSError * _Nonnull error) {
            [Dialog toastCenter:@"网络错误"];
        }];
    }else{
        //付方式（1:支付宝;2:微信）
        [CSApiManager PaySignWithParamDic:@{@"id":self.activityDetailModel.ID,@"payType":[self.nowPayMode isEqualToString:@"微信支付"]?@"2":@"1"} CallBack:^(id  _Nonnull data) {
            [Dialog toastCenter:BackMessage];
            if (ResultIsCorrect) {
                if ([self.nowPayMode isEqualToString:@"微信支付"]) {
                    [bself wxpayWithOrder:data[@"data"]];
                }else{
                    [bself aliPayWithOrder:[NSString stringWithFormat:@"%@",data[@"data"]]];
                }
                
            }
        } fail:^(NSError * _Nonnull error) {
            [Dialog toastCenter:@"网络错误"];
        }];
    }
}


- (void )creatBottomView{
    [self.view addSubview:self.bottomView];
    CGFloat bottomMargin = SafeAreaHeight;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(SIZE(50));
        make.bottom.offset(-bottomMargin);
    }];
}
#pragma mark -- 创建表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView registerClass:[CSPayDetailInfoCell class] forCellReuseIdentifier:@"CSPayDetailInfoCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(0);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE(150);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE(10);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    CSPayDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSPayDetailInfoCell"];
    cell.activityDetailModel = self.activityDetailModel;
    cell.payMode = self.nowPayMode;
    cell.choosePayModeBlock = ^{
      //选择支付按钮被点击
        CSChoosePayModeView *view = [CSChoosePayModeView new];
        view.pickerBlock = ^(NSString * _Nonnull resultStr) {
            bself.nowPayMode = resultStr;
            [bself.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        };
        [view showInView:[UIApplication sharedApplication].keyWindow sourceDataArray:bself.payModes nowShowString:bself.nowPayMode];
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
