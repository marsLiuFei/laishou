//
//  CSBenifitGoodsDetailViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/27.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBenifitGoodsDetailViewController.h"
#import "CSSpellSuccessViewController.h"

#import "CSSpellGoodsDetailModel.h"

#import "CSGoodsBottomView.h"
#import "CSBenifitGoodsBannerCell.h"
#import "CSGoodsDetailInfoCell.h"
#import "CSGoodsDistributionInfoCell.h"
#import "CSGoodsSpecificationsCell.h"
#import "CSGroupPurchaseCell.h"

@interface CSBenifitGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
/**
 *  底部按钮
 */
@property(nonatomic, strong)CSGoodsBottomView *bottomView;
/**
 *
 **/
@property(nonatomic, strong)CSSpellGoodsDetailModel *spellGoodsDetailModel;
/**
 *
 **/
@property(nonatomic, strong)NSString *shareInfoUrl;
@end

@implementation CSBenifitGoodsDetailViewController
-(CSSpellGoodsDetailModel *)spellGoodsDetailModel{
    if (!_spellGoodsDetailModel) {
        _spellGoodsDetailModel = [CSSpellGoodsDetailModel new];
    }
    return _spellGoodsDetailModel;
}
- (CSGoodsBottomView *)bottomView{
    if (!_bottomView) {
        ws(bself);
        _bottomView = [[CSGoodsBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-SIZE(50), SCREEN_WIDTH, SIZE(50))];
        
        _bottomView.clickBtkBlock = ^(NSInteger index) {
            switch (index) {
                case 0:
                {
                    //跳回首页
                    bself.tabBarController.selectedIndex = 0;
                    [bself.navigationController popToRootViewControllerAnimated:NO];
                }
                    break;
                case 1:
                    //收藏
                {
//                    if ([bself.spellGoodsModel.isCollect isEqualToString:@"1"]) {
//                        [bself deleteCollectWIthID:bself.spellGoodsModel.ID];
//                    }else{
//                        [bself collectWIthID:bself.spellGoodsModel.ID];
//                    }
                }
                    break;
//                case 2:
//                    //客服
//                {
//                    UIWebView * callWebview = [[UIWebView alloc]init];
//                    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",bself.spellGoodsModel.linkPhone]]]];
//                    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
//                }
//                    break;
                case 3:
                {
                    if (!ISLOGIN) {
                        [bself.navigationController pushViewController:[NSClassFromString(@"CSLoginViewController") new] animated:YES];
                        return;
                    }
                    //发起拼团
                    [bself spell];
                }
                break;
                case 4:
                {
                    //参与拼团
                    [bself spell];
                }
                    break;
                    
                default:
                    break;
            }
        };
    }
    return _bottomView;
}
//发起拼团
- (void )spell{
    if (isEmptyStr(self.spellGoodsDetailModel.goodsCount)) {
        [Dialog toastCenter:@"拼团商品数量必须大于0!"];
        return;
    }
    ws(bself);
    [CSApiManager SpellWithParamDic:@{@"id":isEmptyStr(self.goodsID)?@"":self.goodsID,@"number":isEmptyStr(self.spellGoodsDetailModel.goodsCount)?@"1":self.spellGoodsDetailModel.goodsCount,@"indentCode":isEmptyStr(self.indentCode)?@"":self.indentCode} CallBack:^(id  _Nonnull data) {
        [Dialog toastCenter:BackMessage];
        if (ResultIsCorrect) {
            if (bself.needRefreshBLock) {
                bself.needRefreshBLock();
            }
//            [bself.navigationController popViewControllerAnimated:YES];
            [bself.navigationController pushViewController:[CSSpellSuccessViewController new] animated:YES];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}
////收藏
//- (void )collectWIthID:(NSString *)ID{
//    ws(bself);
//    [CSApiManager collectWithID:ID CallBack:^(id  _Nonnull data) {
//        if (ResultIsCorrect) {
//            MYLog(@"%@",data);
//            bself.spellGoodsModel.isCollect = @"1";
//            bself.bottomView.spellGoodsModel = bself.spellGoodsModel;
//        }
//        [Dialog toastCenter:BackMessage];
//    } fail:^(NSError * _Nonnull error) {
//        [Dialog toastCenter:@"网络错误"];
//    }];
//}
////取消收藏
//- (void )deleteCollectWIthID:(NSString *)ID{
//    ws(bself);
//    [CSApiManager deleteCollectWithID:ID CallBack:^(id  _Nonnull data) {
//        if (ResultIsCorrect) {
//            MYLog(@"%@",data);
//            bself.spellGoodsModel.isCollect = @"0";
//            bself.bottomView.spellGoodsModel = bself.spellGoodsModel;
//        }
//        [Dialog toastCenter:BackMessage];
//    } fail:^(NSError * _Nonnull error) {
//        [Dialog toastCenter:@"网络错误"];
//    }];
//}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = MainColor;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationController.navigationBar.tintColor = MainColor;
}

#pragma mark -- 导航右按钮
- (void )configNaviRightBtn{
    UIButton *rightBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(25), SIZE(25)) normalBackgroundImage:@"share_green" selectedBackgroundImage:@"share_green" touchUpInsideEvent:nil];
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}
- (void )btnClick:(UIButton *)sender{
    [self getSHareInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviRightBtn];
    [self.view addSubview:self.bottomView];
    CGFloat bottom = SafeAreaHeight;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(SIZE(50));
        make.bottom.offset(-bottom);
    }];
    
    if (!isEmptyStr(self.indentCode)) {
        self.bottomView.isShowJoinBtn = YES;
    }
    
    [self initTableView];
    [self getSpellDetails];
    
}
//获取分享商品的链接
- (void )getSHareInfo{
    ws(bself);
    [[Dialog Instance] showCenterProgressWithLabel:@"获取分享内容中..."];
    [CSApiManager SpellUrlWithID:self.goodsID CallBack:^(id  _Nonnull data) {
        [[Dialog Instance] hideProgress];
        
        if (ResultIsCorrect) {
            [Dialog toastCenter:@"已获取分享内容，\n请选择平台进行分享"];
            bself.shareInfoUrl = [NSString stringWithFormat:@"%@",data[@"data"]];
            [self shareWithTitle:@"莱瘦带您拼团" contents:bself.spellGoodsDetailModel.goodsName imageName:bself.spellGoodsDetailModel.goodsUrl linkUrl:bself.shareInfoUrl];
        }else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [[Dialog Instance] hideProgress];
        [Dialog toastCenter:@"网络错误"];
    }];
}




