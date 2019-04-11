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
//  CSGradeAndWeightViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSGradeAndWeightViewController.h"
#import "CSWeightDetailViewController.h"

#import "CSGradeHeaderView.h"
#import "CSGradeWeightCell.h"
#import "CSAddWeigthAlert.h"
#import "CSGradeWeightModel.h"

#import "ORChartView.h"

@interface CSGradeAndWeightViewController ()
/** datas */
@property(nonatomic , strong)NSMutableArray *dataArray;
/** 头部视图 */
@property(nonatomic , strong)CSGradeHeaderView *headerView;
@property (nonatomic, strong) ORChartView *chartView;
@end

@implementation CSGradeAndWeightViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self setNavTitleStr:@""];
    UIButton *rightBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(80), SIZE(30)) title:@"详细记录" titleColor:WhiteColor font:FONT(15) backgroundColor:ClearColor touchUpInsideEvent:nil];
    [rightBtn addTarget:self action:@selector(detailBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];;
    
    [self loadData];
}


- (void )drawLine{
    
    NSMutableArray *arrM = [NSMutableArray new];
    NSMutableArray *mArr = [NSMutableArray new];
    for (CSGradeWeightModel *model in self.dataArray) {
        [arrM addObject:[NSString stringWithFormat:@"%.2lf",model.weight]];
        [mArr addObject:model.strCreateTime];
    }
//    NSArray *arrY = [[arrM reverseObjectEnumerator] allObjects];
//    NSArray *arrX = [[mArr reverseObjectEnumerator] allObjects];
    
    [_chartView removeFromSuperview];
    _chartView = [[ORChartView alloc] initWithFrame:CGRectMake(0, SIZE(300),SCREEN_WIDTH, SIZE(300)) dataSource:arrM countFoyY:7 xSource:mArr];
//    _chartView.dataArrOfX = mArr;
    _chartView.titleForX = @"日期/日";
    _chartView.titleForY = @"体重/kg";
    [_chartView pointDidTapedCompletion:^(NSString *value, NSInteger index) {
        NSLog(@"....%@....%ld", value, (long)index);
    }];
    [self.view addSubview:_chartView];
    
    
}


- (void )detailBtn{
    [self.navigationController pushViewController:[CSWeightDetailViewController new] animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:WhiteColor};
    self.navigationController.navigationBar.tintColor = WhiteColor;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = NO; self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationController.navigationBar.barTintColor = WhiteColor;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
#pragma mark - loadData
- (void)loadData {
    ws(bself);
    NSMutableDictionary *paramDic = @{@"page":@(1),@"rows":@"1000"}.mutableCopy;
    NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
    [paramDic addEntriesFromDictionary:locationDic];
    [CSApiManager myWeightWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSGradeWeightModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            NSArray *arr0 = [[arr reverseObjectEnumerator] allObjects];
            if (arr.count>0) {
                    bself.dataArray = arr0.mutableCopy;
            }
            [bself setupHeaderData];
            [bself drawLine];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}

#pragma mark - createUI
- (void)createUI {
    [self setupTopView];
    [self setupBottom];
}


- (void)setupTopView {
    CSGradeHeaderView *headerView = [[CSGradeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(300))];
    headerView.addWeightBlock = ^{
        CSAddWeigthAlert *alert = [[CSAddWeigthAlert alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alert.addWeightBtnBlock = ^(NSString * _Nonnull number) {
            [CSApiManager addWeightRecordWithParamDic:@{@"weight":@([number integerValue])} CallBack:^(id  _Nonnull data) {
                [Dialog toastCenter:BackMessage];
                if (ResultIsCorrect) {
                   [self loadData];
                }
            } fail:^(NSError * _Nonnull error) {
                [Dialog toastCenter:@"网络错误"];
            }];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:alert];
    };
    _headerView = headerView;
    [self.view addSubview:headerView];
    
}
- (void)setupHeaderData {
    NSInteger yesterdayWeight = 0;
    NSInteger todayWeight = 0;
    NSString *currentDayStr = [NSDate ZYQ_getNewTimeFormat:[NSDate ZYQ_ymdFormat] date:[NSDate date]];
    NSString *yesterdayDayStr = [NSDate ZYQ_getNewTimeFormat:[NSDate ZYQ_ymdFormat] date:[NSDate ZYQ_dateAfterDate:[NSDate date] day:-1]];
    for (CSGradeWeightModel *model in self.dataArray) {
        NSDate *saveDate = [NSDate ZYQ_dateWithString:model.strCreateTime format:@"yyyy-MM-dd HH:mm:ss"];
        NSString *saveDayStr = [NSDate ZYQ_getNewTimeFormat:[NSDate ZYQ_ymdFormat] date:saveDate];
        if ([saveDayStr isEqualToString:currentDayStr]) {
            todayWeight = model.weight;
        }
        if ([saveDayStr isEqualToString:yesterdayDayStr]) {
           yesterdayWeight = model.weight;
        }
    }
    CGFloat weightValue = 0.0f;
    if (self.dataArray.count >= 2) {
        CSGradeWeightModel *model0 = self.dataArray[self.dataArray.count-1];
        CSGradeWeightModel *model1 = self.dataArray[self.dataArray.count-2];
        weightValue = model1.weight -  model0.weight;
    }
    else if (self.dataArray.count == 1){
        CSGradeWeightModel *model0 = self.dataArray[0];
        weightValue = 0 - model0.weight;
    }
    
    
    [_headerView setupWeigth:weightValue];
}

- (void)setupBottom {
    
}


@end
