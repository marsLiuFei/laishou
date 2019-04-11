//
//  CSLikeTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/4.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSLikeTableViewCell.h"

@interface CSLikeTableViewCell ()
{
    UIImageView *_leftImageView;
    UILabel *_titleLabel;
}
/** array */
@property(nonatomic , strong)NSMutableArray *btns;

@end

@implementation CSLikeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WhiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        
    }
    return self;
}
#pragma mark - setupUI
- (void)setupUI {
    _leftImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"name"];
    [self.contentView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.offset(SIZE(22));
        make.width.height.mas_equalTo(SIZE(17));
    }];
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"个人喜好" textColor:RGB(102, 102, 102) textAlignment:Left font:MediumFont(16)];
    _titleLabel.numberOfLines = 2;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self -> _leftImageView.mas_right).offset(SIZE(13));
        make.width.offset(SIZE(120));
        make.height.offset(SIZE(21));
        make.top.mas_equalTo(SIZE(22));
    }];
  
}
- (void)setupLikeBtn:(NSArray *)arrs model:(CSInfoModel *)model  {
    for (int i = 0; i < arrs.count; i++) {
        UIButton *button = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:arrs[i] titleColor:WhiteColor font:RegularFont(14) backgroundColor:RGB(153, 153, 153) touchUpInsideEvent:nil];
        [self.contentView addSubview:button];
        button.clipsToBounds = true;
        button.layer.cornerRadius = 5;
        button.tag = 1000 +i;
        for (NSString *title in [model.selectTag componentsSeparatedByString:@","]) {
            if ([title isEqualToString:arrs[i]]) {
                button.selected = true;
                [button setBackgroundColor: RGB(67, 207, 124)];
            }
        }
        [self.btns addObject:button];
        [button addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(SIZE(25));
            make.left.mas_equalTo(self ->_titleLabel.mas_right).offset(i%3 * (SIZE(50) + SIZE(13)));
            make.top.mas_equalTo(SIZE(19) + (i/3 * (SIZE(25)+SIZE(19))));
            make.width.mas_equalTo(SIZE(50));
        }];
        
    }
}
- (void)setModel:(CSInfoModel *)model {
    _model = model;
    _leftImageView.image = [UIImage imageNamed:model.iconStr];
    _titleLabel.text = model.title;
     self.btns = [NSMutableArray array];
    [self setupLikeBtn:model.subArr model:model];
}

- (void)likeBtnClick:(UIButton *)sender {
    self.model.selectTag = @"";
    sender.selected = !sender.selected;
    for (UIButton *btn in self.btns) {
        if (btn.isSelected) {
            self.model.selectTag = [NSString stringWithFormat:@"%@%@,", self.model.selectTag,btn.titleLabel.text];
        }
        if (sender.tag == btn.tag) {
            if (btn.isSelected) {
                [sender setBackgroundColor: RGB(67, 207, 124)];
            }else {
                [btn setBackgroundColor:RGB(153, 153, 153)];
            }
            break;
        }
    }
}


@end
