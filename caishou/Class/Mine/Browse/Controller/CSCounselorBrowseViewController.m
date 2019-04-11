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
//  CSCounselorBrowseViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/3.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorBrowseViewController.h"
#import "CSCounselorTableViewCell.h"
#import "CSCounselorDetailController.h"

@interface CSCounselorBrowseViewController ()<UITableViewDelegate , UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation CSCounselorBrowseViewController

NSString *kCounselorBrowseCell =@"kCounselorBrowseCell";


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
    [tableview registerClass:[CSCounselorTableViewCell class] forCellReuseIdentifier:kCounselorBrowseCell];
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
    CSCounselorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCounselorBrowseCell forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CSCounselorDetailController *counseVc = [[CSCounselorDetailController alloc] init];
    [self.navigationController pushViewController:counseVc animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  80;
}




@end
