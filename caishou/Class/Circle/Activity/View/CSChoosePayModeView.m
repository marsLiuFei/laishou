//
//  CSChoosePayModeView.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/17.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSChoosePayModeView.h"
#import "CSChoosePayModeModel.h"

#import "CSChoosePayModeCell.h"

#define LFTuanNumViewHight 300.0
#define UI_View_Width  [UIScreen mainScreen].bounds.size.width
#define UI_View_Height [UIScreen mainScreen].bounds.size.height

@interface CSChoosePayModeView()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_contentView;
}
/**
 *
 **/
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *sourceDataArray;
/**
 *
 **/
@property(nonatomic, assign)NSInteger selectedIndex;
@end

@implementation CSChoosePayModeView
-(NSArray *)sourceDataArray{
    if (!_sourceDataArray) {
        _sourceDataArray = [NSArray new];
    }
    return _sourceDataArray;
}
- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupContent];
    }
    return self;
}

- (void)setupContent {
    self.frame = CGRectMake(0, 0, UI_View_Width,UI_View_Height);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    self.userInteractionEnabled = YES;
//    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];//点击空白地方移除视图
    
    if (_contentView == nil) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, UI_View_Height, UI_View_Width, LFTuanNumViewHight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        
        UILabel *la = [ViewCreate createLabelFrame:CGRectMake(SIZE(15), 0, 70, 40) backgroundColor:ClearColor text:@"支付方式" textColor:RGB44 textAlignment:Left font:MediumFont(16)];
        [_contentView addSubview:la];
        
        UIButton *cancelBtn = [ViewCreate createButtonFrame:CGRectMake(UI_View_Width-70, 0, 70, 40) normalImage:@"close_icon" selectedImage:@"close_icon" touchUpInsideEvent:nil];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:cancelBtn];
        
        UIView *line = [ViewCreate createLineFrame:CGRectMake(0, 40, UI_View_Width, 1) backgroundColor:RGB(211, 211, 211)];
        [_contentView addSubview:line];
        
        [_contentView addSubview:self.tableView];
    }
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 41, UI_View_Width, LFTuanNumViewHight-41) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = WhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[CSChoosePayModeCell class] forCellReuseIdentifier:@"CSChoosePayModeCell"];
        if (@available(iOS 11.0,*)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            self.tableView.estimatedRowHeight = 0;
            self.tableView.estimatedSectionFooterHeight = 0;
            self.tableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE(100);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(100)) backgroundColor:WhiteColor];
    
    UIButton *sureBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(30), SIZE(30), UI_View_Width-SIZE(60), SIZE(40)) title:@"确定" titleColor:WhiteColor font:MediumFont(16) backgroundColor:MainColor touchUpInsideEvent:nil];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = SIZE(20);
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:sureBtn];
    
    return bgView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSChoosePayModeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSChoosePayModeCell"];
    CSChoosePayModeModel *payModeModel = self.sourceDataArray[indexPath.row];
    cell.payMode = payModeModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CSChoosePayModeModel *payModeModel = self.sourceDataArray[indexPath.row];
    for (int i=0; i<self.sourceDataArray.count; i++) {
        CSChoosePayModeModel *model = self.sourceDataArray[i];
        if ([model.name isEqualToString:payModeModel.name]) {
            model.isSelected = YES;
        }else{
            model.isSelected = NO;
        }
    }
    [self.tableView reloadData];
}

-(void)cancelAction{
    
    [self disMissView];
    
}

-(void)sureAction{
    NSString *str;
    for (int i=0; i<self.sourceDataArray.count; i++) {
        CSChoosePayModeModel *model = self.sourceDataArray[i];
        if (model.isSelected ) {
            str = model.name;
        }
    }
    if (self.pickerBlock) {
        self.pickerBlock(str);
    }
    [self disMissView];
}



/**
 *  @param view 展示在哪个视图上
 *  @param sourceData 需要展示的数据数组
 *  @param nowShowString 当前展示的数据
 */
- (void)showInView:(UIView *)view sourceDataArray:(NSArray *)sourceData  nowShowString:(NSString *)nowShowString{
    if (!view) {
        return;
    }
    [view addSubview:self];
    [view addSubview:_contentView];
    
    self.sourceDataArray = sourceData;
    
    
    for (int i=0; i<self.sourceDataArray.count; i++) {
        CSChoosePayModeModel *model = self.sourceDataArray[i];
        if ([nowShowString isEqualToString:model.name]) {
            self.selectedIndex = i;
        }
    }
    
    _contentView.alpha=0;
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        self->_contentView.alpha = 1;
        [self->_contentView setFrame:CGRectMake(0, UI_View_Height - LFTuanNumViewHight, UI_View_Width, LFTuanNumViewHight)];
        
    } completion:nil];
//    [self.tableView reloadData];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView {
    _contentView.alpha = 1;
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0.0;
                         [self->_contentView setFrame:CGRectMake(0, UI_View_Height , UI_View_Width, 0)];
                         self->_contentView.alpha=0.0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [self->_contentView removeFromSuperview];
                         
                     }];
    
}

@end
