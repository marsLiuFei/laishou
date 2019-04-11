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
//  CSCounselorDetailController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorDetailController.h"

#import "CSCounselorDetailModel.h"

#import "CSCounselorDetailHeaderView.h"
#import "CSExhibitionTableViewCell.h"
#import "CSCounselorTitleTableViewCell.h"
#import "CSCounselorMembersTableViewCell.h"

#import "CSOptimizeNewsCell.h"

@interface CSCounselorDetailController ()<UITableViewDelegate , UITableViewDataSource>
{
    UITableView *_tableView;
}
@property(nonatomic, strong)CSCounselorDetailHeaderView *headerView;
@property(nonatomic, strong)CSCounselorDetailModel *counselorModel;
@end

@implementation CSCounselorDetailController

NSString *kCSExhibitionTableViewCell =@"kCSExhibitionTableViewCell";
NSString *kCSArticleTableViewCell =@"kCSOptimizeNewsCell";

NSString *kCounselorDetailTitleTableViewCell = @"kCounselorDetailTitleTableViewCell";
NSString *kCounselorTableViewCell = @"kCounselorTableViewCell";



-(CSCounselorDetailModel *)counselorModel{
    if (!_counselorModel) {
        _counselorModel = [CSCounselorDetailModel new];
    }
    return _counselorModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}

- (void )loadData{
    ws(bself);
    [CSApiManager counselorDetailsWithParamDic:@{@"substationId":[UDefault getObject:NowSiteId],@"id":isEmptyStr(self.counselorId)?@"":self.counselorId} CallBack:^(id  _Nonnull data) {
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            bself.counselorModel = [CSCounselorDetailModel mj_objectWithKeyValues:data[@"data"]];
            NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:bself.counselorModel.userList.count +1];
            [dataArr addObjectsFromArray:bself.counselorModel.userList];
            [dataArr insertObject:[CSUserMemberModel loadTitleData] atIndex:0];
            bself.counselorModel.userList = dataArr.copy;
            [bself setupHeaderView];
            
            bself.headerView.counselorDetailModel = bself.counselorModel;
            [self->_tableView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}

#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@""];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
    [self setupHeaderView];
}
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTopHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [tableView registerClass:[CSExhibitionTableViewCell class] forCellReuseIdentifier:kCSExhibitionTableViewCell];
    [tableView registerClass:[CSOptimizeNewsCell class] forCellReuseIdentifier:kCSArticleTableViewCell];
    
    [tableView registerClass:[CSCounselorTitleTableViewCell class] forCellReuseIdentifier:kCounselorDetailTitleTableViewCell];
    [tableView registerClass:[CSCounselorMembersTableViewCell class] forCellReuseIdentifier:kCounselorTableViewCell];
    [self.view addSubview:tableView];
    _tableView = tableView;
}
- (void) setupHeaderView{
     CGFloat height =  SIZE(self.counselorModel.height + 200);
   self.headerView  = [[CSCounselorDetailHeaderView alloc] init];
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    _tableView.tableHeaderView = self.headerView;
}



#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.counselorModel.userList.count;
    }
    if (section == 1) {
        return self.counselorModel.mienList.count>0?1:0;
    }
    return self.counselorModel.articleList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CSCounselorTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCounselorDetailTitleTableViewCell forIndexPath:indexPath];
            return cell;
        }
        CSCounselorMembersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCounselorTableViewCell forIndexPath:indexPath];
        cell.show = true;
        cell.black = true;
        cell.userModel = self.counselorModel.userList[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        ws(bself);
        CSExhibitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSExhibitionTableViewCell forIndexPath:indexPath];
        cell.sourceData = self.counselorModel.mienList;
        cell.clickImageBlock = ^(NSInteger index, NSArray * _Nonnull subViews, NSArray * _Nonnull imageArray) {
            [bself post:index subviews:subViews arr:imageArray];
        };
        return cell;
    }
    CSOptimizeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSArticleTableViewCell forIndexPath:indexPath];
    cell.articleModel = self.counselorModel.articleList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 || indexPath.section == 0) {
        
    }else{
        CSArticleListModel *articleModel = self.counselorModel.articleList[indexPath.row];
        if (articleModel.isVideo) {
            [self videoPlayerWithUrl:articleModel.articleContent placeholdImage:articleModel.img];
        }else{
            [self loadHtmlContents:articleModel.articleContent];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSInteger ii = self.counselorModel.mienList.count%4;
        BOOL isUp = ii>0;
        NSInteger row = (self.counselorModel.mienList.count/4) + (isUp ? 1:0);
         CGFloat width = (SCREEN_WIDTH - SIZE(30))/4.f;
        
        CGFloat height = width*row;
        return height;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return SIZE(21);
        }
        return SIZE(60);
    }
    return SIZE(120);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.viewWidth, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titlLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.viewWidth - 30, 30)];
    titlLabel.text = @"我的会员";
    if (section == 1) {
        titlLabel.text = @"风采展示";
    }
    if (section == 2) {
       titlLabel.text = @"发布的文章";
    }
    titlLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size: 16];
    titlLabel.textColor = RGB(67, 207, 124);
    [headerView addSubview:titlLabel];
    return headerView;
}

@end
