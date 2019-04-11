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
//  CSAboutAppViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/14.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSAboutAppViewController.h"
#import "CSAboutAppCell.h"

@interface CSAboutAppViewController ()<UITableViewDataSource,UITableViewDelegate>
/** tableView */
@property(nonatomic , strong)UITableView *tableView;
/** datas */
@property(nonatomic , strong)NSArray *datas;


@end

@implementation CSAboutAppViewController


NSString *kCSAboutAppCell = @"kCSAboutAppCell";

- (NSArray *)datas {
    if (!_datas) {
        _datas = @[@"去评分",@"用户协议",@"APP认证信息",@"莱瘦用户使用协议"];
    }
    return _datas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@"关于莱瘦"];
    [self initTableView];
    [self createHeaderView];
    
}
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStylePlain];
    _tableView.scrollEnabled = false;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[CSAboutAppCell class] forCellReuseIdentifier:kCSAboutAppCell];
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
- (void)createHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(180))];
    UIImageView *iconImage = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"showLogo"];
    [headerView addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SIZE(39));
        make.width.height.offset(SIZE(72));
        make.centerX.offset(0);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"莱瘦V1.0";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGB(53, 60, 54);
    label.font = RegularFont(16);
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImage.mas_bottom);
        make.left.offset(SIZE(15));
        make.right.offset(SIZE(-15));
        make.height.offset(SIZE(21));
    }];
    
    _tableView.tableHeaderView = headerView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSAboutAppCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSAboutAppCell forIndexPath:indexPath];
    cell.titleLabel.text = self.datas[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SIZE(40);
}




@end
