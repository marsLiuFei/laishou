//
//  CSSignUpPeopleListCell.m
//  caishou
//
//  Created by 刘布斯 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSignUpPeopleListCell.h"

@implementation CSSignUpPeopleListCell
{
    UIImageView *headerImageView;
    UILabel *nameLabel;
    UILabel *timeLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    headerImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"counselor"];
    headerImageView.layer.masksToBounds = YES;
    headerImageView.layer.cornerRadius = SIZE(25);
    [self.contentView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(SIZE(15));
        make.width.height.offset(SIZE(50));
    }];
    
    nameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"李大胆" textColor:RGB102 textAlignment:Left font:FONT(14)];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.mas_equalTo(self->headerImageView.mas_right).offset(SIZE(20));
    }];
    
    
    timeLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"9小时" textColor:RGB153 textAlignment:Right font:FONT(10)];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-SIZE(10));
    }];
    
    UIView *line = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(234, 234, 234)];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.right.offset(-SIZE(15));
        make.height.offset(SIZE(0.5));
        make.bottom.offset(0);
    }];
}
-(void)setMemberModel:(CSMemberListModel *)memberModel{
    _memberModel = memberModel;
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:_memberModel.headImg] placeholderImage:[UIImage imageNamed:@"counselor"]];
    nameLabel.text = isEmptyStr(_memberModel.mobile)?@"":_memberModel.mobile;
    timeLabel.text = isEmptyStr(_memberModel.strSignTime)?@"":_memberModel.strSignTime;
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