//SpellDetailsWithID
- (void )getSpellDetails{
    ws(bself);
    [CSApiManager SpellDetailsWithID:self.goodsID CallBack:^(id  _Nonnull data) {
        if (ResultIsCorrect) {
            bself.spellGoodsDetailModel = [CSSpellGoodsDetailModel mj_objectWithKeyValues:data[@"data"]];
            bself.spellGoodsDetailModel.goodsCount = @"1";
            bself.spellGoodsDetailModel.totalPrice = [NSString stringWithFormat:@"%.2lf",[bself.spellGoodsDetailModel.price floatValue] * [bself.spellGoodsDetailModel.goodsCount intValue]];
            bself.bottomView.spellGoodsModel = bself.spellGoodsDetailModel;
            [bself.tableView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
            [bself.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
        [bself.navigationController popViewControllerAnimated:YES];
    }];
}


- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[CSBenifitGoodsBannerCell class] forCellReuseIdentifier:@"CSBenifitGoodsBannerCell"];
    [_tableView registerClass:[CSGoodsDetailInfoCell class] forCellReuseIdentifier:@"CSGoodsDetailInfoCell"];
    [_tableView registerClass:[CSGoodsDistributionInfoCell class] forCellReuseIdentifier:@"CSGoodsDistributionInfoCell"];
    [_tableView registerClass:[CSGoodsSpecificationsCell class] forCellReuseIdentifier:@"CSGoodsSpecificationsCell"];
    [_tableView registerClass:[CSGroupPurchaseCell class] forCellReuseIdentifier:@"CSGroupPurchaseCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    CGFloat topHeight = kTopHeight;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(-topHeight);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(0);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==2) {
////        return 2;
//        return 0;
//    }
    return 1;
//    if (section==0) {
//        return 1;
//    }
//    else if (section==1) {
//        return 2;
//    }
//    else if (section==2){
//        return 1;
//    }
//    else if (section==3){
//        return 1;
//    }
//    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return SIZE(200);
    }
    
    else if (indexPath.section==1) {
//        if (indexPath.row==0) {
            return SIZE(140);
//        }
//        return SIZE(50);
    }
    else if (indexPath.section==2){
//        return SIZE(45);
//    }
//    else if (indexPath.section==3){
        return SIZE(85);
    }
    else if (indexPath.section==3){
        NSInteger ii = self.spellGoodsDetailModel.userList.count%4;
        BOOL isUp = ii>0;
        NSInteger row = (self.spellGoodsDetailModel.userList.count/4) + (isUp ? 1:0);
        
        return SIZE(155)*row;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2||section==3) {//section==2||
        return SIZE(10);
    }
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    if (indexPath.section==0) {
        CSBenifitGoodsBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSBenifitGoodsBannerCell"];
        cell.imageArray = @[isEmptyStr(self.spellGoodsDetailModel.goodsUrl)?@"":self.spellGoodsDetailModel.goodsUrl];
        return cell;
    }
    
    else if (indexPath.section==1){
//        if (indexPath.row==0) {
            CSGoodsDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSGoodsDetailInfoCell"];
            cell.spellGoodsModel = self.spellGoodsDetailModel;
            return cell;
//        }
//        CSGoodsDistributionInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSGoodsDistributionInfoCell"];
//        return cell;
    }
//    else if (indexPath.section==2){
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
//        cell.textLabel.text = [NSString stringWithFormat:@"%@：%@",(indexPath.row==0)?@"商家地址":@"联系电话",(indexPath.row==0)?self.spellGoodsDetailModel.receiveAddress:self.spellGoodsDetailModel.linkPhone];
//        cell.textLabel.font = FONT(15);
//        return cell;
//    }
    
    else if (indexPath.section==2){
        CSGoodsSpecificationsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSGoodsSpecificationsCell"];
        cell.spellModel = self.spellGoodsDetailModel;
        cell.addOrCutBtnClickBlock = ^(BOOL isAdd, NSString * _Nonnull nowCount) {
            if (isAdd) {
                //加商品
               bself.spellGoodsDetailModel.goodsCount = [NSString stringWithFormat:@"%ld",[nowCount integerValue]+1];
                
            }else{
                if ([nowCount integerValue]>0) {
                    bself.spellGoodsDetailModel.goodsCount = [NSString stringWithFormat:@"%ld",[nowCount integerValue]-1];
                }
            }
            bself.spellGoodsDetailModel.totalPrice = [NSString stringWithFormat:@"%.2lf",[bself.spellGoodsDetailModel.goodsCount integerValue] * [bself.spellGoodsDetailModel.price floatValue]];
            bself.bottomView.spellGoodsModel = bself.spellGoodsDetailModel;
            
            [bself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    }
    else if (indexPath.section==3){
        CSGroupPurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSGroupPurchaseCell"];
        [cell setMenberList:self.spellGoodsDetailModel.userList spellNumber:self.spellGoodsDetailModel.spellNumber];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 2&&indexPath.row == 1){
//        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.spellGoodsDetailModel.linkPhone];
//        UIWebView *callWebview = [[UIWebView alloc] init];
//        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//        [self.view addSubview:callWebview];
//    }
}


@end
