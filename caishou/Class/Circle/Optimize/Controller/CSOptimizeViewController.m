//
//  CSOptimizeViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/21.
//  Copyright © 2019年 mars. All rights reserved.
//  精选

#import "CSOptimizeViewController.h"

#import "CSArticleListModel.h"

#import "CSOptimizeNewsCell.h"

@interface CSOptimizeViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  <#define#>
 */
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)UITableView *tableView;
/**
 *  <#define#>
 */
@property(nonatomic, strong)NSMutableArray *articleArray;
@end

@implementation CSOptimizeViewController
-(NSMutableArray *)articleArray{
    if (!_articleArray) {
        _articleArray = [NSMutableArray new];
    }
    return _articleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self initTableView];//
    [self addRefresh];
//    [self loadData];
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
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10",@"articleType":@"1"}.mutableCopy;
    NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
    [paramDic addEntriesFromDictionary:locationDic];
    [CSApiManager articlePageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [self->_tableView.mj_header endRefreshing];
        [self->_tableView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSArticleListModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            if (arr.count>0) {
                if (bself.page>1) {
                    [bself.articleArray addObjectsFromArray:arr];
                }
                else{
                    bself.articleArray = arr.mutableCopy;
                }
            }
            else{
                if (bself.page>1) {
                    
                }
                else{
                    bself.articleArray = nil;
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
    _tableView.rowHeight = SIZE(120);
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[CSOptimizeNewsCell class] forCellReuseIdentifier:@"CSOptimizeNewsCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    CGFloat bottomMargin = -kTopHeight;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(bottomMargin);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.articleArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSOptimizeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSOptimizeNewsCell"];
    CSArticleListModel *model = self.articleArray[indexPath.row];
    cell.articleModel = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CSArticleListModel *activityModel = self.articleArray[indexPath.row];
    if (activityModel.isVideo) {
        [self videoPlayerWithUrl:activityModel.articleContent  placeholdImage:activityModel.img];
    }else{
        [self loadHtmlContents:activityModel.articleContent isShare:true collect:true chirleId:activityModel.ID shareContent:activityModel.articleTitle shareIcon:activityModel.img];
    }
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
