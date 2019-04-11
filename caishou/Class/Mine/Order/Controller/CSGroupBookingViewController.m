//
//  CSGroupBookingViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSGroupBookingViewController.h"

#import "CSGroupBookOrderListModel.h"

#import "CSGroupBookOrderListCell.h"

@interface CSGroupBookingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation CSGroupBookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitleStr:@""];
    self.page = 1;
    [self initTableView];
    [self addRefresh];
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
    [CSApiManager MySpellPagePageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [self->_tableView.mj_header endRefreshing];
        [self->_tableView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSGroupBookOrderListModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
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
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[CSGroupBookOrderListCell class] forCellReuseIdentifier:@"CSGroupBookOrderListCell"];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSGroupBookOrderListModel *orderModel = self.dataSource[indexPath.section];
    if ([orderModel.spellStatus isEqualToString:@"2"]) {
        //拼团成功没按钮
        return SIZE(176);
    }else{
        return SIZE(210);
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    CSGroupBookOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSGroupBookOrderListCell"];
    cell.orderModel = self.dataSource[indexPath.section];
    cell.btnClickBlock = ^(BOOL isShare, NSString * _Nonnull goodsID, NSString * _Nonnull goodsName,NSString *orderID) {
        if (isShare) {
            [bself shareWithGoodsID:goodsID goodsName:goodsName];
        }else{
            [bself cancelOrderWithOrderID:orderID];
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
    [CSApiManager DeleteSpellUserWithOrderID:orderID CallBack:^(id  _Nonnull data) {
        [Dialog toastCenter:BackMessage];
        if (ResultIsCorrect) {
            [bself.tableView.mj_header beginRefreshing];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}
//分享


- (void )shareWithGoodsID:(NSString *)goodsID goodsName:(NSString *)goodsName{
    ws(bself);
    [[Dialog Instance] showCenterProgressWithLabel:@"获取分享内容中..."];
    [CSApiManager SpellUrlWithID:goodsID CallBack:^(id  _Nonnull data) {
        [[Dialog Instance] hideProgress];
        
        if (ResultIsCorrect) {
            [Dialog toastCenter:@"已获取分享内容，\n请选择平台进行分享"];
            NSString *shareInfoUrl = [NSString stringWithFormat:@"%@",data[@"data"]];
            [bself shareWithTitle:@"莱瘦带您拼团" contents:goodsName imageName:@"logo" linkUrl:shareInfoUrl];
        }else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [[Dialog Instance] hideProgress];
        [Dialog toastCenter:@"网络错误"];
    }];
}





@end
