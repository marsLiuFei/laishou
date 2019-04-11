//
//  CSSignUpPeopleIconCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSignUpPeopleIconCell.h"

@implementation CSSignUpPeopleIconCell
{
    UIImageView *headerIcon;
    UILabel *nameLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = WhiteColor;
        headerIcon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"counselor"];
        headerIcon.layer.masksToBounds = YES;
        headerIcon.layer.cornerRadius = SIZE(25);
        [self.contentView addSubview:headerIcon];
        [headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(SIZE(5));
            make.width.height.offset(SIZE(50));
        }];
        
        nameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"李大嘴" textColor:RGB(102, 102, 102) textAlignment:Center font:FONT(12)];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.mas_equalTo(self->headerIcon.mas_bottom).offset(SIZE(5));
        }];
        
    }
    return self;
}

- (void )setTitle:(NSString *)title imageName:(NSString *)imageName{
    headerIcon.image = [UIImage imageNamed:imageName];
    nameLabel.text = title;
}
-(void)setMemberModel:(CSMemberInfoModel *)memberModel{
    _memberModel = memberModel;
    if ([_memberModel.headImg hasPrefix:@"http"]) {
        [headerIcon sd_setImageWithURL:[NSURL URLWithString:_memberModel.headImg] placeholderImage:[UIImage imageNamed:@"counselor"]];
    }else{
        headerIcon.image = [UIImage imageNamed:@"counselor"];
    }
    nameLabel.text = isEmptyStr(_memberModel.name)?@"匿名":_memberModel.name;
}


@end
