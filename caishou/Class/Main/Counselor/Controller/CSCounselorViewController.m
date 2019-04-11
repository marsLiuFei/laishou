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
//  CSCounselorViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorViewController.h"
#import "CSCounselorDetailController.h"

#import "CSCounselorPageModel.h"

#import "CSCounselorTableViewCell.h"

@interface CSCounselorViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate , UITableViewDataSource>
{
    UITableView *_tableView;
    SDCycleScrollView *_bannerView;
}
/** titleArr */
@property(nonatomic , strong)NSArray *tagTitleArr;
/** tags */
@property(nonatomic , strong)NSMutableArray *tags;

/**
 *  顾问列表
 */
@property(nonatomic, strong)NSMutableArray *counselorList;
@property(nonatomic, assign)NSInteger page;
/**
 *  当前选中的筛选类型 排序类型（1:综合;2:人气;3:会员数;4:距离）
 */
@property(nonatomic, assign)NSInteger selectedType;
@end

@implementation CSCounselorViewController

NSString *kCSCounselorTableViewCell =@"kCSCounselorTableViewCell";

-(NSArray *)tagTitleArr {
    return @[@"综合",@"按人气",@"按会员数",@"按距离"];
}
-(NSMutableArray *)counselorList{
    if (!_counselorList) {
        _counselorList = [NSMutableArray new];
    }
    return _counselorList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitleStr:@"莱瘦顾问"];
    self.selectedType = 1;
    self.page = 1;
    [self createUI];
    [self addRefresh];
    [self loadData];
}

- (void)createUI {
    [self cerateTableView];
}
- (void)cerateTableView {
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -kTopHeight ) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    if (@available(iOS 11.0,*)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        tableview.estimatedRowHeight = 0;
        tableview.estimatedSectionFooterHeight = 0;
        tableview.estimatedSectionHeaderHeight = 0;
    }
    [tableview registerClass:[CSCounselorTableViewCell class] forCellReuseIdentifier:kCSCounselorTableViewCell];
    [self.view addSubview:tableview];
    _tableView = tableview;
    [self createHeaderView];
}

- (void)createHeaderView {
    //首页轮播图没有图片的时候放一张默认图，暂时没有放
    _bannerView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.5) delegate:self placeholderImage:[UIImage imageNamed:@"popup_img"]];
    _bannerView.currentPageDotColor = NAV_COLOR;
    _bannerView.autoScroll = YES;
    _bannerView.backgroundColor = [UIColor whiteColor];
    _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    NSString *posterImageName = isEmptyStr([CSCommonHelper Instance].CounselorPagePosterModel.advUrl)?@"":[CSCommonHelper Instance].CounselorPagePosterModel.advUrl;
    _bannerView.imageURLStringsGroup = @[posterImageName];
    _tableView.tableHeaderView = _bannerView;
}
- (UIView *)createSessionHeaderView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    headView.backgroundColor = [UIColor whiteColor];
    self.tags = [NSMutableArray arrayWithCapacity:self.tagTitleArr.count];
    __block CGFloat  space = 10;
    for (int i = 0; i < self.tagTitleArr.count; i++) {
        UIButton *button = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:self.tagTitleArr[i] titleColor:RGB(102, 102, 102) font:[UIFont fontWithName:@"PingFangSC-Regular" size: 14] backgroundColor:[UIColor clearColor] touchUpInsideEvent:nil];
        if (i == self.selectedType-1) {
            button.selected = true;
            button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 14];
        }
        button.tag = i+1;
        [button setTitleColor:RGB(53, 60, 54) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
         CGFloat width = [ZYQTool ZYQ_returnWidthAccordingText:self.tagTitleArr[i] font: button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 14] height:21] + 5;
            make.left.mas_equalTo(space);
            make.bottom.mas_equalTo(-5);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(width);
            space = space + width  + 10;
        }];
        [self.tags addObject:button];
    }
    return headView;
}
#pragma mark - loadData


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
    [[Dialog Instance] showCenterProgressWithLabel:@""];
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10",@"orderType":@(self.selectedType),@"counselorName":@""}.mutableCopy;
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

#pragma mark - click
- (void)tagBtnClick:(UIButton *)sender {
    for (UIButton * button in self.tags) {
        button.selected = false;
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    }
    sender.selected = true;
    sender.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 14];;
    self.selectedType = sender.tag;
    [_tableView.mj_header beginRefreshing];
}

#pragma mark --SDCycleScrollViewDelete

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (index ==0) {
        if (!isEmptyStr([CSCommonHelper Instance].CounselorPagePosterModel.url)) {
              [self loadUrl:[CSCommonHelper Instance].CounselorPagePosterModel.url];
        }
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.counselorList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSCounselorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSCounselorTableViewCell forIndexPath:indexPath];
    [cell setCounselorPageModel:self.counselorList[indexPath.row] index:indexPath.row+1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CSCounselorDetailController *counseVc = [[CSCounselorDetailController alloc] init];
    CSCounselorPageModel *counselorListModel = self.counselorList[indexPath.row];
    counseVc.counselorId = counselorListModel.ID;
    [self.navigationController pushViewController:counseVc animated:true];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createSessionHeaderView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


@end
