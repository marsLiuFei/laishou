//
//  CSBaseMineViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseMineViewController.h"
#import "CSClubDetailViewController.h"
#import "CSMyAsCounselorController.h"
#import "CSBaseWebViewController.h"
#import "CSSignInViewController.h"
#import "CSBrowseHistoryViewController.h"
#import "CSCouponViewController.h"
#import "CSMyInfoViewController.h"
#import "CSOrderViewController.h"
#import "CSMyCollectViewController.h"
#import "CSHelpAndFeedbackViewController.h"
#import "CSPKViewController.h"
#import "CSMyCircleViewController.h"
#import "CSPKViewController.h"
#import "CSSettingViewController.h"
#import "CSScanCodeViewController.h"
#import "CSGradeAndWeightViewController.h"
#import "CSPromoteViewController.h"
#import "CSPersonalInfoModel.h"

#import "CSLoseWeightCell.h"
#import "CSMineCommonlyCell.h"
#import "CSMineClubInfoCell.h"
#import "CSBaseMineHeaderView.h"


@interface CSBaseMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)CSBaseMineHeaderView *headerView;
/**
 *  cell标题和图片
 */
@property(nonatomic, strong)NSMutableArray *titlesAndImages;
/**
 *  个人信息model
 */
@property(nonatomic, strong)CSPersonalInfoModel *personalModel;
/**
 *  签到按钮
 */
@property(nonatomic, strong)UIButton *signBtn;
@end

