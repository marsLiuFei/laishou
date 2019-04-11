//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//  CSPromoteViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/24.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSPromoteViewController.h"

#import "CSCounselorTitleTableViewCell.h"
#import "CSCounselorMembersTableViewCell.h"
#import "CSUserMemberModel.h"

#import "CSShareAlertView.h"

@interface CSPromoteViewController ()<UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>
{
    UITableView *_tableView;
  
}
/** userList */
@property(nonatomic , strong)NSMutableArray *userList;
@property(nonatomic, assign)NSInteger page;


@end

@implementation CSPromoteViewController

NSString *kCSPromoteTitleTableViewCell = @"kCSPromoteTitleTableViewCell";
NSString *kCSPromoteTableViewCell = @"kCSPromoteTableViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.userList = [NSMutableArray array];
    self.page = 1;
    [self setupUI];
    [self loadData];
    [self addRefresh];
}
#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@"我的推广"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
//    [self setupHeaderView];
    
    UIButton *shareBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(30), SIZE(30)) normalImage:@"share_green" selectedImage:@"share_green" touchUpInsideEvent:nil];
    [shareBtn addTarget:self action:@selector(sharePromote) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
}



- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTopHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [tableView registerClass:[CSCounselorTitleTableViewCell class] forCellReuseIdentifier:kCSPromoteTitleTableViewCell];
    [tableView registerClass:[CSCounselorMembersTableViewCell class] forCellReuseIdentifier:kCSPromoteTableViewCell];
    [self.view addSubview:tableView];
    _tableView = tableView;
}
//- (void) setupHeaderView{
//    //首页轮播图没有图片的时候放一张默认图，暂时没有放
//    SDCycleScrollView *headetView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(200)) delegate:self placeholderImage:[UIImage imageNamed:@"popup_img"]];
//    headetView.currentPageDotColor = NAV_COLOR;
//    headetView.autoScroll = YES;
//    headetView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    headetView.clipsToBounds = YES;
//    headetView.backgroundColor = WhiteColor;
//    headetView.imageURLStringsGroup = @[@"popup_img"];
//    _tableView.tableHeaderView = headetView;
//}
#pragma mark -  loadData
- (void )addRefresh{
    [self.userList insertObject:[CSUserMemberModel loadTitleData] atIndex:0];
    ws(bself);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 1;
        [bself loadData];
    }];
    //    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself loadData];
    }];
}
- (void)loadData {
     ws(bself);
    NSMutableDictionary *paramDic = @{@"page":@(self.page),@"rows":@"10"}.mutableCopy;
    if (self.counselor) {
        [CSApiManager counselorPromoteWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
            [self->_tableView.mj_header endRefreshing];
            [self->_tableView.mj_footer endRefreshing];
            if (ResultIsCorrect) {
                MYLog(@"%@",data);
                NSArray *arr = [CSUserMemberModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
                if (arr.count>0) {
                    if (bself.page>1) {
                        [bself.userList addObjectsFromArray:arr];
                    }else{
                        bself.userList = [NSMutableArray array];
                        bself.userList = arr.mutableCopy;
                        [bself.userList insertObject:[CSUserMemberModel loadTitleData] atIndex:0];
                    }
                }
                [self->_tableView reloadData];
            }
        } fail:^(NSError * _Nonnull error) {
            [Dialog toastCenter:@"网络错误"];
            [self->_tableView.mj_header endRefreshing];
            [self->_tableView.mj_footer endRefreshing];
            
        }];
    }else {
        [CSApiManager userPromoteWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
           
            [self->_tableView.mj_header endRefreshing];
            [self->_tableView.mj_footer endRefreshing];
            if (ResultIsCorrect) {
                MYLog(@"%@",data);
                NSArray *arr = [CSUserMemberModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
                if (arr.count>0) {
                    if (bself.page>1) {
                        [bself.userList addObjectsFromArray:arr];
                    }else{
                        bself.userList = [NSMutableArray array];
                        bself.userList = arr.mutableCopy;
                        [bself.userList insertObject:[CSUserMemberModel loadTitleData] atIndex:0];
                    }
                }
                [self->_tableView reloadData];
            }
        } fail:^(NSError * _Nonnull error) {
            [Dialog toastCenter:@"网络错误"];
            [self->_tableView.mj_header endRefreshing];
            [self->_tableView.mj_footer endRefreshing];
        }];
    }

}


#pragma mark --SDCycleScrollViewDelete

//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
//    [self sharePromote];
//}
//点击分享
- (void)sharePromote {
    [[Dialog Instance] showCenterProgressWithLabel:@"获取分享内容中..."];
    [CSApiManager SharePromoteCallBack:^(id  _Nonnull data) {
        [[Dialog Instance] hideProgress];
        
        if (ResultIsCorrect) {
//            [Dialog toastCenter:@"已获取分享内容，\n请选择平台进行分享"];
            NSString *shareInfoUrl = [NSString stringWithFormat:@"%@",data[@"data"]];
//            [self shareWithTitle:@"要想瘦，找莱瘦" contents:@"点击跳转莱瘦app应用程序查看" imageName:@"" linkUrl:shareInfoUrl];
            
            CSShareAlertView *alertView = [[CSShareAlertView alloc] init];
            [alertView showInView:[UIApplication sharedApplication].keyWindow shareUrl:shareInfoUrl];
        }else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [[Dialog Instance] hideProgress];
        [Dialog toastCenter:@"网络错误"];
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CSCounselorTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSPromoteTitleTableViewCell forIndexPath:indexPath];
        return cell;
    }
    CSCounselorMembersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSPromoteTableViewCell forIndexPath:indexPath];
    cell.black = true;
    cell.show = NO;
    cell.userModel = self.userList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return SIZE(21);
        }
       
    }
    return SIZE(60);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.viewWidth, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titlLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
    titlLabel.text = @"我的会员";
    titlLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size: 16];
    titlLabel.textColor = RGB(67, 207, 124);
    [headerView addSubview:titlLabel];
    return headerView;
}



@end
