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
//  CSHotActivitiesViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHotActivitiesViewController.h"
#import "CSActivityDetailViewController.h"

#import "CSActivityListModel.h"

#import "CSHotHeaderView.h"
#import "CSHotOptionModel.h"
#import "CSActivityListCell.h"


@interface CSHotActivitiesViewController ()<UITableViewDelegate , UITableViewDataSource>
/** tabelview */
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic, assign)NSInteger page;
/**
 *  活动类型（1:毅行;2:公益;3:聚会;4:培训;5:旅游;6:运动;7:美容;8:才艺;9:电影;0:全部）
 */
@property(nonatomic, assign)NSInteger activityType;
@property(nonatomic, strong)NSMutableArray *activityArray;
@end

@implementation CSHotActivitiesViewController

NSString *kCSHotActivitiesTableViewCell = @"kCSHotActivitiesTableViewCell";
-(NSMutableArray *)activityArray{
    if (!_activityArray) {
        _activityArray = [NSMutableArray new];
    }
    return _activityArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityType = 0;
    self.page = 1;
    [self setupUI];
    [self addRefresh];
    [self loadData];
}

- (void )addRefresh{
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
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10",@"activityType":@(self.activityType)}.mutableCopy;
//    NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
//    [paramDic addEntriesFromDictionary:locationDic];
    [CSApiManager activityPageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [self->_tableView.mj_header endRefreshing];
        [self->_tableView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSActivityListModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            if (arr.count>0) {
                if (bself.page>1) {
                    [bself.activityArray addObjectsFromArray:arr];
                }
                else{
                    bself.activityArray = arr.mutableCopy;
                }
            }
            else{
                if (bself.page>1) {
                    
                }
                else{
                    bself.activityArray = nil;
                }
            }
            [bself.tableView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
        [self->_tableView.mj_header endRefreshing];
        [self->_tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@"热门活动"];
    self.view.backgroundColor = [UIColor greenColor];
    [self createTabelView];
    [self createTopView];
}
- (void)createTabelView {
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[CSActivityListCell class] forCellReuseIdentifier:kCSHotActivitiesTableViewCell];
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    _tableView = tableview;
}
- (void)createTopView {
    ws(bself);
    CGFloat height = (SCREEN_WIDTH / 5 + 10) * 4;
    CSHotHeaderView *headerView = [[CSHotHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    headerView.optionsModels = [CSHotOptionModel loadDatas];
    headerView.bannerClick = ^(NSString * _Nonnull jumpUrl) {
        [bself loadUrl:jumpUrl];
    };
    headerView.selectOptionBlock = ^(NSInteger index, CSHotOptionModel * _Nonnull optionModel) {
        bself.activityType = index+1;
        if (index==9) {
            bself.activityType = 0;
        }
        [bself.tableView.mj_header beginRefreshing ];
    };
    _tableView.tableHeaderView = headerView;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activityArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSHotActivitiesTableViewCell forIndexPath:indexPath];
    CSActivityListModel *model = self.activityArray[indexPath.row];
    cell.activityModel = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SIZE(120);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CSActivityListModel *model = self.activityArray[indexPath.row];
    CSActivityDetailViewController *vc = [CSActivityDetailViewController new];
    vc.activityID = model.ID;
    vc.activityImageUrl = model.img;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
