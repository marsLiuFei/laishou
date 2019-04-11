//
//  CSLoseWeightCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSLoseWeightCell.h"

@implementation CSLoseWeightCell

{
    UIButton *jianfeiBtn;//减肥
    UIButton *jianzhiBtn;//减脂
    UILabel *nowWeightLabel;//当前体重
    UILabel *wanaWeightLabel;//目标体重
    UIButton *startBtn;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WhiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    jianfeiBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"减肥" titleColor:BlackColor font:MediumFont(SIZE(16)) backgroundColor:ClearColor touchUpInsideEvent:nil];
    [jianfeiBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"减肥" attributes:@{NSFontAttributeName:MediumFont(SIZE(16))}] forState:UIControlStateSelected];
    [jianfeiBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"减肥" attributes:@{NSFontAttributeName:RegularFont(SIZE(16))}] forState:UIControlStateNormal];
    jianfeiBtn.selected = YES;
    jianfeiBtn.tag = 10010;
    [jianfeiBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:jianfeiBtn];
    [jianfeiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(SIZE(15));
        make.width.offset(SIZE(60));
        make.height.offset(SIZE(20));
    }];
    
    jianzhiBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"减脂" titleColor:BlackColor font:RegularFont(SIZE(16)) backgroundColor:ClearColor touchUpInsideEvent:nil];
    jianzhiBtn.hidden = YES;
    [jianzhiBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"减脂" attributes:@{NSFontAttributeName:MediumFont(SIZE(16))}] forState:UIControlStateSelected];
    [jianzhiBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"减脂" attributes:@{NSFontAttributeName:RegularFont(SIZE(16))}] forState:UIControlStateNormal];
    jianzhiBtn.selected = NO;
    jianzhiBtn.tag = 10011;
    [jianzhiBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:jianzhiBtn];
    [jianzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SIZE(15));
        make.left.mas_equalTo(self->jianfeiBtn.mas_right).offset(SIZE(10));
        make.width.offset(SIZE(60));
        make.height.offset(SIZE(20));
    }];
    
    nowWeightLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"100kg\n当前体重" textColor:RGBA(237, 130, 32, 1) textAlignment:Left font:FONT(16)];
    nowWeightLabel.numberOfLines = 2;
    [self.contentView addSubview:nowWeightLabel];
    [nowWeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.width.offset(SIZE(90));
        make.top.mas_equalTo(self->jianfeiBtn.mas_bottom).offset(SIZE(10));
        make.bottom.offset(-SIZE(10));
    }];
    
    wanaWeightLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"100kg\n当前体重" textColor:RGBA(237, 130, 32, 1) textAlignment:Left font:FONT(16)];
    wanaWeightLabel.numberOfLines = 2;
    [self.contentView addSubview:wanaWeightLabel];
    [wanaWeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->nowWeightLabel.mas_right).offset(SIZE(10));
        make.width.offset(SIZE(90));
        make.top.mas_equalTo(self->jianfeiBtn.mas_bottom).offset(SIZE(10));
        make.bottom.offset(-SIZE(10));
    }];
    
    
    startBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"开始减肥" titleColor:WhiteColor font:FONT(16) backgroundColor:MainColor touchUpInsideEvent:nil];
    startBtn.layer.masksToBounds = YES;
    startBtn.layer.cornerRadius = SIZE(15);
    [self.contentView addSubview:startBtn];
    [startBtn addTarget:self action:@selector(loseFatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-SIZE(15));
        make.width.offset(SIZE(100));
        make.height.offset(SIZE(30));
    }];
    
    UILabel *la = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"不积跬步无以至千里" textColor:RGB153 textAlignment:Center font:FONT(10)];
    [self.contentView addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->startBtn.mas_bottom).offset(SIZE(5));
        make.centerX.mas_equalTo(self->startBtn.mas_centerX).offset(0);
    }];
    
}
//开始减肥按钮被点击
- (void )loseFatBtnClick{
    if (self.loseFatBtnClickBlock) {
        self.loseFatBtnClickBlock();
    }
}



