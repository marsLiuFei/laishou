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
//  CSPKViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSPKViewController.h"
#import "CSChangeFriendViewController.h"
#import "CSPKHeaderView.h"
#import "CSPKDataTableViewCell.h"
#import "CSWeightRecordTableViewCell.h"
#import "CSWalkRecordTableViewCell.h"
#import "ZYQHealthManager.h"
#import "NSDate+HKDate.h"
#import "CSBeleaguerRecordCell.h"
#import "CSPKInfoModel.h"
#import "CSShareDatePickView.h"
#import "CSLoginViewController.h"

@interface CSPKViewController ()<UITableViewDelegate , UITableViewDataSource>
/** tableView */
@property(nonatomic , strong)UITableView *tableView;
/** pkInfo */
@property(nonatomic , strong)CSPKInfoModel *infoModel;
/** headerView */
@property(nonatomic , strong)CSPKHeaderView *headerView;



@end

@implementation CSPKViewController

NSString *kCSPKDataTableViewCell = @"kCSPKDataTableViewCell";
NSString *kCSWeightRecordTableViewCell = @"kCSWeightRecordTableViewCell";
NSString *kCSWalkRecordTableViewCell = @"kCSWalkRecordTableViewCell";
NSString *kCSBeleaguerRecordCell = @"kCSBeleaguerRecordCell";

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getStepCount];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!ISLOGIN) {
        CSLoginViewController *vc = [CSLoginViewController new];
        vc.isFromPk = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [self setupUI];
    [self loadData];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:WhiteColor};
    self.navigationController.navigationBar.tintColor = WhiteColor;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationController.navigationBar.barTintColor = WhiteColor;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@""];
    [self initTableView];
    [self setupHeaderView];
    [self setupFooterView];
   
}
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,0, 0) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[CSPKDataTableViewCell class] forCellReuseIdentifier:kCSPKDataTableViewCell];
    [_tableView registerClass:[CSWeightRecordTableViewCell class] forCellReuseIdentifier:kCSWeightRecordTableViewCell];
    [_tableView registerClass:[CSWalkRecordTableViewCell class] forCellReuseIdentifier:kCSWalkRecordTableViewCell];
    [_tableView registerClass:[CSBeleaguerRecordCell class] forCellReuseIdentifier:kCSBeleaguerRecordCell];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(-kTopHeight);
        make.left.right.bottom.offset(0);
    }];
}

- (void)setupHeaderView {
    CSPKHeaderView *headerView = [[CSPKHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(250))];
    self.headerView = headerView;
    _tableView.tableHeaderView = headerView;
}
- (void)setupFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(8))];
    footerView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.tableFooterView = footerView;
}
#pragma mark - loadData
- (void)loadData {
    self.pkuser = @"29f1bdb2-2101-4caa-92eb-4ca2a5a08470";
    if (isEmptyStr(self.pkuser)) {
        [CSApiManager userPkWithId:self.pkuser InfoCallBack:^(id  _Nonnull data) {
            MYLog(@"%@",data);
             if (ResultIsCorrect) {
                 [self loadPkData];
            }
//            [Dialog toastCenter:BackMessage];
        } fail:^(NSError * _Nonnull error) {
            [Dialog toastCenter:@"网络错误"];
        }];
    }
    
    [self loadPkData];
}
- (void)loadPkData {
      ws(bself);
    [CSApiManager myPkInfoCallBack:^(id  _Nonnull data) {
        MYLog(@"%@",data);
        if (ResultIsCorrect) {
            bself.infoModel = [CSPKInfoModel mj_objectWithKeyValues:data[@"data"]];
            bself.headerView.myInfo = bself.infoModel.myInfo;
            [bself.tableView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
        [bself.tableView reloadData];
        
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}
#pragma mark - getStepCount
-(void)getStepCount {
    if ([ZYQHealthManager ZYQ_isHealthDataAvailable]) {
        [ZYQHealthManager ZYQ_authorizeHealthKitWithType:ZYQQuantityTypeStep
                                                  result:^(BOOL isAuthorizateSuccess, NSError *error) {
                                                      NSLog(@" success = %d,error =  %@" , isAuthorizateSuccess , error);
                                                      if (isAuthorizateSuccess) {
                                                          [ZYQHealthManager ZYQ_getAllStepCount:^(NSUInteger stepCount) {
                                                              [self saveStepCount:stepCount];
                                                              NSLog(@"stepCount = %ld" , stepCount);
                                                          }];
                                                      }
                                                      
                                                  }];
    }
    
}
- (void)saveStepCount:(NSInteger)stepCount {
    NSDictionary *dic =  [UDefault getValue:@"health"];
    NSString *key = [NSDate HK_getNewTimeFormat:@"yyyy-MM-dd" date:[NSDate HK_dateAfterDate:[NSDate date] day:-1]];
    NSNumber * count = @(0);
    if (![dic isEqual:@""]) {
        count = dic[key];
    }
    if ([count integerValue] != 0) {
        NSDictionary *dic = @{key:count,[NSDate HK_getNewTimeFormat:@"yyyy-MM-dd" date:[NSDate date]]:@(stepCount)};
        [UDefault setValue:dic keys:@"health"];
    }else {
        NSDictionary *dic = @{[NSDate HK_getNewTimeFormat:@"yyyy-MM-dd" date:[NSDate date]]:@(stepCount)};
        [UDefault setValue:dic keys:@"health"];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    if (indexPath.section == 0) {
        CSPKDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSPKDataTableViewCell forIndexPath:indexPath];
        cell.pkInfoModel = self.infoModel;
        cell.PKClickBlock = ^{
//            CSChangeFriendViewController *changeVc = [[CSChangeFriendViewController alloc] init];
//            [self.navigationController pushViewController:changeVc animated:true];
            //分享按钮，找好友pk
            CSShareDatePickView *pickView = [CSShareDatePickView new];
            pickView.pickerBlock = ^(NSString * _Nonnull resultStr) {
                MYLog(@"%@",resultStr);
                [bself SharePkWithDayNumber:resultStr];
            };
            [pickView showInView:[UIApplication sharedApplication].keyWindow];
        };
        return cell;
    }
    if (indexPath.section == 1) {
        CSWeightRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSWeightRecordTableViewCell forIndexPath:indexPath];
        cell.myInfo = self.infoModel.myInfo;
         return cell;
    }
    if (indexPath.section == 2) {
        CSWalkRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSWalkRecordTableViewCell forIndexPath:indexPath];
        return cell;
    }
    CSBeleaguerRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSBeleaguerRecordCell forIndexPath:indexPath];
    cell.pkInfoModel = self.infoModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SIZE(330);
    }
    if (indexPath.section == 1) {
        return SIZE(124);
    }
    if (indexPath.section == 2) {
        return SIZE(89);
    }
    return SIZE(127);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(8))];
    view.backgroundColor = NORMAL_BGCOLOR;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE(8);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}



#pragma mark -- 获取分享pk链接
- (void )SharePkWithDayNumber:(NSString *)dayNumer{
    ws(bself);
    [CSApiManager SharePKWithDayNumber:dayNumer CallBack:^(id  _Nonnull data) {
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            [bself shareWithTitle:@"邀请你来pk莱瘦" contents:@"点击前往莱瘦app应用程序pk" imageName:@"showLogo" linkUrl:[NSString stringWithFormat:@"%@",data[@"data"]]];
        }else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}

@end
