//
//  CSBaseMainViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseMainViewController.h"
#import "CSLoginViewController.h"
#import "CSCounselorDetailController.h"
#import "CSClubDetailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CSAreaViewController.h"
#import "CSScanCodeViewController.h"//扫码功能
#import "CSHomeSearchViewController.h"//搜索功能

#import "CSHomeSessionHeaderModel.h"
#import "CSSiteModel.h"
#import "CSModuleModel.h"
#import "CSClubListModel.h"
#import "CSCounselorListModel.h"

#import "CSHomeNavView.h"
#import "CSHomeSessionHeaderView.h"
#import "CSHomeHeaderView.h"
#import "CSModuleViewCell.h"
#import "CSAdvertisingCell.h"
#import "CSClubCell.h"
#import "CSCounselorCell.h"
#import "CSExampleTableViewCell.h"
#import "CSHotRecommondCell.h"
#import "CSArticleListModel.h"



@interface CSBaseMainViewController ()<CLLocationManagerDelegate,UITableViewDelegate , UITableViewDataSource>
/** tableView */
@property(nonatomic , strong)UITableView *tableView;

/** moduleArr */
@property(nonatomic , strong)NSArray *moduleArr;
/** sessionHeaderArr */
@property(nonatomic , strong)NSArray *sessionHeaderArr;
/**
 *  定位服务
 */
@property(nonatomic, strong) CLLocationManager *locationmanager;
/**
 *  自定义导航栏
 */
@property(nonatomic, strong)CSHomeNavView *navView;
/**
 *  当前站点模型
 */
@property(nonatomic, strong)CSSiteModel *nowSiteModel;
/**
 *  站点信息列表
 */
@property(nonatomic, strong)NSMutableArray *siteArray;
@property(nonatomic, assign)double lat;//经度
@property(nonatomic, assign)double lng;//纬度
//广告位图片
@property(nonatomic, strong)NSMutableArray *activityImages;
@property(nonatomic, strong)CSHomeHeaderView *headerView;
/** 推荐俱乐部 */
@property(nonatomic , strong)NSMutableArray *clubList;
/** 推荐顾问 */
@property(nonatomic , strong)NSMutableArray *counselorList;
//当前加入减肥俱乐部的成员数
@property(nonatomic, strong)NSString *nowJoinCount;

/** 文章数组 */
@property(nonatomic , strong)NSArray *articleArray;


@end

@implementation CSBaseMainViewController

NSString *kModuleCell = @"kModuleCell";
NSString *kAdvertisingCell = @"kAdvertisingCell";
NSString *kSessionHeaderView = @"kSessionHeaderView";
NSString *kCSClubCell = @"kCSClubCell";
NSString *kCSCounselorCell =@"kCSCounselorCell";
NSString *kCSExampleTableViewCell =@"kCSExampleTableViewCell";
NSString *kCSHotRecommondCell = @"kCSHotRecommondCell";
-(NSMutableArray *)clubList{
    if (!_clubList) {
        _clubList = [NSMutableArray new];
    }
    return _clubList;
}
-(NSMutableArray *)counselorList{
    if (!_counselorList) {
        _counselorList = [NSMutableArray new];
    }
    return _counselorList;
}
-(NSMutableArray *)activityImages{
    if (!_activityImages) {
        _activityImages = [NSMutableArray new];
    }
    return _activityImages;
}
-(CSSiteModel *)nowSiteModel{
    if (!_nowSiteModel) {
        _nowSiteModel = [CSSiteModel new];
    }
    return _nowSiteModel;
}
-(NSMutableArray *)siteArray{
    if (!_siteArray) {
        _siteArray = [NSMutableArray new];
    }
    return _siteArray;
}

