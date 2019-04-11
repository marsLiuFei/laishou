//
//  CSActivityDetailViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSActivityDetailViewController.h"
#import "CSSignUpPeopleListViewController.h"
#import "CSPayOrderDetailViewController.h"

#import "CSActivityDetailModel.h"

#import "CSBannerPicsCell.h"
#import "CSActivityDetailInfoCell.h"
#import "CSContactClubCell.h"
#import "CSSignUpPeopleCell.h"
#import "CSActivityNameCell.h"
#import "XBWCSGoodsDetailContentInfoCell.h"

@interface CSActivityDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray *titlesAndImages;
/**
 *  活动详情模型
 */
@property(nonatomic, strong)CSActivityDetailModel *activityDetailModel;
/**
 *
 **/
@property(nonatomic, strong)UIButton *signBtn;
@property(nonatomic, strong)UIView *bottomView;
@end


@implementation CSActivityDetailViewController

- (CSActivityDetailModel *)activityDetailModel{
    if (!_activityDetailModel) {
        _activityDetailModel = [CSActivityDetailModel  new];
    }
    return _activityDetailModel;
}

-(NSArray *)titlesAndImages{
    if (!_titlesAndImages) {
        _titlesAndImages = @[@{@"title":@"04-14 08:00 至 11:00",@"imageName":@"circle_time"},@{@"title":@"安徽省合肥市蜀山去湖光路1181号附近 中国",@"imageName":@"circle_location"},@{@"title":@"已报名119人",@"imageName":@"circle_signUp"},@{@"title":@"举办方",@"imageName":@"club_icon"},@{@"title":@"￥50～100",@"imageName":@"circle_money"}];
    }
    return _titlesAndImages;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitleStr:@""];
    [self creatBottomView];
    [self initTableView];
    [self addRefresh];
    [self activityDetails];
    UIButton *shareBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(30), SIZE(30)) normalImage:@"share_green" selectedImage:@"share_green" touchUpInsideEvent:nil];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
}
//点击了分享按钮
- (void )shareBtnClick{
    ws(bself);
    [[Dialog Instance]showCenterProgressWithLabel:@"获取分享内容..."];
    [CSApiManager ActivityUrlWithID:self.activityID CallBack:^(id  _Nonnull data) {
        [[Dialog Instance] hideProgress];
        
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
//            [Dialog toastCenter:@"获取分享内容成功!"];
            NSString *linkUrl = [NSString stringWithFormat:@"%@",data[@"data"]];
            MYLog(@"%@",linkUrl);
            [bself shareWithTitle:[NSString stringWithFormat:@"%@",self.activityDetailModel.activityTitle] contents:@"点击跳转莱瘦app应用程序查看活动详情" imageName:self.activityImageUrl linkUrl:isEmptyStr(linkUrl)?@"https://www.baidu.com":linkUrl];
        }else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
    
    
}

- (void )addRefresh{
    ws(bself);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        bself.page = 1;
        [bself activityDetails];
    }];
    //    [_tableView.mj_header beginRefreshing];
