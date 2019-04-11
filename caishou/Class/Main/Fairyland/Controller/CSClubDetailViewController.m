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
//  CSClubDetailViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSClubDetailViewController.h"
#import "CSActivityDetailViewController.h"
#import "CSCounselorDetailController.h"
#import "CSHotActivitiesViewController.h"
#import "CSCounselorViewController.h"
#import "CSClubDesSessionHeaderModel.h"
#import "CSClubDetailInfoModel.h"

#import "CSClubDesSessionView.h"
#import "CSTopReserveTableViewCell.h"
#import "CSClubDesTableViewCell.h"
#import "CSActivityListCell.h"

#import "TYMapNavSheet.h"


@interface CSClubDetailViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate , UITableViewDataSource>
{
    UITableView *_tableView;
    SDCycleScrollView *_bannerView;
}
/** sessionHeaderArr */
@property(nonatomic , strong)NSArray *sessionHeaderArr;

@property(nonatomic, strong)CSClubDetailInfoModel *clubDetailModel;
/** array */
@property(nonatomic , strong)NSArray *activityArray;
/**
 *  <#define#>
 */
@property(nonatomic, strong)TYMapNavSheet *TYNavSheet;

@end

@implementation CSClubDetailViewController

NSString *kCSClubDesTableViewCell = @"kCSClubDesTableViewCell";
NSString *kClubDesSessionView = @"kClubDesSessionView";
NSString *kCSTopReserveTableViewCell = @"CSTopReserveTableViewCell";
NSString *kHotActivitiesTableViewCell = @"kHotActivitiesTableViewCell";

-(CSClubDetailInfoModel *)clubDetailModel{
    if (!_clubDetailModel) {
        _clubDetailModel = [CSClubDetailInfoModel new];
    }
    return _clubDetailModel;
}

- (NSArray *)sessionHeaderArr {
    if (!_sessionHeaderArr) {
        _sessionHeaderArr = [CSClubDesSessionHeaderModel loadModels];
    }
    return _sessionHeaderArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TYNavSheet = [[TYMapNavSheet alloc]init];
    [self setupUI];
    [self loadData];
}

- (void)loadData {
    ws(bself);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_group_enter(group);
        [self getHotActive:^(BOOL isSuccess) {
            if (isSuccess) {
                dispatch_group_leave(group);
            }
        }];
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        
        dispatch_group_enter(group);
        [self getClubDetails:^(BOOL isSuccess) {
            if (isSuccess) {
                dispatch_group_leave(group);
            }
        }];
//        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//
//
//        dispatch_group_enter(group);
//        [self recommendCallBack:^(BOOL isSuccess) {
//            if (isSuccess) {
//                dispatch_group_leave(group);
//            }
//        }];
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            if (!isEmptyStr(bself.clubDetailModel.logo)) {
                self->_bannerView.imageURLStringsGroup =@[bself.clubDetailModel.logo];
            }
            [self->_tableView.mj_header endRefreshing];
            [self->_tableView reloadData];
        });
    });
}

- (void)getHotActive:(void(^)(BOOL isSuccess))callBack {
    ws(bself);
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(1),@"rows":@"15",@"activityType":@(0)}.mutableCopy;
    [CSApiManager activityPageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        callBack(true);
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            bself.activityArray = [CSActivityListModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        callBack(false);
        [Dialog toastCenter:@"网络错误"];
        [self->_tableView.mj_header endRefreshing];
    }];
}

- (void )getClubDetails:(void(^)(BOOL isSuccess))callBack{
    ws(bself);
    [CSApiManager clubDetailsWithParamDic:@{@"substationId":[UDefault getObject:NowSiteId],@"id":isEmptyStr(self.clubId)?@"":self.clubId} CallBack:^(id  _Nonnull data) {
        callBack(true);
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            bself.clubDetailModel = [CSClubDetailInfoModel mj_objectWithKeyValues:data[@"data"]];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        callBack(false);
        [Dialog toastCenter:@"网络错误"];
        [self->_tableView.mj_header endRefreshing];
    }];
}