#pragma mark -- 定位相关
-(void)getLocation
{
    [UDefault setValue:@{} keys:NowLocationDic];
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationmanager = [[CLLocationManager alloc]init];
        self.locationmanager.delegate = self;
        [self.locationmanager requestAlwaysAuthorization];
        [self.locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationmanager.distanceFilter = 5.0;
        [self.locationmanager startUpdatingLocation];
    }
}
#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    self.lat = currentLocation.coordinate.latitude;
    self.lng = currentLocation.coordinate.longitude;
    
    NSDictionary *locationDic = @{@"lat":@(self.lat),@"lng":@(self.lng)};
    [UDefault setValue:locationDic keys:NowLocationDic];
    
    [self getStoreInfoListWithlng:currentLocation.coordinate.longitude lat:currentLocation.coordinate.latitude];
    
    [self.locationmanager stopUpdatingLocation];
    
//    //反地理编码
//    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
//    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (placemarks.count > 0) {
//            CLPlacemark *placeMark = placemarks[0];
//            currentCity = placeMark.locality;
//            if (!currentCity) {
//                currentCity = @"无法定位当前城市";
//            }
//
//            /*看需求定义一个全局变量来接收赋值*/
//            NSLog(@"----%@",placeMark.country);//当前国家
//            NSLog(@"%@",currentCity);//当前的城市
//            //            NSLog(@"%@",placeMark.subLocality);//当前的位置
//            //            NSLog(@"%@",placeMark.thoroughfare);//当前街道
//            //            NSLog(@"%@",placeMark.name);//具体地址
//
//        }
//    }];
    
}
//通过经纬度获取当前站点信息列表
- (void )getStoreInfoListWithlng:(double )lng lat:(double )lat{
    ws(bself);
    [CSApiManager locationWithParamDic:@{@"lng":@(lng),@"lat":@(lat)} CallBack:^(id  _Nonnull data) {
        MYLog(@"%@",data);
        if (ResultIsCorrect) {
            NSDictionary *dic = data[@"data"];
            bself.nowJoinCount = [NSString stringWithFormat:@"%@",dic[@"userNumber"]];
            bself.nowSiteModel = [CSSiteModel mj_objectWithKeyValues:dic];
            bself.navView.siteStr = bself.nowSiteModel.name;
            [UDefault setObject:[NSString stringWithFormat:@"%@",bself.nowSiteModel.ID] keys:NowSiteId];//设置当前的分站ID
            [bself.tableView.mj_header beginRefreshing];
        }
        else{
            [Dialog toastCenter:@"网络错误"];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}





- (NSArray *)moduleArr {
    if (!_moduleArr) {
        _moduleArr = [CSModuleModel loadModels];
    }
    return _moduleArr;
}
- (NSArray *)sessionHeaderArr {
    if (!_sessionHeaderArr) {
        _sessionHeaderArr = [CSHomeSessionHeaderModel loadModels];
    }
    return _sessionHeaderArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [Dialog simpleToast:@"加载中..."];
     [self.navigationController setNavigationBarHidden:true animated:false];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:false];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.lng = 0.0f;
    self.lat = 0.0f;
    [UDefault setObject:@"4554081b-aa46-48d4-a5f9-0472a38a6f5f" keys:NowSiteId];//设置当前的分站ID 
//    [Dialog Instance].isSigned = NO;
    self.nowJoinCount = @"0";
    [self getLocation];
    [self setupUI];
    [self addRefresh];
    [NSNotic_Center addObserver:self selector:@selector(needFresh) name:LOGINSUCCESS object:nil];
}

- (void )needFresh{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - loadData
- (void )addRefresh{
    ws(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself loadData];
//        if (ISLOGIN) {
//            //如果登录的话，请求查看当前是否已经签到过
//            [bself getDayIsSignStatus];
//        }
    }];
}
- (void)loadData {
    ws(bself);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_group_enter(group);
        [self substationListCallBack:^(BOOL isSuccess) {
            if (isSuccess) {
                dispatch_group_leave(group);
            }
        }];
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        
        dispatch_group_enter(group);
        [self advListCallBack:^(BOOL isSuccess) {
            if (isSuccess) {
                dispatch_group_leave(group);
            }
        }];
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        
        dispatch_group_enter(group);
        [self recommendCallBack:^(BOOL isSuccess) {
            if (isSuccess) {
                dispatch_group_leave(group);
            }
        }];
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        
        dispatch_group_enter(group);
        [self loadArticleCallBack:^(BOOL isSuccess) {
            if (isSuccess) {
                dispatch_group_leave(group);
            }
        }];
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [bself.tableView.mj_header endRefreshing];
            [bself.tableView reloadData];
        });
    });
}
#pragma mark -- 获取所有站点信息列表
- (void )substationListCallBack:(void(^)(BOOL isSuccess))callBack{
    ws(bself);
    [CSApiManager substationListCallBack:^(id  _Nonnull data) {
        callBack(YES);
        if (ResultIsCorrect) {
            
            bself.siteArray = [CSSiteModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        callBack(NO);
        [bself.tableView.mj_header endRefreshing];
        [Dialog toastCenter:@"网络错误"];
    }];
}
#pragma mark -- 获取首页广告列表
- (void )advListCallBack:(void(^)(BOOL isSuccess))callBack{
    ws(bself);
    NSString *nowSiteId = [UDefault getObject:NowSiteId];
    [CSApiManager advListWithSubstationId:isEmptyStr(nowSiteId)?@"":nowSiteId CallBack:^(id  _Nonnull data) {
        callBack(YES);
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            bself.activityImages = [CSBannerModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            NSMutableArray *arrM = [NSMutableArray new];
//            1:首页顶部，2：中间广告大图，3/4：中间小图，5：俱乐部顶部图片，6：顾问顶部图片，7：活动，8-莱购
            for (CSBannerModel *bannerImageModel in bself.activityImages) {
                if ([bannerImageModel.advType isEqualToString:@"1"]) {
                    [arrM addObject:bannerImageModel];
                }
                if ([bannerImageModel.advType isEqualToString:@"5"]) {
//                    [UDefault setObject:bannerImageModel.advUrl keys:ClubPagePosterImgDic];
//                    [UDefault setValue:bannerImageModel keys:ClubPagePosterImgDic];
                    
                    [CSCommonHelper Instance].ClubPagePosterPoster = bannerImageModel;
                }
                if ([bannerImageModel.advType isEqualToString:@"6"]) {
//                    [UDefault setObject:bannerImageModel.advUrl keys:CounselorPagePosterImg];
                    [CSCommonHelper Instance].CounselorPagePosterModel = bannerImageModel;
                }
                if ([bannerImageModel.advType isEqualToString:@"7"]) {
//                    [UDefault setObject:bannerImageModel.advUrl keys:ActivityPosterImg];
                    [CSCommonHelper Instance].ActivityPosterModel = bannerImageModel;
                }
                if ([bannerImageModel.advType isEqualToString:@"8"]) {
//                    [UDefault setObject:bannerImageModel.advUrl keys:FitPosterImg];
                    [CSCommonHelper Instance].FitPosterModel = bannerImageModel;
                }
            }
            self.headerView.models = arrM;
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        callBack(NO);
        [bself.tableView.mj_header endRefreshing];
        [Dialog toastCenter:@"网络错误"];
    }];
}
#pragma mark -- 获取首页推广列表
- (void )recommendCallBack:(void(^)(BOOL isSuccess))callBack{
    ws(bself);
    NSString *nowSiteId = [UDefault getObject:NowSiteId];
    NSDictionary *paramDic = @{
                               @"substationId":isEmptyStr(nowSiteId)?@"":nowSiteId,
                               @"lng":@(self.lng),
                               @"lat":@(self.lat)
                               };
    [CSApiManager recommendWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        callBack(YES);
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            bself.clubList = [CSClubListModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"clubList"]];
            bself.counselorList = [CSCounselorListModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"counselorList"]];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        callBack(NO);
        [bself.tableView.mj_header endRefreshing];
        [Dialog toastCenter:@"网络错误"];
    }];
}
#pragma mark - 获取活动数据
- (void)loadArticleCallBack:(void(^)(BOOL isSuccess))callBack {
    ws(bself);
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(1),@"rows":@"4",@"articleType":@"1"}.mutableCopy;
    NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
    if (!isEmptyDic(locationDic)) {
         [paramDic addEntriesFromDictionary:locationDic];
    }
    [CSApiManager articlePageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
           callBack(YES);
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSArticleListModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            bself.articleArray = arr;
            [bself.tableView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        callBack(NO);
        [bself.tableView.mj_header endRefreshing];
        [Dialog toastCenter:@"网络错误"];
    }];
}
////查看当前是否已经签到
//- (void )getDayIsSignStatus{
//    [CSApiManager getDayIsSignStatusCallBack:^(id  _Nonnull data) {
//        if (ResultIsCorrect) {
//            [Dialog Instance].isSigned = [data[@"data"] boolValue];
//        }
//    } fail:^(NSError * _Nonnull error) {
//
//    }];
//}

