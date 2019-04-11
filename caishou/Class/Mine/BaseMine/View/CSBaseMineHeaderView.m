//
//  CSBaseMineHeaderView.m
//  caishou
//
//  Created by 刘飞 on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseMineHeaderView.h"

@implementation CSBaseMineHeaderView
{
    UIImageView *headerImageView;
    UILabel *nickNameLabel;
    UILabel *desLabel;
    UIButton *orderBtn;
//    UIButton *editNumLabel;
    UIButton *collectBtn;
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    
    UIView *topView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(240)) backgroundColor:[UIColor TF_gradientFromColor:RGB(67, 207, 124) toColor:RGB(97, 236, 154) withSize:CGSizeMake(1, SIZE(320))]];
    [self addSubview:topView];
    
    UIView *bottomView = [ViewCreate createLineFrame:CGRectMake(0, SIZE(240), SCREEN_WIDTH, SIZE(120)) backgroundColor:WhiteColor];
    [self addSubview:bottomView];
    
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(SIZE(15), SIZE(115), SCREEN_WIDTH-SIZE(30), SIZE(145)) backgroundColor:WhiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.shadowColor = [UIColor colorWithRed:214.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.35f].CGColor;
    bgView.layer.shadowOffset = CGSizeMake(0, 3);
    bgView.layer.shadowOpacity = 1;
    bgView.layer.shadowRadius = 4.0;
    [self addSubview:bgView];
    
    headerImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"counselor"];
    headerImageView.layer.cornerRadius = SIZE(37.5);
    headerImageView.layer.masksToBounds = YES;
    [self addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(SIZE(75));
        make.centerX.offset(0);
        make.centerY.mas_equalTo(bgView.mas_top).offset(0);
    }];
    headerImageView.userInteractionEnabled = true;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoMyInfo:)];
    [headerImageView addGestureRecognizer:tapGes];
    
    nickNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"用户123456789" textColor:RGBA(53, 60, 54, 1) textAlignment:Center font:FONT(14)];
    [self addSubview:nickNameLabel];
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(self->headerImageView.mas_bottom).offset(SIZE(10));
    }];
    
    desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"在莱瘦的第3天" textColor:RGBA(53, 60, 54, 1) textAlignment:Center font:FONT(14)];
    [self addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(self->nickNameLabel.mas_bottom).offset(SIZE(5));
    }];
    
    
    
    orderBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"0\n订单" titleColor:RGB(102, 102, 102) font:FONT(16) backgroundColor:ClearColor touchUpInsideEvent:nil];
    orderBtn.titleLabel.numberOfLines = 2;
    orderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:orderBtn];
    orderBtn.tag = 100;
    [orderBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).offset(SIZE(20));
        make.bottom.mas_equalTo(bgView.mas_bottom).offset(0);
        make.height.offset(SIZE(50));
    }];
    
    
//    editNumLabel = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"0\n发表" titleColor:RGB(102, 102, 102) font:FONT(16) backgroundColor:ClearColor touchUpInsideEvent:nil];
//    editNumLabel.titleLabel.numberOfLines = 2;
//    editNumLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [bgView addSubview:editNumLabel];
//    editNumLabel.tag = 101;
//    [editNumLabel addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [editNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->orderBtn.mas_right).offset(0);
//        make.bottom.mas_equalTo(bgView.mas_bottom).offset(0);
//        make.height.offset(SIZE(50));
//        make.width.mas_equalTo(self->orderBtn.mas_width).offset(0);
//    }];
    
    
    collectBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"0\n收藏" titleColor:RGB(102, 102, 102) font:FONT(16) backgroundColor:ClearColor touchUpInsideEvent:nil];
    collectBtn.titleLabel.numberOfLines = 2;
    collectBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:collectBtn];
    collectBtn.tag = 102;
    [collectBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->orderBtn.mas_right).offset(0);
        make.bottom.mas_equalTo(bgView.mas_bottom).offset(0);
        make.right.mas_equalTo(bgView.mas_right).offset(-SIZE(20));
        make.height.offset(SIZE(50));
        make.width.mas_equalTo(self->orderBtn.mas_width).offset(0);
    }];
    
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        orderBtn.hidden = YES;
        collectBtn.hidden = YES;
    }
    
    
    CGFloat width = (SCREEN_WIDTH-SIZE(30))/3.f;
    NSArray *icons  = @[@"myscord",@"myCircle",@"clubIcon"/*,@"service_icon"*/];
    NSArray *titles = @[@"我的成绩",@"我的相册",@"我的俱乐部"/*,@"我的管家服务"*/];
    for (int i=0; i<icons.count; i++) {
        CostomButton *btn = [[CostomButton alloc] initWithFrame:CGRectMake(i * width+SIZE(15), SIZE(360)-SIZE(70)-SIZE(15), width, SIZE(70))];
        btn.imageName = icons[i];
        btn.textLable = titles[i];
        [btn setTitleColor:RGB(0x66, 0x66, 0x66) forState:UIControlStateNormal];
        [self addSubview:btn];
        
        btn.tag = i+103;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


-(void)setIsCounlor:(BOOL)isCounlor{
    _isCounlor = isCounlor;
    if (_isCounlor) {
        //顾问
        orderBtn.hidden = YES;
        collectBtn.hidden = YES;
    }else{
        orderBtn.hidden = NO;
        collectBtn.hidden = NO;
    }
}

- (void )clickBtn:(UIButton *)send{
    if (self.otherBtnClickBlock) {
        self.otherBtnClickBlock(send.tag-100);
    }
}

- (void)gotoMyInfo:(UITapGestureRecognizer *)recognizer {
    if (self.InfoBlock) {
        self.InfoBlock();
    }
}

-(void)setPersonalModel:(CSPersonalInfoModel *)personalModel{
    _personalModel = personalModel;
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:_personalModel.headImg] placeholderImage:[UIImage imageNamed:@"counselor"]];
    nickNameLabel.text = isEmptyStr(_personalModel.name)?_personalModel.mobile:_personalModel.name;
    desLabel.text = isEmptyStr(_personalModel.registerDay)?@"在莱瘦的第0天":[NSString stringWithFormat:@"在莱瘦的第%@天",_personalModel.registerDay];
    
    [orderBtn setTitle:[NSString stringWithFormat:@"%@\n订单",isEmptyStr(_personalModel.indentNumber)?@"0":_personalModel.indentNumber] forState:UIControlStateNormal];
//    [editNumLabel setTitle:[NSString stringWithFormat:@"%@\n发表",isEmptyStr(_personalModel.name)?@"0":_personalModel.name] forState:UIControlStateNormal];
    [collectBtn setTitle:[NSString stringWithFormat:@"%@\n收藏",isEmptyStr(_personalModel.collectNumber)?@"0":_personalModel.collectNumber] forState:UIControlStateNormal];
    
}
#pragma mark - click
-(void)orderBtnClick:(UIButton *)sender {
    
    if (self.OrderBlock) {
        self.OrderBlock();
    }
}


@end
