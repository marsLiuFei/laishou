//
//  CSSignHeaderView.m
//  caishou
//
//  Created by 刘布斯 on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSignHeaderView.h"
#import "CSSignDoneFlowCell.h"

@interface CSSignHeaderView ()
<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

{
    UIView *topBgView;
    UIView *contentBgView;
    UIButton *signBtn;
    UILabel *nowIntergralLabel;//当前积分
    
}
/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
@end

@implementation CSSignHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self creatUI];
        
        
    }
    return self;
}


- (void )creatUI{
    BOOL isPhoneX = [[UIApplication sharedApplication] statusBarFrame].size.height>20;
    topBgView = [ViewCreate createLineFrame:isPhoneX?CGRectMake(0, 0, SCREEN_WIDTH, SIZE(299)):CGRectMake(0, 0, SCREEN_WIDTH, SIZE(275)) backgroundColor:[UIColor TF_gradientFromColor:RGB(252, 101, 80) toColor:RGB(254, 139, 82) withSize:CGSizeMake(1, SIZE(275))]];
    [self addSubview:topBgView];
    
    
    nowIntergralLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"当前莱币：520" textColor:WhiteColor textAlignment:Left font:RegularFont(14)];
    [self addSubview:nowIntergralLabel];
    [nowIntergralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        if (isPhoneX) {
            make.top.offset(SIZE(94));
        }else{
            make.top.offset(SIZE(70));
        }
        
    }];
    
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.mas_equalTo(self->nowIntergralLabel.mas_bottom).offset(SIZE(5));
        make.height.offset(SIZE(60));
        make.right.offset(-SIZE(15));
    }];
    
    signBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"签到获取莱币" titleColor:RGBA(253, 114, 81, 1) font:RegularFont(15) backgroundColor:RGBA(254, 237, 95, 1) touchUpInsideEvent:nil];
    signBtn.layer.masksToBounds = YES;
    signBtn.layer.cornerRadius = SIZE(15);
    [topBgView addSubview:signBtn];
    signBtn.tag = 10000;
    [signBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(SIZE(30));
        make.width.offset(SIZE(144));
        make.height.offset(SIZE(30));
    }];
    
    UIView *bottomView = [ViewCreate createLineFrame:CGRectMake(0, isPhoneX?SIZE(299):SIZE(275), SCREEN_WIDTH, SIZE(105)) backgroundColor:WhiteColor];
    [self addSubview:bottomView];
    
    
    UIView *titleBgView = [ViewCreate createLineFrame:CGRectMake(0, SIZE(65), SCREEN_WIDTH , SIZE(40)) backgroundColor:RGBA(238, 238, 238, 1)];
    [bottomView addSubview:titleBgView];
   
    UILabel *titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"大家都在兑" textColor:RGBA(252, 101, 80, 1) textAlignment:Center font:MediumFont(14)];
    [titleBgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
    }];
    
    UIView *leftLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGBA(252, 101, 80, 1)];
    [bottomView addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(SIZE(1));
        make.left.offset(SIZE(15));
        make.right.mas_equalTo(titleLabel.mas_left).offset(-SIZE(20));
        make.centerY.mas_equalTo(titleLabel.mas_centerY).offset(0);
    }];
    
    UIView *rightLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGBA(252, 101, 80, 1)];
    [bottomView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(SIZE(1));
        make.right.offset(-SIZE(15));
        make.left.mas_equalTo(titleLabel.mas_right).offset(SIZE(20));
        make.centerY.mas_equalTo(titleLabel.mas_centerY).offset(0);
    }];
    
    
    
    contentBgView = [ViewCreate createLineFrame:CGRectMake(SIZE(15),isPhoneX?SIZE(259):SIZE(235), SCREEN_WIDTH-SIZE(30), SIZE(70)) backgroundColor:WhiteColor];
    contentBgView.layer.cornerRadius = 5;
    contentBgView.layer.shadowColor = [UIColor colorWithRed:214.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.35f].CGColor;
    contentBgView.layer.shadowOffset = CGSizeMake(0, 3);
    contentBgView.layer.shadowOpacity = 1;
    contentBgView.layer.shadowRadius = 4.0;
    [self addSubview:contentBgView];
    
    
    CGFloat width = (SCREEN_WIDTH-SIZE(30))/4.f;
    NSArray *icons  = @[@"sign_icon01",@"sign_icon02",@"sign_icon03",@"sign_icon04"];
    NSArray *titles = @[@"参加活动",@"分享文章",@"莱拼团",@"积分兑换"];
    for (int i=0; i<icons.count; i++) {
        CostomButton *btn = [[CostomButton alloc] initWithFrame:CGRectMake(i * width,SIZE(5), width, SIZE(60))];
        btn.imageName = icons[i];
        btn.textLable = titles[i];
        [btn setTitleColor:RGB153 forState:UIControlStateNormal];
        [contentBgView addSubview:btn];
        
        btn.tag = i+10010;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    
    
    
    
}



-(void)setIntegralSignDetailModel:(CSIntegralSignDetailModel *)IntegralSignDetailModel{
    _IntegralSignDetailModel = IntegralSignDetailModel;
    if (_IntegralSignDetailModel.dayIsSign) {
        [signBtn setTitle:@"今日已签到" forState:UIControlStateNormal];
        signBtn.userInteractionEnabled = NO;
        signBtn.backgroundColor = RGB(199, 199, 199);
        [signBtn setTitleColor:RGB153 forState:UIControlStateNormal];
    }
    nowIntergralLabel.text = isEmptyStr(_IntegralSignDetailModel.integral)?@"":[NSString stringWithFormat:@"当前积分：%@",_IntegralSignDetailModel.integral];
    [self.collectionView reloadData];
}

- (void )clickBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 10000:
        {
            //签到
            if (self.signBtnClickBlock) {
                self.signBtnClickBlock();
            }
        }
            break;
        case 10010:
        {
            //活动
            if (self.activityBtnClickBlock) {
                self.activityBtnClickBlock();
            }
        }
            break;
        case 10011:
        {
            //文章
            if (self.articleBtnClickBlock) {
                self.articleBtnClickBlock();
            }
        }
            break;
        case 10012:
        {
            //拼团
            if (self.groupBtnClickBlock) {
                self.groupBtnClickBlock();
            }
        }
            break;
        case 10013:
        {
            //兑换
            if (self.convertBtnClickBlock) {
                self.convertBtnClickBlock();
            }
        }
            break;
        default:
            break;
    }
}






#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat width = (SCREEN_WIDTH-SIZE(30))/6.f;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
        layout.itemSize = CGSizeMake(width, SIZE(60));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[CSSignDoneFlowCell class] forCellWithReuseIdentifier:@"CSSignDoneFlowCell"];
    }
    return _collectionView;
}
#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.IntegralSignDetailModel.signLogList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CSSignDoneFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSSignDoneFlowCell" forIndexPath:indexPath];
    cell.signModel = self.IntegralSignDetailModel.signLogList[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}




@end
