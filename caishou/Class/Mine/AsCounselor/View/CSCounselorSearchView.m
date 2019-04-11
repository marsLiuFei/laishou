//
//  CSCounselorSearchView.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorSearchView.h"

@implementation CSCounselorSearchView
- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}
- (void)setupUI {
    UIView *topView = [[UIView alloc] init];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_top).offset(SafeAreaHeight);
    }];
    UIView *searchView = [[UIView alloc] init];
    searchView.layer.masksToBounds = true;
    searchView.layer.cornerRadius = (self.viewHeight-SafeAreaHeight - 14) / 2;
    searchView.backgroundColor = RGB(243, 243, 243);
    [topView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.bottom.mas_equalTo(-7);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    UIImageView *searchImage = [[UIImageView alloc] init];
    searchImage.image = [UIImage imageNamed:@"searchIcon"];
    [searchView addSubview:searchImage];
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-7);
        make.top.mas_equalTo(7);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(searchImage.mas_height);
    }];
    UITextField *searchField = [[UITextField alloc] init];
    searchField.placeholder = @"搜索";
    [searchField addTarget:self action:@selector(inputChange:) forControlEvents:UIControlEventEditingDidBegin];
    [searchView addSubview:searchField];
    [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(searchImage.mas_right).offset(5);
        make.right.mas_equalTo(-20);
    }];
    
}

#pragma mark - click
- (void)inputChange:(UITextField *)field {
    field.text = @"";
    [self endEditing:true];
    if (self.chooseSiteBtnClickBlock) {
        self.chooseSiteBtnClickBlock();
    }
}

@end
