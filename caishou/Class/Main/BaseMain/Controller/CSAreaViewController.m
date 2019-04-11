//
//  CSAreaViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSAreaViewController.h"




@interface CSAreaViewController ()<UITableViewDelegate , UITableViewDataSource>
/** tableView */
@property(nonatomic , strong)UITableView *tableView;

@end

@implementation CSAreaViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitleStr:@"请选择站点"];
    [self initTableView];
}

- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.rowHeight = SIZE(45);
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.siteArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    CSSiteModel *model = self.siteArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CSSiteModel *model = self.siteArray[indexPath.row];
    if (self.selectedSiteModeBlock) {
        self.selectedSiteModeBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