//    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        bself.page ++;
//        [bself loadData];
//    }];
}
- (void )activityDetails{
    ws(bself);
    [CSApiManager activityDetailsWithID:isEmptyStr(self.activityID)?@"":self.activityID CallBack:^(id  _Nonnull data) {
        [bself.tableView.mj_header endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            bself.activityDetailModel = [CSActivityDetailModel mj_objectWithKeyValues:data[@"data"]];
            
            
            NSDate *startDate = [NSDate ZYQ_dateWithString:bself.activityDetailModel.strStartTime format:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *endDate = [NSDate ZYQ_dateWithString:bself.activityDetailModel.strEndTime format:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *currentDate = [NSDate ZYQ_dateWithString:[NSDate ZYQ_getNewTimeFormat:@"yyyy-MM-dd HH:mm:ss"] format:@"yyyy-MM-dd HH:mm:ss"];
            
            if (bself.isNeedPay) {
                //从订单页面进入且需要付款
                [self.signBtn setTitle:@"去支付" forState:UIControlStateNormal];
            }else{
                if ([XBWCSCommonTool compareDate:currentDate withDate:startDate]) {
                    //活动未开始
                    [self.signBtn setTitle:@"未开始" forState:UIControlStateNormal];
                    self.signBtn.userInteractionEnabled = NO;
                    [self.signBtn setBackgroundColor:RGB(222, 222, 222)];
                }
                else if ([XBWCSCommonTool compareDate:endDate withDate:currentDate]) {
                    //活动已结束
                    [self.signBtn setTitle:@"已结束" forState:UIControlStateNormal];
                    self.signBtn.userInteractionEnabled = NO;
                    [self.signBtn setBackgroundColor:RGB(222, 222, 222)];
                }
            }
            
            
            
            [bself.tableView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
            [bself.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError * _Nonnull error) {
        [bself.tableView.mj_header endRefreshing];
        [Dialog toastCenter:@"网络错误"];
        [bself.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark -- 底部付费按钮
//普通管理状态下会有审核按钮，驾驶员无按钮
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGBA(238, 238, 238, 1)];
        
        self.signBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"立即报名" titleColor:WhiteColor font:MediumFont(SIZE(16)) backgroundColor:MainColor touchUpInsideEvent:nil];
        [self.signBtn addTarget:self action:@selector(payOrder) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.signBtn];
        [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.top.bottom.offset(0);
            make.width.offset(SIZE(130));
        }];
        
        
    }
    return _bottomView;
}


- (void )payOrder{
    if (!ISLOGIN) {
        [self.navigationController pushViewController:[NSClassFromString(@"CSLoginViewController") new] animated:YES];
        return;
    }
    
    
    ws(bself);
    if ([self.activityDetailModel.signType isEqualToString:@"2"]) {
        //积分活动不要跳转支付
        [CSApiManager IntegralSignWithActivityID:isEmptyStr(self.activityDetailModel.ID)?@"":self.activityDetailModel.ID CallBack:^(id  _Nonnull data) {
            [Dialog toastCenter:BackMessage];
            if (ResultIsCorrect) {
                [bself.signBtn setBackgroundColor:RGB(199, 199, 199)];
                bself.signBtn.userInteractionEnabled = NO;
                [bself.signBtn setTitleColor:RGB153 forState:UIControlStateNormal];
                [bself.signBtn setTitle:@"已报名" forState:UIControlStateNormal];
            }
            
        } fail:^(NSError * _Nonnull error) {
            [Dialog toastCenter:@"网络错误"];
        }];
    }else{
        //人民币活动
        if ([self.activityDetailModel.price isEqualToString:@"0"]) {
            //免费活动
            [CSApiManager IntegralSignWithActivityID:isEmptyStr(self.activityDetailModel.ID)?@"":self.activityDetailModel.ID CallBack:^(id  _Nonnull data) {
                [Dialog toastCenter:BackMessage];
                if (ResultIsCorrect) {
                    [bself.signBtn setBackgroundColor:RGB(199, 199, 199)];
                    bself.signBtn.userInteractionEnabled = NO;
                    [bself.signBtn setTitleColor:RGB153 forState:UIControlStateNormal];
                    [bself.signBtn setTitle:@"已报名" forState:UIControlStateNormal];
                }
                
            } fail:^(NSError * _Nonnull error) {
                [Dialog toastCenter:@"网络错误"];
            }];
        }
        else{
            //付费活动跳转支付页面
            CSPayOrderDetailViewController *vc =  [CSPayOrderDetailViewController new];
            vc.activityDetailModel = bself.activityDetailModel;
            vc.isNeedPay = bself.isNeedPay;
            vc.orderID = bself.orderID;
            [bself.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    
//
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

- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    [_tableView registerClass:[CSBannerPicsCell class] forCellReuseIdentifier:@"CSBannerPicsCell"];
    [_tableView registerClass:[CSActivityDetailInfoCell class] forCellReuseIdentifier:@"CSActivityDetailInfoCell"];
    [_tableView registerClass:[CSContactClubCell class] forCellReuseIdentifier:@"CSContactClubCell"];
    [_tableView registerClass:[CSSignUpPeopleCell class] forCellReuseIdentifier:@"CSSignUpPeopleCell"];
    [_tableView registerClass:[CSActivityNameCell class] forCellReuseIdentifier:@"CSActivityNameCell"];
    [_tableView registerClass:[XBWCSGoodsDetailContentInfoCell class] forCellReuseIdentifier:@"XBWCSGoodsDetailContentInfoCell"];
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
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return self.titlesAndImages.count;
            break;
        case 2:
            return isEmptyStr(self.activityDetailModel.activityContent)?0:1;
            break;
        case 3:
            return self.activityDetailModel.signList.count>0?1:0;
            break;

        default:
            return 0;
            break;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0||section==1) {
        return 0.001;
    }
    return SIZE(10);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row==0) {
            return SCREEN_WIDTH*0.5;
        }
        return self.activityDetailModel.titleCellHeight;
    }
    else if (indexPath.section==1){
        return SIZE(35);
    }
    else  if (indexPath.section==2){
        return [XBWCSGoodsDetailContentInfoCell cellHeight];
    }
    else  if (indexPath.section==3){
        return SIZE(155);
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            CSBannerPicsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSBannerPicsCell"];
            cell.imageArray = @[isEmptyStr(self.activityDetailModel.img)?@"popup_img":self.activityDetailModel.img];
            return cell;
        }
        CSActivityNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSActivityNameCell"];
        cell.titleName = self.activityDetailModel.activityTitle;
        return cell;
    }
    else if (indexPath.section==1){
        CSActivityDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSActivityDetailInfoCell"];
        NSDictionary *dic = self.titlesAndImages[indexPath.row];
        if (indexPath.row==0) {
            [cell setIconWithName:dic[@"imageName"] content:[NSString stringWithFormat:@"%@至%@",isEmptyStr(self.activityDetailModel.strStartTime)?@"":self.activityDetailModel.strStartTime,isEmptyStr(self.activityDetailModel.strEndTime)?@"":self.activityDetailModel.strEndTime] isHiddenRightIcon:YES];
        }
        else if (indexPath.row==1) {
            [cell setIconWithName:dic[@"imageName"] content:self.activityDetailModel.clubAddress isHiddenRightIcon:NO];
        }
        else if (indexPath.row==2) {
            [cell setIconWithName:dic[@"imageName"] content:[NSString stringWithFormat:@"已报名%@人",self.activityDetailModel.signTotal] isHiddenRightIcon:YES];
        }
        else if (indexPath.row==3) {
            [cell setIconWithName:dic[@"imageName"] content:[NSString stringWithFormat:@"举办方：%@",self.activityDetailModel.clubName] isHiddenRightIcon:YES];
            cell.rightIcon = @"phone";
        }
        else {
            //报名费
            cell.contentColor = RGBA(237, 130, 32, 1);
            [cell setIconWithName:dic[@"imageName"] content:[NSString stringWithFormat:@"%@%@",[self.activityDetailModel.price isEqualToString:@"0"]?@"免费":self.activityDetailModel.price,[self.activityDetailModel.price isEqualToString:@"0"]?@"":([self.activityDetailModel.signType isEqualToString:@"1"]?@"元":@"积分")] isHiddenRightIcon:YES];
        }
        return cell;
    }
    else if (indexPath.section==2){
        XBWCSGoodsDetailContentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBWCSGoodsDetailContentInfoCell"];
        cell.htmlString = self.activityDetailModel.activityContent;
        cell.reloadBlock =^(void)
        {
            [bself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    }
    else{
        //已报名人数
        CSSignUpPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSSignUpPeopleCell"];
        cell.models = self.activityDetailModel.signList;
        cell.clickMoreBtnBlock = ^{
            MYLog(@"点击了更多按钮");
            CSSignUpPeopleListViewController *vc = [CSSignUpPeopleListViewController new];
            vc.activityId = bself.activityDetailModel.ID;
            [bself.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1&&indexPath.row==3) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.activityDetailModel.clubPhone];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
}








@end
