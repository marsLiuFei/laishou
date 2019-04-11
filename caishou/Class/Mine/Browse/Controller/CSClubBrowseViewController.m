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
//  CSClubBrowseViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/3.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSClubBrowseViewController.h"
#import "CSClubCell.h"
#import "CSClubDetailViewController.h"

@interface CSClubBrowseViewController ()<UITableViewDelegate , UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation CSClubBrowseViewController

NSString *kBrowseClubCell =@"kBrowseClubCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}
- (void)createUI {
    self.view.backgroundColor = RGB(238, 238, 238);
    [self cerateTableView];
}
- (void)cerateTableView {
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    if (@available(iOS 11.0,*)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        tableview.estimatedRowHeight = 0;
        tableview.estimatedSectionFooterHeight = 0;
        tableview.estimatedSectionHeaderHeight = 0;
    }
    [tableview registerClass:[CSClubCell class] forCellReuseIdentifier:kBrowseClubCell];
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-kStatusBarHeight + 5);
    }];
    _tableView = tableview;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSClubCell *cell = [tableView dequeueReusableCellWithIdentifier:kBrowseClubCell forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[CSClubDetailViewController alloc]init] animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