@implementation CSBaseMineViewController
-(CSPersonalInfoModel *)personalModel{
    if (!_personalModel) {
        _personalModel = [CSPersonalInfoModel new];
    }
    return _personalModel;
}
-(NSMutableArray *)titlesAndImages{
    if (!_titlesAndImages) {
        NSMutableArray *arrM = [NSMutableArray new];
        NSString *loginType = [UDefault getObject:LoginType];
        if ([loginType isEqualToString:@"5"]) {
            //顾问
            arrM = @[/*@{@"title":@"浏览记录",@"imageName":@"records",@"tag":@"98"},@{@"title":@"莱瘦神券",@"imageName":@"coupon",@"tag":@"99"},*/@{@"title":@"我的推广",@"imageName":@"recommend",@"tag":@"100"},@{@"title":@"同步数据",@"imageName":@"sysnData",@"tag":@"101"},@{@"title":@"我要加盟",@"imageName":@"joinClub",@"tag":@"102"},@{@"title":@"我是营养顾问",@"imageName":@"setting",@"tag":@"105"}/*,@{@"title":@"帮助反馈",@"imageName":@"help_icon",@"tag":@"103"}*/,@{@"title":@"我的设置",@"imageName":@"setting",@"tag":@"104"}].mutableCopy;
        }else{
            arrM = @[/*@{@"title":@"浏览记录",@"imageName":@"records",@"tag":@"98"},@{@"title":@"莱瘦神券",@"imageName":@"coupon",@"tag":@"99"},*/@{@"title":@"我的推广",@"imageName":@"recommend",@"tag":@"100"},@{@"title":@"同步数据",@"imageName":@"sysnData",@"tag":@"101"},@{@"title":@"我要加盟",@"imageName":@"joinClub",@"tag":@"102"}/*,@{@"title":@"帮助反馈",@"imageName":@"help_icon",@"tag":@"103"}*/,@{@"title":@"我的设置",@"imageName":@"setting",@"tag":@"104"}].mutableCopy;
        }
        _titlesAndImages = arrM;
    }
    return _titlesAndImages;
}
-(CSBaseMineHeaderView *)headerView{
    if (!_headerView) {
        ws(weakSelf);
        _headerView = [[CSBaseMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(360))];
        _headerView.InfoBlock = ^{
            CSMyInfoViewController *vc = [[CSMyInfoViewController alloc]init];
            vc.userInfoModel = weakSelf.personalModel;
            vc.needRefreshBlock = ^{
                [weakSelf.tableView.mj_header beginRefreshing];
            };
            [weakSelf.navigationController pushViewController:vc animated:true];
        };
        _headerView.otherBtnClickBlock = ^(NSInteger index) {
            switch (index) {
                case 0:
                    //订单
                    [weakSelf.navigationController pushViewController:[CSOrderViewController new] animated:YES];
                    break;
                case 1:
                    //发表
                    break;
                case 2:
                    //收藏
                    [weakSelf.navigationController pushViewController:[CSMyCollectViewController new] animated:YES];
                    break;
                case 3:
                    //我的成绩
                {
                    CSGradeAndWeightViewController *weight = [[CSGradeAndWeightViewController alloc] init];
                    [weakSelf.navigationController pushViewController:weight animated:true];
                }
                    break;
                case 4:
                    //我的圈子
                    [weakSelf.navigationController pushViewController:[CSMyCircleViewController new] animated:YES];
                    break;
                case 5:
                    //我的俱乐部
                {
                    if (isEmptyStr(weakSelf.personalModel.clubId)) {
                        [Dialog alertWithTitle:@"温馨提示" andMessage:@"您还未绑定俱乐部，请通过首页扫码按钮点击扫码绑定!"];
                        return ;
                    }
                    CSClubDetailViewController *vc = [[CSClubDetailViewController alloc]init];
                    vc.clubId = weakSelf.personalModel.clubId;
                    [weakSelf.navigationController pushViewController:vc animated:true];
                }
                    break;
                case 6:
                    //我的管家服务
                    break;
                    
                default:
                    break;
            }
        };
        _headerView.OrderBlock = ^{
             [weakSelf.navigationController pushViewController:[[CSOrderViewController alloc]init] animated:true];
        };
    }
    return _headerView;
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:WhiteColor};
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    if (self.gotoHome) {
        self.tabBarController.selectedViewController =   [self.tabBarController.viewControllers objectAtIndex:0];
        self.gotoHome = false;
    }
    if ([[UDefault getObject:@"updateInfo"] isEqualToString:@"true"] ) {
        [self.tableView.mj_header beginRefreshing];
        [UDefault setObject:@"false" keys:@"updateInfo"];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = NO; self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationController.navigationBar.barTintColor = WhiteColor;
    self.navigationController.navigationBar.tintColor = MainColor;
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviRightBtn];
    [self initTableView];
    [self addRefresh];
    [self getMyInfo];
    [NSNotic_Center addObserver:self selector:@selector(needFresh) name:PayIntegralGoodsSuccess object:nil];
    [NSNotic_Center addObserver:self selector:@selector(needFresh) name:LOGINSUCCESS object:nil];
}

- (void )needFresh{
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //  顾问登录没有有签到按钮
        self.signBtn.hidden = YES;
        self.headerView.isCounlor = YES;
        self.titlesAndImages = @[/*@{@"title":@"浏览记录",@"imageName":@"records",@"tag":@"98"},@{@"title":@"莱瘦神券",@"imageName":@"coupon",@"tag":@"99"},*/@{@"title":@"我的推广",@"imageName":@"recommend",@"tag":@"100"},@{@"title":@"同步数据",@"imageName":@"sysnData",@"tag":@"101"},@{@"title":@"我要加盟",@"imageName":@"joinClub",@"tag":@"102"},@{@"title":@"我是营养顾问",@"imageName":@"setting",@"tag":@"105"},@{@"title":@"帮助反馈",@"imageName":@"help_icon",@"tag":@"103"},@{@"title":@"我的设置",@"imageName":@"setting",@"tag":@"104"}].mutableCopy;
    }else{
        self.signBtn.hidden = NO;
        self.headerView.isCounlor = NO;
        self.titlesAndImages = @[/*@{@"title":@"浏览记录",@"imageName":@"records",@"tag":@"98"},@{@"title":@"莱瘦神券",@"imageName":@"coupon",@"tag":@"99"},*/@{@"title":@"我的推广",@"imageName":@"recommend",@"tag":@"100"},@{@"title":@"同步数据",@"imageName":@"sysnData",@"tag":@"101"},@{@"title":@"我要加盟",@"imageName":@"joinClub",@"tag":@"102"},@{@"title":@"帮助反馈",@"imageName":@"help_icon",@"tag":@"103"},@{@"title":@"我的设置",@"imageName":@"setting",@"tag":@"104"}].mutableCopy;
    }
    [self.tableView.mj_header beginRefreshing];
}



