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
//  CSSignActivityViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSignActivityViewController.h"
#import "CSActivityDetailViewController.h"


#import "CSActivityListModel.h"

#import "CSHotOptionModel.h"
#import "CSActivityListCell.h"


@interface CSSignActivityViewController ()<UITableViewDelegate , UITableViewDataSource>
/** tabelview */
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *activityArray;

@end

@implementation CSSignActivityViewController


NSString *kSignHotActivitiesCell = @"kSignHotActivitiesCell";
-(NSMutableArray *)activityArray{
    if (!_activityArray) {
        _activityArray = [NSMutableArray new];
    }
    return _activityArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self setupUI];
    [self addRefresh];
    
    [[Dialog Instance] showCenterProgressWithLabel:@""];
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
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10",@"activityType":@(0)}.mutableCopy;
    //    NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
    //    [paramDic addEntriesFromDictionary:locationDic];
    [CSApiManager activityPageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [[Dialog Instance] hideProgress];
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
        [[Dialog Instance] hideProgress];
        [Dialog toastCenter:@"网络错误"];
        [self->_tableView.mj_header endRefreshing];
        [self->_tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@"活动"];
    [self createTabelView];
}
- (void)createTabelView {
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[CSActivityListCell class] forCellReuseIdentifier:kSignHotActivitiesCell];
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    _tableView = tableview;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activityArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:kSignHotActivitiesCell forIndexPath:indexPath];
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
