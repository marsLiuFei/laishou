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
//  CSSettingViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/12.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSettingViewController.h"
#import "CSSettingModel.h"
#import "CSSettingTableViewCell.h"
#import "CSBaseMineViewController.h"
#import "CSClearTool.h"

@interface CSSettingViewController ()<UITableViewDelegate , UITableViewDataSource>

/** datas */
@property(nonatomic , strong)NSArray *datas;

/** tableView */
@property(nonatomic , strong)UITableView *tableView;



@end

@implementation CSSettingViewController

NSString *kCSSettingTableViewCell = @"kCSSettingTableViewCell";

- (NSArray *)datas {
    if (!_datas) {
        _datas = [CSSettingModel loadDatas];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadCacheData];
}
- (void)loadCacheData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSInteger totlaSize =  [CSClearTool getCacheSize];
        dispatch_async(dispatch_get_main_queue(), ^{
            CSSettingModel *model =  self.datas[1][0];
            model.subTitle = [NSString stringWithFormat:@"%ldM", totlaSize];
            [self.tableView reloadData];
        });
    });
}
#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@"设置"];
    [self initTableView];
    [self setupFootView];
}
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[CSSettingTableViewCell class] forCellReuseIdentifier:kCSSettingTableViewCell];
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

- (void)setupFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(100))];
    UIButton *logOutBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"退出登录" titleColor:[UIColor whiteColor] font:RegularFont(16) backgroundColor:RGB(231, 109, 105) touchUpInsideEvent:nil];
    [logOutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    logOutBtn.layer.cornerRadius = 10;
    logOutBtn.clipsToBounds = true;
    [footView addSubview:logOutBtn];
    [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(SIZE(200));
        make.centerY.offset(0);
        make.height.offset(SIZE(40));
    }];
    
    _tableView.tableFooterView = footView;
}

#pragma mark - click
- (void)logoutBtnClick:(UIButton *)sender {
    [CSCommonHelper showAlterView:self title:@"温馨提示" message:@"确定退出当前帐号?" yesBtnTitle:@"确定" noBtnTitle:@"取消" yesBlock:^{
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[CSBaseMineViewController class]]) {
                [UDefault removeObject:LoginType];
                [UDefault removeObject:AuthKey];
                CSBaseMineViewController *baseMineVc = (CSBaseMineViewController *)vc;
                baseMineVc.gotoHome = true;
                [self.navigationController popToViewController:baseMineVc animated:false];
                return;
            }
        }
    } noBlock:^{
        
    }];
    
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.datas[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSSettingTableViewCell forIndexPath:indexPath];
    CSSettingModel *model = self.datas[indexPath.section][indexPath.row];
    cell.settingModel = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CSSettingModel *model = self.datas[indexPath.section][indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 1) {
        //隐私
        {
            CSBaseWebViewController *vc = [CSBaseWebViewController new];
            vc.url = @"http://share.laiscn.com/agreement";
            vc.navTitleStr = @"隐私";
            [self.navigationController pushViewController:vc animated:YES];
        }
        return;
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        //关于莱瘦
        CSBaseWebViewController *vc = [CSBaseWebViewController new];
        vc.url = @"http://share.laiscn.com/about";
        vc.navTitleStr = @"关于莱瘦";
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.section == 1) {
        ws(bself);
        [CSCommonHelper showAlterView:self title:@"温馨提示" message:@"是否确定清除应用缓存？" yesBtnTitle:@"确定" noBtnTitle:@"取消" yesBlock:^{
            [CSClearTool clearCache:^(NSError * _Nonnull error) {
                if (!error) {
                    model.subTitle = @"0M";
                    UIAlertView *alertView =   [[UIAlertView alloc] initWithTitle:@"清理完成" message:@"" delegate:nil cancelButtonTitle:@"完成" otherButtonTitles:nil, nil];
                    [alertView show];
                    [bself.tableView reloadData];
                    return ;
                }
            }];
        } noBlock:^{
            
        } ];
        
        
    }
    [self.navigationController pushViewController:[ NSClassFromString(model.pushVc) new] animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SIZE(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE(15);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


@end