#pragma mark -- 获取我的信息
- (void )addRefresh{
    
    ws(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself getMyInfo];
    }];
//    [self.tableView.mj_header beginRefreshing];
    //    self.aTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //        page ++;
    //        [bself requestMainData];
    //    }];
}
- (void )getMyInfo{
    if (!ISLOGIN) {
        [self.tableView.mj_header endRefreshing];
        return;
    }
    ws(bself);
    
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        [CSApiManager CounselorInfoCallBack:^(id  _Nonnull data) {
            [bself.tableView.mj_header endRefreshing];
            MYLog(@"%@",data);
            if (ResultIsCorrect) {
                bself.personalModel = [CSPersonalInfoModel mj_objectWithKeyValues:data[@"data"]];
                [Dialog Instance].isSigned = bself.personalModel.isSign;
                bself.headerView.personalModel = bself.personalModel;
                [bself.tableView reloadData];
            }
            else{
                [Dialog toastCenter:BackMessage];
            }
            [bself.tableView reloadData];
        } fail:^(NSError * _Nonnull error) {
            [Dialog toastCenter:@"网络错误"];
            [bself.tableView.mj_header endRefreshing];
        }];
    }else{
        [CSApiManager myLoginInfoCallBack:^(id  _Nonnull data) {
            [bself.tableView.mj_header endRefreshing];
            MYLog(@"%@",data);
            if (ResultIsCorrect) {
                bself.personalModel = [CSPersonalInfoModel mj_objectWithKeyValues:data[@"data"]];
                [Dialog Instance].isSigned = bself.personalModel.isSign;
                bself.headerView.personalModel = bself.personalModel;
                [bself.tableView reloadData];
            }
            else{
                [Dialog toastCenter:BackMessage];
            }
            [bself.tableView reloadData];
        } fail:^(NSError * _Nonnull error) {
            [Dialog toastCenter:@"网络错误"];
            [bself.tableView.mj_header endRefreshing];
        }];
    }
    
    
    
    
    
    
}







#pragma mark -- 导航右按钮
- (void )configNaviRightBtn{
    //顾问
    self.signBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(25), SIZE(25)) normalBackgroundImage:@"signIcon" selectedBackgroundImage:@"signIcon" touchUpInsideEvent:nil];
    self.signBtn.tag = 10010;
    [self.signBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.signBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.signBtn];
    
    
    UIButton *leftBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(25), SIZE(25)) normalBackgroundImage:@"msg" selectedBackgroundImage:@"msg" touchUpInsideEvent:nil];
    [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 10011;
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}
- (void )btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 10010:
        {
            NSString *loginType = [UDefault getObject:LoginType];
            if ([loginType isEqualToString:@"5"]) {
                    [Dialog toastCenter:@"这是莱瘦会员服务，管家请注意"];
                    return;
            }
            //签到
            CSSignInViewController *vc = [CSSignInViewController new];
            vc.formVcName = @"mineVC";
//            vc.isSigned = [Dialog Instance].isSigned;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10011:
        {
            //消息
        }
            break;
            
        default:
            break;
    }
}


- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[CSLoseWeightCell class] forCellReuseIdentifier:@"CSLoseWeightCell"];
    [_tableView registerClass:[CSMineCommonlyCell class] forCellReuseIdentifier:@"CSMineCommonlyCell"];
    [_tableView registerClass:[CSMineClubInfoCell class] forCellReuseIdentifier:@"CSMineClubInfoCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    CGFloat top = NAV_HEIGHT;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(-top);
        make.left.right.bottom.offset(0);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        return 2;
    }else{
        return 4;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        switch (section) {
            case 0:
                return 0;
                break;
            case 1:
                return self.titlesAndImages.count;
                break;
                
            default:
                return 0;
                break;
        }
    }else{
        switch (section) {
            case 0:
                return 0;
                break;
            case 1:
                return 1;
                break;
            case 2:
                return 1;
                break;
            case 3:
                return self.titlesAndImages.count;
                break;
                
            default:
                return 0;
                break;
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        switch (section) {
            case 0:
                return SIZE(360);
                break;
            case 1:
                return SIZE(10);
                break;
                
            default:
                return 0;
                break;
        }
    }else{
        switch (section) {
            case 0:
                return SIZE(360);
                break;
            case 1:
                return SIZE(44);
                break;
            case 2:
                return SIZE(44);
                break;
            case 3:
                return SIZE(10);
                break;
                
            default:
                return 0;
                break;
        }
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        switch (section) {
            case 0:
                return self.headerView;
                break;
            case 1:
            
                return [UIView new];
                break;
                
            default:
                return [UIView new];
                break;
        }
    }else{
        switch (section) {
            case 0:
                return self.headerView;
                break;
            case 1:
            {
                UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(44)) backgroundColor:ClearColor];
                UILabel *titleLabel = [ViewCreate createLabelFrame:CGRectMake(SIZE(15), 0, SIZE(200), SIZE(44)) backgroundColor:ClearColor text:@"我的计划" textColor:RGB44 textAlignment:Left font:FONT(16)];
                [bgView addSubview:titleLabel];
                return bgView;
            }
                break;
            case 2:
            {
                UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(44)) backgroundColor:ClearColor];
                UILabel *titleLabel = [ViewCreate createLabelFrame:CGRectMake(SIZE(15), 0, SIZE(200), SIZE(44)) backgroundColor:ClearColor text:@"我的活动" textColor:RGB44 textAlignment:Left font:FONT(16)];
                [bgView addSubview:titleLabel];
                return bgView;
            }
                break;
            case 3:
                return [UIView new];
                break;
                
            default:
                return [UIView new];
                break;
        }
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        return SIZE(55);
    }
    else{
        if (indexPath.section==1) {
            return SIZE(120);
        }
        else if (indexPath.section==2) {
            return SIZE(146);
        }
        return SIZE(55);
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        if (indexPath.section == 1) {
            CSMineCommonlyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSMineCommonlyCell"];
            NSDictionary *dic = self.titlesAndImages[indexPath.row];
            cell.imageName = dic[@"imageName"];
            cell.titleName = dic[@"title"];
            return cell;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        return cell;
    }
    else{
        if (indexPath.section == 1) {
            CSLoseWeightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSLoseWeightCell"];
            cell.personalModel = self.personalModel;
            cell.loseFatBtnClickBlock = ^{
                //            bself.tabBarController.selectedIndex = 0;
                CSGradeAndWeightViewController *weight = [[CSGradeAndWeightViewController alloc] init];
                [bself.navigationController pushViewController:weight animated:true];
            };
            return cell;
        }
        if (indexPath.section==2) {
            CSMineClubInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSMineClubInfoCell"];
            cell.personalModel = self.personalModel;
            cell.clickBtnBlock = ^(NSInteger index) {
                if (!ISLOGIN) {
                    [bself.navigationController pushViewController:[NSClassFromString(@"CSLoginViewController") new] animated:YES];
                    return;
                }
                if (index==0) {
                    //扫码
                    CSScanCodeViewController *vc = [CSScanCodeViewController new];
                    vc.needFreshBlock = ^{
                        //绑定顾问、俱乐部成功
                        [bself.tableView.mj_header beginRefreshing];
                    };
                    [bself.navigationController pushViewController:vc animated:YES];
                    
                }
                else{
                    //预约
                    UIWebView * callWebview = [[UIWebView alloc]init];
                    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.personalModel.counselorMobile]]]];
                    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
                }
            };
            return cell;
        }
        else if (indexPath.section == 3){
            CSMineCommonlyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSMineCommonlyCell"];
            NSDictionary *dic = self.titlesAndImages[indexPath.row];
            cell.imageName = dic[@"imageName"];
            cell.titleName = dic[@"title"];
            return cell;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        if (indexPath.section == 1) {
            NSDictionary *dic = self.titlesAndImages[indexPath.row];
            NSString *tag = dic[@"tag"];
            
            
            //        if (indexPath.row == 0) {
            //            CSBrowseHistoryViewController *browseVc = [[CSBrowseHistoryViewController alloc] init];
            //            [self.navigationController pushViewController:browseVc animated:true];
            //        }
            //        if (indexPath.row == 1) {
            //            CSCouponViewController *couponVc = [[CSCouponViewController alloc] init];
            //            [self.navigationController pushViewController:couponVc animated:true];
            //        }
            
            switch ([tag intValue]) {
                case 100:
                {
                    //我的推广
                    CSPromoteViewController *vc = [CSPromoteViewController new];
                    vc.counselor = true;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 101:
                {  //同步数据
                    CSPKViewController *pkVc = [[CSPKViewController alloc] init];
                    [self.navigationController pushViewController:pkVc animated:true];
                }
                    break;
                case 102:
                {
                    //我要加盟
                    CSBaseWebViewController *vc = [CSBaseWebViewController new];
                    vc.url = @"https://daiyue.site/joinus.html";
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 103:
                {
                    //帮助反馈
                    CSHelpAndFeedbackViewController *couponVc = [[CSHelpAndFeedbackViewController alloc] init];
                    [self.navigationController pushViewController:couponVc animated:true];
                }
                    break;
                case 104:
                {
                    //我的设置
                    CSSettingViewController *settingVc = [[CSSettingViewController alloc] init];
                    [self.navigationController pushViewController:settingVc animated:true];
                }
                    break;
                case 105:
                {
                    //我是营养顾问
                    CSMyAsCounselorController *settingVc = [[CSMyAsCounselorController alloc] init];
                    settingVc.counselorId = self.personalModel.ID;
                    [self.navigationController pushViewController:settingVc animated:true];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
    }
    else{
        if (indexPath.section == 3) {
            NSDictionary *dic = self.titlesAndImages[indexPath.row];
            NSString *tag = dic[@"tag"];
            
            
            //        if (indexPath.row == 0) {
            //            CSBrowseHistoryViewController *browseVc = [[CSBrowseHistoryViewController alloc] init];
            //            [self.navigationController pushViewController:browseVc animated:true];
            //        }
            //        if (indexPath.row == 1) {
            //            CSCouponViewController *couponVc = [[CSCouponViewController alloc] init];
            //            [self.navigationController pushViewController:couponVc animated:true];
            //        }
            
            switch ([tag intValue]) {
                case 100:
                {
                    //我的推广
                    CSPromoteViewController *vc = [CSPromoteViewController new];
                    vc.counselor = false;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 101:
                {  //同步数据
                    CSPKViewController *pkVc = [[CSPKViewController alloc] init];
                    [self.navigationController pushViewController:pkVc animated:true];
                }
                    break;
                case 102:
                {
                    //我要加盟
                    CSBaseWebViewController *vc = [CSBaseWebViewController new];
                    vc.url = @"http://share.laiscn.com/joinus";
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 103:
                {
                    //帮助反馈
                    [Dialog toastCenter:@"暂未开通"];
//                    CSHelpAndFeedbackViewController *couponVc = [[CSHelpAndFeedbackViewController alloc] init];
//                    [self.navigationController pushViewController:couponVc animated:true];
                }
                    break;
                case 104:
                {
                    //我的设置
                    CSSettingViewController *settingVc = [[CSSettingViewController alloc] init];
                    [self.navigationController pushViewController:settingVc animated:true];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
    }
}


@end
