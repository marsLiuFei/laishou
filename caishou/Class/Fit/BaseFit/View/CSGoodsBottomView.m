//
//  CSGoodsBottomView.m
//  caishou
//
//  Created by 刘飞 on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSGoodsBottomView.h"

@implementation CSGoodsBottomView

{
    UIButton *groupPurchaseBtn;//团购按钮
    UIButton *originalPriceBuyBtn;//    参与拼团
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    groupPurchaseBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"¥6.99\n发起拼团" titleColor:WhiteColor font:MediumFont(15) backgroundColor:MainColor touchUpInsideEvent:nil];
    groupPurchaseBtn.tag = 10013;
    [groupPurchaseBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    groupPurchaseBtn.titleLabel.numberOfLines = 2;
    groupPurchaseBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:groupPurchaseBtn];
    [groupPurchaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.width.offset(SIZE(150));
    }];
    
    originalPriceBuyBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"参与拼团" titleColor:WhiteColor font:MediumFont(15) backgroundColor:RGBA(67, 207, 124, 1) touchUpInsideEvent:nil];
    originalPriceBuyBtn.hidden = YES;
    originalPriceBuyBtn.tag = 10014;
    [originalPriceBuyBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    originalPriceBuyBtn.titleLabel.numberOfLines = 2;
    originalPriceBuyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:originalPriceBuyBtn];
    [originalPriceBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->groupPurchaseBtn.mas_left).offset(0);
        make.top.bottom.offset(0);
        make.width.offset(SIZE(100));
    }];
    
    
    
    CGFloat width = (SCREEN_WIDTH-SIZE(200))/3.f;
    NSArray *icons  = @[@"benifit_home",@"benifit_collect",@"benifit_service"];
    NSArray *titles = @[@"首页",@"收藏",@"客服"];
    for (int i=0; i<icons.count; i++) {
        CostomButton *btn = [[CostomButton alloc] initWithFrame:CGRectMake(i * width,0, width, SIZE(50))];
        btn.imageName = icons[i];
        btn.textLable = titles[i];
        [btn setTitleColor:RGB153 forState:UIControlStateNormal];
        [self addSubview:btn];
        
        if (i!=0) {
            btn.hidden = YES;
        }
        btn.tag = i+10010;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)setIsShowJoinBtn:(BOOL)isShowJoinBtn{
    _isShowJoinBtn = isShowJoinBtn;
    if (_isShowJoinBtn) {
        originalPriceBuyBtn.hidden = NO;
    }else{
        originalPriceBuyBtn.hidden = YES;
    }
    
}
- (void )clickBtn:(UIButton *)sender{
    if (self.clickBtkBlock) {
        self.clickBtkBlock(sender.tag-10010);
    }
}

-(void)setSpellGoodsModel:(CSSpellGoodsDetailModel *)spellGoodsModel{
    _spellGoodsModel = spellGoodsModel;
    [groupPurchaseBtn setTitle:[NSString stringWithFormat:@"¥%@\n发起拼团",isEmptyStr(_spellGoodsModel.totalPrice)?@"0.00":_spellGoodsModel.totalPrice] forState:UIControlStateNormal];
//    [originalPriceBuyBtn setTitle:[NSString stringWithFormat:@"¥%@\n原价购买",isEmptyStr(_spellGoodsModel.rawPrice)?@"0.00":_spellGoodsModel.rawPrice] forState:UIControlStateNormal];
    
//    CostomButton *btn = (CostomButton *)[self viewWithTag:10011];
//    btn.imageName = [_spellGoodsModel.isCollect isEqualToString:@"1"]?@"benifit_collected":@"benifit_collect";
}

@end
