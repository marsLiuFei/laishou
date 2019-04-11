//
//  CSActivityOrderViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSActivityOrderViewController.h"
#import "CSActivityDetailViewController.h"


#import "CSActivityOrderListModel.h"

#import "CSActivityOrderListCell.h"

@interface CSActivityOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation CSActivityOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitleStr:@""];
    self.page = 1;
    [self initTableView];
    [self addRefresh];
    
    [NSNotic_Center addObserver:self selector:@selector(needRefresh) name:OrderPaySuccess object:nil];
    
}
//订单支付成功后刷新页面
- (void )needRefresh{
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark -- 数据请求
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
- (void )addRefresh{
    ws(bself);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 1;
        [bself loadData];
    }];
        [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself loadData];
    }];
}
- (void)loadData {
    ws(bself);
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10"}.mutableCopy;
    [CSApiManager myActivityPageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [self->_tableView.mj_header endRefreshing];
        [self->_tableView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSActivityOrderListModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            if (arr.count>0) {
                if (bself.page>1) {
                    [bself.dataSource addObjectsFromArray:arr];
                }
                else{
                    bself.dataSource = arr.mutableCopy;
                }
            }
            else{
                if (bself.page>1) {
                    
                }
                else{
                    bself.dataSource = nil;
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

- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = SIZE(210);
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
     [_tableView registerClass:[CSActivityOrderListCell class] forCellReuseIdentifier:@"CSActivityOrderListCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.mas_equalTo(-kStatusBarHeight + 5);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE(10);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    CSActivityOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSActivityOrderListCell"];
    CSActivityOrderListModel *order = self.dataSource[indexPath.section];
    cell.order = order;
    cell.btnClickBlock = ^(BOOL isCancelBtn, NSString * _Nonnull orderID, BOOL isNeedPay) {
        if (isCancelBtn) {
            //取消订单
            [bself cancelOrderWithOrderID:orderID];
        }else{
            if (isNeedPay) {
                //去支付
                CSActivityDetailViewController *vc = [CSActivityDetailViewController new];
                vc.activityID = order.activityId;
                vc.isNeedPay = YES;
                vc.orderID = order.ID;
                vc.activityImageUrl = order.img;
                [bself.navigationController pushViewController:vc animated:YES];
            }
            else{
                //联系客服
                [bself callForServiceWithMobile:order.clubPhone];
            }
        }
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//取消订单
- (void )cancelOrderWithOrderID:(NSString *)orderID{
    ws(bself);
    [CSApiManager DeleteActivityWithOrderID:orderID CallBack:^(id  _Nonnull data) {
        [Dialog toastCenter:BackMessage];
        if (ResultIsCorrect) {
            [bself.tableView.mj_header beginRefreshing];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}

//拨打电话
- (void )callForServiceWithMobile:(NSString *)mobile{
    if (isEmptyStr(mobile)) {
        [Dialog toastCenter:@"暂无号码"];
        return;
    }
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",mobile];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}


@end
