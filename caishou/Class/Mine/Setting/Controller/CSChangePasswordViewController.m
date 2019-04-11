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
//  CSChangePasswordViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/13.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSChangePasswordViewController.h"
#import "CSPasswordModel.h"
#import "CSPassowrdCell.h"

@interface CSChangePasswordViewController ()<UITableViewDataSource,UITableViewDelegate>
/** tableView */
@property(nonatomic , strong)UITableView *tableView;
/** datas */
@property(nonatomic , strong)NSArray *datas;

@end

@implementation CSChangePasswordViewController

NSString *kCSPassowrdCell = @"kCSPassowrdCell";

- (NSArray *)datas {
    if (!_datas) {
        _datas = [CSPasswordModel loadDatas];
    }
    return _datas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@"修改密码"];
    [self initTableView];
    [self setupBottomView];
}
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStylePlain];
    _tableView.scrollEnabled = false;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[CSPassowrdCell class] forCellReuseIdentifier:kCSPassowrdCell];
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

- (void)setupBottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    UILabel *hintlabel = [ViewCreate createLabelFrame:CGRectMake(SIZE(15), SIZE(5), SCREEN_WIDTH - SIZE(30), 21) backgroundColor:[UIColor clearColor] text:@"密码必须至少8个字符，而且同时包含字母和数字" textColor:RGB(153, 153, 153) textAlignment:NSTextAlignmentLeft font:RegularFont(12)];
    [bottomView addSubview:hintlabel];
    UIButton *changeBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"确认修改" titleColor:WhiteColor font:MediumFont(16) backgroundColor:RGB(67, 207, 124) touchUpInsideEvent:nil];
    [changeBtn addTarget:self action:@selector(sureEditPassword:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:changeBtn];
    changeBtn.clipsToBounds = true;
    changeBtn.layer.cornerRadius = 5;
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.mas_equalTo(SIZE(251));
        make.height.mas_equalTo(SIZE(45));
        make.bottom.mas_equalTo(SIZE(-10));
    }];
    _tableView.tableFooterView = bottomView;
}


- (void)sureEditPassword:(UIButton *)sender {
    CSPasswordModel *oldPassModel = self.datas[0];
    CSPasswordModel *newPassModel = self.datas[1];
    CSPasswordModel *rePassModel = self.datas[2];
    if (isEmptyStr(oldPassModel.inputData)||
        isEmptyStr(newPassModel.inputData)||
        isEmptyStr(rePassModel.inputData)) {
        [Dialog toastCenter:@"请输入密码"];
        return;
    }
    if (![ZYQTool ZYQ_judgePasswordWithStr:newPassModel.inputData from:8 to:20] ||
        ![ZYQTool ZYQ_judgePasswordWithStr:rePassModel.inputData from:8 to:20]) {
        [Dialog toastCenter:@"密码格式不正确"];
        return;
    }
    if (![newPassModel.inputData isEqualToString:rePassModel.inputData]) {
        [Dialog toastCenter:@"两次输入密码不一致"];
        return;
    }
    NSDictionary *param= @{@"oldPwd":[oldPassModel.inputData md5],@"newPwd":[newPassModel.inputData md5]};
    [CSApiManager updatePwdWithParamDic:param CallBack:^(id  _Nonnull data) {
        if (ResultIsCorrect) {
            [Dialog toastCenter:BackMessage];
            [self.navigationController popViewControllerAnimated:true];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
        
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
        
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSPassowrdCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSPassowrdCell forIndexPath:indexPath];
    cell.passModel = self.datas[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SIZE(55);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE(15);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

@end