#pragma mark - 设置UI
- (void)setupUI {
    [self setupTableView];
    [self setTopView];
    
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+kStatusBarHeight ,SCREEN_WIDTH, SCREEN_HEIGHT-44-kStatusBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = false;
    [self.tableView registerClass:[CSModuleViewCell class] forCellReuseIdentifier:kModuleCell];
    [self.tableView registerClass:[CSAdvertisingCell class] forCellReuseIdentifier:kAdvertisingCell];
    [self.tableView registerClass:[CSClubCell class] forCellReuseIdentifier:kCSClubCell];
    [self.tableView registerClass:[CSCounselorCell class] forCellReuseIdentifier:kCSCounselorCell];
    [self.tableView registerClass:[CSExampleTableViewCell class] forCellReuseIdentifier:kCSExampleTableViewCell];
    [self.tableView registerClass:[CSHotRecommondCell class] forCellReuseIdentifier:kCSHotRecommondCell];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    
}
- (void)setTopView {
    ws(bself);
    self.navView = [[CSHomeNavView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44 + kStatusBarHeight)];
    self.navView.backgroundColor = RGB(67, 207, 124);
    self.navView.chooseSiteBtnClickBlock = ^(NSInteger index) {
        if (!ISLOGIN) {
            [bself.navigationController pushViewController:[NSClassFromString(@"CSLoginViewController") new] animated:YES];
            return;
        }
        switch (index) {
            case 0:
                //选择分站
            {
                CSAreaViewController *vc = [CSAreaViewController new];
                vc.siteArray = bself.siteArray;
                vc.selectedSiteModeBlock = ^(CSSiteModel * _Nonnull siteModel) {
                    [UDefault setValue:siteModel.ID keys:NowSiteId];
                    bself.navView.siteStr = siteModel.name;
                    [bself.tableView.mj_header beginRefreshing];
                };
                [bself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
                //扫码
            {
                CSScanCodeViewController *vc = [CSScanCodeViewController new];
                vc.needFreshBlock = ^{
                    //绑定顾问、俱乐部成功
                    [bself.tableView.mj_header beginRefreshing];
                };
                [bself.navigationController pushViewController:vc animated:YES];
            }
            break;
            case 2:
                //搜索
            {
                CSHomeSearchViewController *vc = [CSHomeSearchViewController new];
                [bself.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    };
    
    [self.view addSubview:self.navView];
    
    self.headerView = [[CSHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.4)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.headerView.bannerClick = ^(CSBannerModel * _Nonnull bannerModel) {
        if (!isEmptyStr(bannerModel.url)) {
             [bself loadUrl:bannerModel.url];
        }
     
    };
    self.tableView.tableHeaderView = self.headerView;
}



#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4 ) {
        return self.clubList.count;
    }
    if (section == 5) {
        return self.counselorList.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ws(bself)
    if (indexPath.section == 0) {
        CSModuleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kModuleCell forIndexPath:indexPath];
        cell.models = self.moduleArr;
        return cell;
    }
    if (indexPath.section == 1) {
        CSExampleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSExampleTableViewCell forIndexPath:indexPath];
        cell.userNumber = self.nowJoinCount;
        cell.moreBtnClickBlock = ^{
            if (!ISLOGIN) {
                [bself.navigationController pushViewController:[NSClassFromString(@"CSLoginViewController") new] animated:YES];
                return;
            }
          [bself.navigationController pushViewController:[NSClassFromString(@"CSCounselorViewController") new] animated:YES];
        };
        return cell;
    }
    if (indexPath.section == 2) {
        CSAdvertisingCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdvertisingCell forIndexPath:indexPath];
        cell.activityImages = self.activityImages;
        cell.jumpBannerDetailBlock = ^(NSString * _Nonnull jumpUrl) {
            [bself loadUrl:jumpUrl];
        };
        return cell;
    }
    if (indexPath.section == 4) {
        CSClubCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSClubCell forIndexPath:indexPath];
        cell.clubModel = self.clubList[indexPath.row];
        return cell;
    }
    if (indexPath.section == 5) {
        CSCounselorCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSCounselorCell forIndexPath:indexPath];
        cell.counselorListModel = self.counselorList[indexPath.row];
        return cell;
    }
    CSHotRecommondCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSHotRecommondCell forIndexPath:indexPath];
    cell.articleArray = self.articleArray;
    cell.collectionViewBlock = ^(CSArticleListModel * _Nonnull articleModel) {
    CSArticleListModel *activityModel = self.articleArray[indexPath.row];
        if (activityModel.isVideo) {
            [self videoPlayerWithUrl:activityModel.articleContent  placeholdImage:activityModel.img];
        }else{
            [self loadHtmlContents:activityModel.articleContent isShare:true collect:true chirleId:activityModel.ID shareContent:activityModel.articleTitle shareIcon:activityModel.img];
        }
    };

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 5) {
        CSCounselorDetailController *counseVc = [[CSCounselorDetailController alloc] init];
        CSCounselorListModel *counselorListModel = self.counselorList[indexPath.row];
        counseVc.counselorId = counselorListModel.ID;
        [self.navigationController pushViewController:counseVc animated:true];
    }
    if (indexPath.section == 4) {
        CSClubDetailViewController *vc = [[CSClubDetailViewController alloc]init];
        CSClubListModel *clubModel = self.clubList[indexPath.row];
        vc.clubId = clubModel.ID;
         [self.navigationController pushViewController:vc animated:true];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 93;
    }
    if (indexPath.section == 1) {
        return  75;;
    }
    if (indexPath.section == 2) {
        return 204;
    }
    if (indexPath.section == 3) {
        return ceil(self.articleArray.count * 0.5) * SIZE(180) +SIZE(20) + 10;
    }
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 5;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1|| section == 2) {
        return 0.01;
    }
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.viewWidth, 5)];
        view.backgroundColor = RGB(238, 238, 238);
        return view;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1|| section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        return view;
    }
    ws(bself);
    CSHomeSessionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kSessionHeaderView];
    if (!headerView) {
        headerView = [[CSHomeSessionHeaderView alloc] initWithReuseIdentifier:kSessionHeaderView];
    }
    headerView.moreBtnClickBlock = ^{
        if (section==4) {//
            [bself.navigationController pushViewController:[NSClassFromString(@"CSFairylandViewController") new] animated:YES];
        }else if (section==5) {
             [bself.navigationController pushViewController:[NSClassFromString(@"CSCounselorViewController") new] animated:YES];
        }else{
            self.tabBarController.selectedIndex = 1;
        }
    };
    headerView.headerModel = self.sessionHeaderArr[section - 3 > 0?section - 3:0];
    return headerView;
}

@end
