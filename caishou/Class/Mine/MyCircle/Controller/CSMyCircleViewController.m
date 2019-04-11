//
//  CSMyCircleViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMyCircleViewController.h"
#import "CSEditMyCircleContentsViewController.h"

#import "CSMyCircleModel.h"

#import "CSMyCircleListCell.h"

@interface CSMyCircleViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *circleModelArray;
@end

@implementation CSMyCircleViewController

-(NSMutableArray *)circleModelArray{
    if (!_circleModelArray) {
        _circleModelArray = [NSMutableArray new];
    }
    return _circleModelArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitleStr:@"我的圈子"];
    [self initTableView];
    
    
    UIButton *rightBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(45), SIZE(45)) normalImage:@"edit_icon" selectedImage:@"edit_icon" touchUpInsideEvent:nil];
    [rightBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    [self addRefresh];
}
- (void )editBtnClick{
    ws(bslef);
    CSEditMyCircleContentsViewController *vc = [CSEditMyCircleContentsViewController new];
    vc.needRefreshBlock = ^{
        [bslef.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:vc animated:YES];
}



- (void )addRefresh{
    ws(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 1;
        [bself loadData];
    }];
    [_tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself loadData];
    }];
}
- (void)loadData {
    ws(bself);
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10"}.mutableCopy;
    [CSApiManager PhotoPageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSMyCircleModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            if (arr.count>0) {
                if (bself.page>1) {
                    [bself.circleModelArray addObjectsFromArray:arr];
                }
                else{
                    bself.circleModelArray = arr.mutableCopy;
                }
            }
            else{
                if (bself.page>1) {
                    
                }
                else{
                    bself.circleModelArray = nil;
                }
            }
            [bself.tableView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
    }];
}







- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[CSMyCircleListCell class] forCellReuseIdentifier:@"CSMyCircleListCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view.safeAreaInsets);
        }else{
            make.edges.equalTo(self.view);
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.circleModelArray.count;
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
    CSMyCircleModel *_circleModel = self.circleModelArray[indexPath.section];
    return _circleModel.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    CSMyCircleListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSMyCircleListCell"];
    cell.circleModel = self.circleModelArray[indexPath.section];
    cell.clickImageBlock = ^(NSInteger index, NSArray * _Nonnull subViews, NSArray * _Nonnull imageArray) {
        [bself post:index subviews:subViews arr:imageArray];
    };
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
