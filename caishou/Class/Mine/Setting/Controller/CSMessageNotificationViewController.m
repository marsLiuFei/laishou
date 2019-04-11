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
//  CSMessageNotificationViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/14.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMessageNotificationViewController.h"
#import "CSMessageSettingModel.h"
#import "CSMessageSettingCell.h"

@interface CSMessageNotificationViewController ()<UITableViewDataSource,UITableViewDelegate>
/** tableView */
@property(nonatomic , strong)UITableView *tableView;
/** datas */
@property(nonatomic , strong)NSArray *datas;

@end

@implementation CSMessageNotificationViewController

NSString *kCSMessageSettingCell = @"kCSMessageSettingCell";

- (NSArray *)datas {
    if (!_datas) {
        _datas = [CSMessageSettingModel loadDatas];
    }
    return _datas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@"消息通知"];
    [self initTableView];
   
}
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStylePlain];
    _tableView.scrollEnabled = false;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[CSMessageSettingCell class] forCellReuseIdentifier:kCSMessageSettingCell];
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
    return self.datas.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.datas[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSMessageSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSMessageSettingCell forIndexPath:indexPath];
    cell.settingModel = self.datas[indexPath.section][indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SIZE(15), 0, SCREEN_WIDTH - SIZE(30), SIZE(34))];
    if (section == 0) {
        label.text = @"如果你要关闭或开启莱瘦的新消息通知，请在手机“设置”-“通知”功能中，找到应用“莱瘦”操作";
        label.frame = CGRectMake(SIZE(15), 0, SCREEN_WIDTH - SIZE(30),SIZE(49));
    }
    if (section == 1) {
        label.text = @"开启后，将在23:00-8:00间不接受莱瘦的通知（不包含提醒）";
    }
    if (section == 2) {
        label.text = @"当莱瘦在运行时，你可以设置是否需要声音或震动";
    }
    label.numberOfLines = 2;
    label.textColor = RGB(153, 153, 153);
    label.font = RegularFont(12);
    [footView addSubview:label];
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SIZE(40);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return SIZE(15);
    }
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return SIZE(49);
    }
    return SIZE(34);
}


-(void)viewDidLayoutSubviews{

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
       [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
