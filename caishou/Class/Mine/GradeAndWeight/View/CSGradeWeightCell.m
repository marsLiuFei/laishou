//
//  CSGradeWeightCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSGradeWeightCell.h"

@interface CSGradeWeightCell ()
{
    UILabel *_titleLabel;
    UILabel *_subLabel;
}

@end

@implementation CSGradeWeightCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"体重100kg" textColor:RGB(70, 210, 127) textAlignment:Left font:RegularFont(14)];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.centerY.offset(0);
    }];
    _subLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"2019-03-20 23:46:55" textColor:RGB(102,102,102) textAlignment:Right font:MediumFont(12)];
    [self.contentView addSubview:_subLabel];
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.centerY.offset(0);
    }];
}
- (void)setModel:(CSGradeWeightModel *)model {
    _model = model;
    _titleLabel.text = [NSString stringWithFormat:@"体重%.2lfkg" , model.weight];
    _subLabel.text = model.strCreateTime;
}
@end
