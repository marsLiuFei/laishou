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
//  CSExpiredCouponController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/3.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSExpiredCouponController.h"
#import "CSCouponTableViewCell.h"

@interface CSExpiredCouponController ()<UITableViewDelegate , UITableViewDataSource>
{
    UITableView *_tableView;
}


@end

@implementation CSExpiredCouponController

NSString *kCSCouponExpiredCell = @"kCSCouponExpiredCell";


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
    [tableview registerClass:[CSCouponTableViewCell class] forCellReuseIdentifier:kCSCouponExpiredCell];
    [self.view addSubview:tableview];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    CSCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSCouponExpiredCell forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  SIZE(160);
}
@end
