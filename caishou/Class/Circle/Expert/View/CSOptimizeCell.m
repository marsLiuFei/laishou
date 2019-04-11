//
//  CSOptimizeCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSOptimizeCell.h"

@implementation CSOptimizeCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.contentView.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    self.icon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}
-(void)setSevereUserModel:(CSSevereUserPageModel *)severeUserModel{
    _severeUserModel = severeUserModel;
    if ([_severeUserModel.headImg hasPrefix:@"http"]) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:_severeUserModel.headImg] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    }else{
        self.icon.image = [UIImage imageNamed:@"popup_img"];
    }
    
}

@end
