//
//  CSHelpAndFeedbackSubmitSuccessViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHelpAndFeedbackSubmitSuccessViewController.h"


@interface CSHelpAndFeedbackSubmitSuccessViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  图片选择器
 */
@property(nonatomic, strong)PhotoPickModel *pickerModel;
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation CSHelpAndFeedbackSubmitSuccessViewController
-(PhotoPickModel *)pickerModel{
    if (!_pickerModel) {
        _pickerModel = [PhotoPickModel new];
    }
    return _pickerModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitleStr:@""];
    [self initTableView];
}

- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[PhotoPickCell class] forCellReuseIdentifier:@"PhotoPickCell"];
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
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return SIZE(150);
    }
    
    return self.pickerModel.cellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        PhotoPickCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoPickCell"];
        self.pickerModel.section = indexPath.section;
        cell.model = self.pickerModel;
        HXWeakSelf
        [cell setPhotoViewChangeHeightBlock:^(UITableViewCell *mycell) {
            NSIndexPath *myIndexPath = [weakSelf.tableView indexPathForCell:mycell];
            if (myIndexPath) {
                [weakSelf.tableView reloadRowsAtIndexPaths:@[myIndexPath] withRowAnimation:0];
            }
        }];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    HXPhoto3DTouchViewController *vc = (HXPhoto3DTouchViewController *)viewControllerToCommit;
    PhotoPickCell *cell = (PhotoPickCell *)[self.tableView cellForRowAtIndexPath:vc.indexPath];
    [cell.photoView jumpPreviewViewControllerWithModel:vc.model];
}
@end