- (void )clickBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 10010:
        {
            jianfeiBtn.selected = YES;
            jianzhiBtn.selected = NO;
            
            NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@kg\n",isEmptyStr(_personalModel.weight)?@"0":_personalModel.weight] attributes:@{NSFontAttributeName:MediumFont(SIZE(16)),NSForegroundColorAttributeName:RGBA(237, 130, 32, 1)}];
            NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:@"当前体重" attributes:@{NSFontAttributeName:RegularFont(SIZE(16)),NSForegroundColorAttributeName:RGB102}];
            [attri1 appendAttributedString:attri2];
            nowWeightLabel.attributedText = attri1;
            
            NSMutableAttributedString *attri3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@kg\n",isEmptyStr(_personalModel.targetWeight)?@"0":_personalModel.targetWeight] attributes:@{NSFontAttributeName:MediumFont(SIZE(16)),NSForegroundColorAttributeName:RGBA(67, 207, 124, 1)}];
            NSMutableAttributedString *attri4 = [[NSMutableAttributedString alloc] initWithString:@"目标体重" attributes:@{NSFontAttributeName:RegularFont(SIZE(16)),NSForegroundColorAttributeName:RGB102}];
            [attri3 appendAttributedString:attri4];
            wanaWeightLabel.attributedText = attri3;
        }
            break;
        case 10011:
        {
            jianfeiBtn.selected = NO;
            jianzhiBtn.selected = YES;
            NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%\n",isEmptyStr(_personalModel.fatRate)?@"0":[NSString stringWithFormat:@"%.2lf",[_personalModel.fatRate floatValue]]] attributes:@{NSFontAttributeName:MediumFont(SIZE(16)),NSForegroundColorAttributeName:RGBA(237, 130, 32, 1)}];
            NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:@"减脂率" attributes:@{NSFontAttributeName:RegularFont(SIZE(16)),NSForegroundColorAttributeName:RGB102}];
            [attri1 appendAttributedString:attri2];
            nowWeightLabel.attributedText = attri1;
            
            NSMutableAttributedString *attri3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%\n",isEmptyStr(_personalModel.bmi)?@"0":_personalModel.bmi] attributes:@{NSFontAttributeName:MediumFont(SIZE(16)),NSForegroundColorAttributeName:RGBA(67, 207, 124, 1)}];
            NSMutableAttributedString *attri4 = [[NSMutableAttributedString alloc] initWithString:@"BMI" attributes:@{NSFontAttributeName:RegularFont(SIZE(16)),NSForegroundColorAttributeName:RGB102}];
            [attri3 appendAttributedString:attri4];
            wanaWeightLabel.attributedText = attri3;
        }
            break;
            
        default:
            break;
    }
}

-(void)setPersonalModel:(CSPersonalInfoModel *)personalModel{
    _personalModel = personalModel;
    if (jianfeiBtn.selected) {
        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@kg\n",isEmptyStr(_personalModel.weight)?@"0":[NSString stringWithFormat:@"%.2lf",[_personalModel.weight floatValue]]] attributes:@{NSFontAttributeName:MediumFont(SIZE(16)),NSForegroundColorAttributeName:RGBA(237, 130, 32, 1)}];
        NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:@"当前体重" attributes:@{NSFontAttributeName:RegularFont(SIZE(16)),NSForegroundColorAttributeName:RGB102}];
        [attri1 appendAttributedString:attri2];
        nowWeightLabel.attributedText = attri1;
        
        NSMutableAttributedString *attri3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@kg\n",isEmptyStr(_personalModel.targetWeight)?@"0":[NSString stringWithFormat:@"%.2lf",[_personalModel.targetWeight floatValue]]] attributes:@{NSFontAttributeName:MediumFont(SIZE(16)),NSForegroundColorAttributeName:RGBA(67, 207, 124, 1)}];
        NSMutableAttributedString *attri4 = [[NSMutableAttributedString alloc] initWithString:@"目标体重" attributes:@{NSFontAttributeName:RegularFont(SIZE(16)),NSForegroundColorAttributeName:RGB102}];
        [attri3 appendAttributedString:attri4];
        wanaWeightLabel.attributedText = attri3;
    }
    else{
        
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