#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@""];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,0 , 0) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [tableView registerClass:[CSClubDesTableViewCell class] forCellReuseIdentifier:kCSClubDesTableViewCell];
    [tableView registerClass:[CSTopReserveTableViewCell class] forCellReuseIdentifier:kCSTopReserveTableViewCell];
    [tableView registerClass:[CSActivityListCell class] forCellReuseIdentifier:kHotActivitiesTableViewCell];
    [self.view addSubview:tableView];
    _tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [self createHeaderView];
}
- (void)createHeaderView {
    //首页轮播图没有图片的时候放一张默认图，暂时没有放
    _bannerView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) delegate:self placeholderImage:[UIImage imageNamed:@"popup_img"]];
    _bannerView.currentPageDotColor = NAV_COLOR;
    _bannerView.autoScroll = YES;
    _bannerView.backgroundColor = [UIColor whiteColor];
    _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _bannerView.imageURLStringsGroup = @[@"popup_img"];
    _tableView.tableHeaderView = _bannerView;
}
#pragma mark --SDCycleScrollViewDelete

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.clubDetailModel.counselorList.count;
    }
    return self.activityArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ws(bself);
        CSClubDesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSClubDesTableViewCell forIndexPath:indexPath];
        cell.clubDetailModel = self.clubDetailModel;
        cell.goAreaBlock = ^(NSString * _Nonnull lat, NSString * _Nonnull lng) {//导航
            NSMutableDictionary * Dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"当前位置",@"startName",self.clubDetailModel.clubName ,@"endName", nil];
            
            NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
            
            [bself.TYNavSheet ShowMapNavSheetSuperView:bself withLocationDic:Dic withstartCoor:CLLocationCoordinate2DMake([locationDic[@"lat"] doubleValue],[locationDic[@"lng"] doubleValue]) withendCoor:CLLocationCoordinate2DMake([bself.clubDetailModel.lat doubleValue],[bself.clubDetailModel.lng doubleValue])];
        };
        return cell;
    }
    if (indexPath.section == 1) {
        CSTopReserveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSTopReserveTableViewCell forIndexPath:indexPath];
        cell.clubStr = self.clubDetailModel.clubName;
        cell.index = indexPath.row;
       cell.counselorModel =  self.clubDetailModel.counselorList[indexPath.row];
        return cell;
    }
    CSActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotActivitiesTableViewCell forIndexPath:indexPath];
    cell.activityModel = self.activityArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        CSActivityListModel *model = self.activityArray[indexPath.row];
        CSActivityDetailViewController *vc = [CSActivityDetailViewController new];
        vc.activityID = model.ID;
         [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1) {
        CSCounselorDetailController *counseVc = [[CSCounselorDetailController alloc] init];
      CSCounselorPageModel *couModel =   self.clubDetailModel.counselorList[indexPath.row];
        counseVc.counselorId = couModel.ID;
        [self.navigationController pushViewController:counseVc animated:true];
    }
   
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 190;
    }
    if (indexPath.section == 1) {
        return 80;
    }
    return  SIZE(120);;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    bottomView.backgroundColor = RGB(238, 238, 238);
    return bottomView;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section ==0 || section == 1) {
        return 5;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ( section == 1|| section == 2) {
        return 30;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 ) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        return view;
    }
    CSClubDesSessionView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kClubDesSessionView];
    if (!headerView) {
        headerView = [[CSClubDesSessionView alloc] initWithReuseIdentifier:kClubDesSessionView];
    }
    headerView.moreClickBlock = ^{
        if (section == 1) {
            CSCounselorViewController *counselorVc = [[CSCounselorViewController alloc] init];
            [self.navigationController pushViewController:counselorVc animated:true];
        }else {
            CSHotActivitiesViewController *hotVc = [[CSHotActivitiesViewController alloc] init];
            [self.navigationController pushViewController:hotVc animated:true];
        }
    };
    headerView.headerModel = self.sessionHeaderArr[section - 1 > 0?section - 1:0];
    return headerView;
}



@end
