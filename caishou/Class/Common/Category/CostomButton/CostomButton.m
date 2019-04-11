//
//  CostomButton.m
//  NiuNiuJieBa
//
//  Created by 陈舟为 on 2017/2/27.
//  Copyright © 2017年 DaveChen. All rights reserved.
//

#import "CostomButton.h"

@interface CostomButton ()

@end

@implementation CostomButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self =  [super initWithFrame:frame] ) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
//            make.height.width.offset(SIZE(27));
            make.top.offset(8);
        }];

        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:13];
        _titleLable.textAlignment = 1;
        _titleLable.textColor = RGB(110,110,110);
        [self addSubview:_titleLable];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.top.mas_equalTo(self.imgView.mas_bottom).offset(0);
            make.bottom.offset(0);
        }];
        
        _countLab = [[UILabel alloc] init];
        _countLab.layer.masksToBounds = YES;
        _countLab.textAlignment = NSTextAlignmentCenter;
        _countLab.textColor = [UIColor whiteColor];
        _countLab.font = [UIFont systemFontOfSize:10];
        [self addSubview:_countLab];
        [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(SIZE(14));
            make.centerX.mas_equalTo(self.imgView.mas_right).offset(0);
            make.centerY.mas_equalTo(self.imgView.mas_top).offset(5);
            make.height.offset(SIZE(14));
        }];
        _countLab.hidden = YES;
    }
    
    return self;
    
}

-(void)setTextLable:(NSString *)textLable{
    
    _textLable = textLable;
    _titleLable.adjustsFontSizeToFitWidth = YES;
    _titleLable.text = textLable;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"login_logo"]];
}

-(void)setImageName:(NSString *)imageName{
    
    _imageName = imageName;
    _imgView.image = [UIImage imageNamed:imageName];
}

-(void)setCount:(NSInteger)count{
        
    _count = count;
    _countLab.hidden =count?NO:YES;
    _countLab.text = [NSString stringWithFormat:@"%ld",count];
    _countLab.backgroundColor = RedColor;
    _countLab.layer.masksToBounds = YES;
    _countLab.layer.cornerRadius  = SIZE(7);
    [_countLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_greaterThanOrEqualTo(SIZE(14));
        make.centerX.mas_equalTo(self.imgView.mas_right).offset(0);
        make.centerY.mas_equalTo(self.imgView.mas_top).offset(5);
        make.height.offset(SIZE(14));
    }];
}

- (NSInteger)nsinterLength:(NSInteger)x {
    NSInteger sum=0,j=1;
    while( x >= 1 ) {
        x=x/10;
        sum++;
        j=j*10;
    }
    return sum;
}


@end
