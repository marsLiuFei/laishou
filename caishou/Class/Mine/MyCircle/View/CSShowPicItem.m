//
//  CSShowPicItem.m
//  caishou
//
//  Created by 刘飞 on 2019/3/12.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSShowPicItem.h"

@implementation CSShowPicItem

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    self.showImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
    [self.contentView addSubview:self.showImageView];
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    if ([_imageName hasPrefix:@"http"]) {
        [_showImageView sd_setImageWithURL:[NSURL URLWithString:_imageName]];
    }else{
        _showImageView.image = [UIImage imageNamed:_imageName];
    }
}

@end
