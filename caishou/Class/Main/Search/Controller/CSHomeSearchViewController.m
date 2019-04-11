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
//  CSHomeSearchViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHomeSearchViewController.h"
#import "CSCounselorPageModel.h"
#import "CSCounselorTableViewCell.h"
#import "CSCounselorDetailController.h"

@interface CSHomeSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic , strong)UITableView *tableView;
/**
 *  顾问列表
 */
@property(nonatomic, strong)NSMutableArray *counselorList;
@property(nonatomic, assign)NSInteger page;
/** searchStr */
@property(nonatomic , strong)NSString *searchStr;



@end

@implementation CSHomeSearchViewController

NSString *kSearchCounselorTableViewCell =@"kSearchCounselorTableViewCell";


-(NSMutableArray *)counselorList{
    if (!_counselorList) {
        _counselorList = [NSMutableArray new];
    }
    return _counselorList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.page = 1;
    [self addRefresh];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:false];
}
- (void)createUI {
//    self.hideHotSearch = YES;
    self.searchInputFont = [UIFont systemFontOfSize:15];
    self.hotType = TFSearchHotStyleRoundTag;
    self.historyStyleType = TFSearchHistoryStyleColorfulTag;
    self.hotArr = @[@"余小丽" ,@"李明",@"黄建"];
    
    [self creatTableView];
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, self.view.frame.size.width, self.view.frame.size.height - kTopHeight) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.hidden = YES;
    [_tableView registerClass:[CSCounselorTableViewCell class] forCellReuseIdentifier:kSearchCounselorTableViewCell];
    [self.view addSubview:_tableView];
   
    
}

-(void)TF_startSearchWithTitle:(NSString *)searchText {
    self.searchStr = searchText;
    [self loadData];
    
}


- (void)TF_searchStrDidChange:(NSString *)searchText {
    NSLog(@"searchText = %@" , searchText);
    if ([searchText isEqualToString:@""]) {
        _tableView.hidden = YES;
    }else {
        _tableView.hidden = NO;
    }
}

#pragma mark -  加载数据
- (void )addRefresh{
    ws(bself);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 1;
        [bself loadData];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself loadData];
    }];
}
- (void)loadData {
    ws(bself);
    [[Dialog Instance] showCenterProgressWithLabel:@""];
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10",@"orderType":@(0),@"counselorName":self.searchStr}.mutableCopy;
    NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
    [paramDic addEntriesFromDictionary:locationDic];
    [CSApiManager counselorPageeWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [[Dialog Instance] hideProgress];
        [self->_tableView.mj_header endRefreshing];
        [self->_tableView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSCounselorPageModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            if (arr.count>0) {
                if (bself.page>1) {
                    [bself.counselorList addObjectsFromArray:arr];
                }
                else{
                    bself.counselorList = arr.mutableCopy;
                }
            }
            else{
                if (bself.page>1) {
                    
                }
                else{
                    bself.counselorList = nil;
                }
            }
            [self->_tableView reloadData];
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.counselorList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSCounselorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCounselorTableViewCell forIndexPath:indexPath];
    [cell setCounselorPageModel:self.counselorList[indexPath.row] index:indexPath.row+1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CSCounselorDetailController *counseVc = [[CSCounselorDetailController alloc] init];
    CSCounselorPageModel *counselorListModel = self.counselorList[indexPath.row];
    counseVc.counselorId = counselorListModel.ID;
    [self.navigationController pushViewController:counseVc animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SIZE(80);
}


@end
