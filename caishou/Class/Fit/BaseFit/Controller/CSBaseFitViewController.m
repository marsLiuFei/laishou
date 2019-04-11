//
//  CSBaseFitViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseFitViewController.h"
#import "CSBenifitGoodsDetailViewController.h"

#import "CSSpellGoodsModel.h"

#import "CSBannerPicsCell.h"
#import "CSFitScannigMenuCell.h"
#import "CSFitGoodsCell.h"

@interface CSBaseFitViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
/**
 *  分类选择的数组
 */
@property(nonatomic, copy)NSArray *titles;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *spellGoodsList;
/**
 *  拼团类型（1:热销;2:服务;3:健身;4：餐饮;5:服装）
 */
@property(nonatomic, strong)NSString *spellType;
@end

@implementation CSBaseFitViewController
-(NSMutableArray *)spellGoodsList{
    if (!_spellGoodsList) {
        _spellGoodsList = [NSMutableArray new];
    }
    return _spellGoodsList;
}
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@{@"title":@"热销",@"imageName":@"icon_001"},@{@"title":@"服务",@"imageName":@"icon_002"},@{@"title":@"健身",@"imageName":@"icon_003"},@{@"title":@"餐饮",@"imageName":@"icon_004"},@{@"title":@"服装",@"imageName":@"icon_005"}];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_showTitle) {
        
        [self setNavTitleStr:@"莱购"];
    }
    self.page = 1;
    self.spellType = @"1";
    [self initTableView];//
    [self addRefresh];
    [self loadData];
}


- (void )addRefresh{
    ws(bself);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 1;
        [bself loadData];
    }];
    //    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself loadData];
    }];
}
- (void)loadData {
    ws(bself);
//    spellType    否    int    拼团类型（1:热销;2:服务;3:健身;4：餐饮;5:服装）
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10",@"spellType":self.spellType}.mutableCopy;
    NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
    [paramDic addEntriesFromDictionary:locationDic];
    [CSApiManager mySpellGoodsListeWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [self->_tableView.mj_header endRefreshing];
        [self->_tableView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSSpellGoodsModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            if (arr.count>0) {
                if (bself.page>1) {
                    [bself.spellGoodsList addObjectsFromArray:arr];
                }
                else{
                    bself.spellGoodsList = arr.mutableCopy;
                }
            }
            else{
                if (bself.page>1) {
                    
                }
                else{
                    bself.spellGoodsList = nil;
                }
            }
            [bself.tableView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
        [self->_tableView.mj_header endRefreshing];
        [self->_tableView.mj_footer endRefreshing];
    }];
}




- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[CSBannerPicsCell class] forCellReuseIdentifier:@"CSBannerPicsCell"];
    [_tableView registerClass:[CSFitScannigMenuCell class] forCellReuseIdentifier:@"CSFitScannigMenuCell"];
    [_tableView registerClass:[CSFitGoodsCell class] forCellReuseIdentifier:@"CSFitGoodsCell"];
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
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return self.spellGoodsList.count;
            break;
            
        default:
            return 0;
            break;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return SCREEN_WIDTH*0.5;
    }
    else if (indexPath.section==1){
        return SIZE(115);
    }
    return SIZE(160);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    if (indexPath.section==0) {
        CSBannerPicsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSBannerPicsCell"];
        NSString *pics = [CSCommonHelper Instance].FitPosterModel.advUrl;
        cell.imageArray = @[isEmptyStr(pics)?@"":pics];
        cell.bannerClick = ^(NSInteger index, NSArray * _Nonnull imageArray) {
            if (index==0) {
                [bself loadUrl:[CSCommonHelper Instance].FitPosterModel.url];
            }
            
        };
        return cell;
    }
    else if (indexPath.section==1){
        CSFitScannigMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSFitScannigMenuCell"];
        cell.infoDicArray = self.titles;
        cell.clickBlock = ^(NSInteger index) {
            bself.spellType = [NSString stringWithFormat:@"%ld",index];
            [bself.tableView.mj_header beginRefreshing];
        };
        return cell;
    }
    CSFitGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSFitGoodsCell"];
    cell.spellGoodsModel = self.spellGoodsList[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        ws(bself);
        CSBenifitGoodsDetailViewController *vc = [CSBenifitGoodsDetailViewController new];
        CSSpellGoodsModel *spellGoodsModel = self.spellGoodsList[indexPath.row];
        vc.goodsID = spellGoodsModel.ID;
        vc.needRefreshBLock = ^{
            [bself.tableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
