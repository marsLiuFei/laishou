//
//  CSWalkRecordTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/12.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSWalkRecordTableViewCell.h"
#import "NSDate+HKDate.h"


@interface CSWalkRecordTableViewCell ()
{
    UILabel *_todayLabel;
    UILabel *_yesterdayLabel;
}

@end


@implementation CSWalkRecordTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}
#pragma mark - setupUI;
- (void)setupUI {
    UIView *lineView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(67, 207, 124)];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.offset(SIZE(15));
        make.width.offset(SIZE(2));
        make.height.offset(SIZE(15));
    }];
    UILabel *recordLabel  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"步数记录" textColor:RGB(53, 60, 54) textAlignment:NSTextAlignmentLeft font:MediumFont(16)];
    [self.contentView addSubview:recordLabel];
    [recordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_top).offset(SIZE(-4));
        make.left.mas_equalTo(lineView.mas_right).offset(5);
        make.height.offset(SIZE(21));
        make.right.offset(0);
    }];
    UILabel *firstLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"今天您走了" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:RegularFont(12)];
    [self.contentView addSubview:firstLabel];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SIZE(21));
        make.left.mas_equalTo(SIZE(16));
        make.bottom.offset(SIZE(-15));
    }];
    
    _todayLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"11581" textColor:RGB(67, 207, 124) textAlignment:NSTextAlignmentLeft font:MediumFont(18)];
    [self.contentView addSubview:_todayLabel];
    [_todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SIZE(21));
        make.left.mas_equalTo(firstLabel.mas_right);
        make.bottom.offset(SIZE(-15));
    }];
    UILabel *secondLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"步，比昨天多走了" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:RegularFont(12)];
    [self.contentView addSubview:secondLabel];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SIZE(21));
        make.left.mas_equalTo(self ->_todayLabel.mas_right);
        make.bottom.offset(SIZE(-15));
    }];
    _yesterdayLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"4588" textColor:RGB(67, 207, 124) textAlignment:NSTextAlignmentLeft font:MediumFont(16)];
    [self.contentView addSubview:_yesterdayLabel];
    [_yesterdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SIZE(21));
        make.left.mas_equalTo(secondLabel.mas_right);
        make.bottom.offset(SIZE(-15));
    }];
    UILabel *threeLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"步，继续保持哦！" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:RegularFont(12)];
    [self.contentView addSubview:threeLabel];
    [threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SIZE(21));
        make.left.mas_equalTo(self ->_yesterdayLabel.mas_right);
        make.bottom.offset(SIZE(-15));
    }];
    [self getStepCount];
    
}
- (void)getStepCount {
    id value =  [UDefault getValue:@"health"];
    if ([value isKindOfClass:[NSString class]]) {
        return;
    }
    NSDictionary *dic = (NSDictionary *)value;
    NSString *key1 = [NSDate HK_getNewTimeFormat:@"yyyy-MM-dd" date:[NSDate HK_dateAfterDate:[NSDate date] day:-1]];
    NSString *key = [NSDate HK_getNewTimeFormat:@"yyyy-MM-dd" date:[NSDate date]];
    NSNumber *count = dic[key];
    NSNumber *count1 = dic[key1];
    _todayLabel.text = [NSString stringWithFormat:@"%ld" , [count integerValue]];
    _yesterdayLabel.text = [NSString stringWithFormat:@"%ld" , [count integerValue] - [count1 integerValue]];
}

@end
 
