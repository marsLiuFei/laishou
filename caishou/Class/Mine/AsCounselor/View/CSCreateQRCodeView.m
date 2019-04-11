//
//  CSCreateQRCodeView.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCreateQRCodeView.h"

@interface CSCreateQRCodeView ()
{
    UIImageView *_qrCodeImageView;
}

@end

@implementation CSCreateQRCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}
- (void)setupUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.alpha = 0.7;
    bgView.backgroundColor = BlackColor;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    UIView *centerView = [[UIView alloc] init];
    centerView.backgroundColor = WhiteColor;
    centerView.clipsToBounds = true;
    centerView.layer.cornerRadius = 10;
    [self addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(SIZE(251));
        make.height.offset(SIZE(277));
        make.centerX.offset(0);
        make.centerY.offset(SIZE(-60));
    }];
    UILabel *hintLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"扫码绑定我" textColor:RGB(102, 102, 102) textAlignment:Center font:RegularFont(14)];
    [centerView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SIZE(56));
        make.height.offset(SIZE(15));
        make.left.right.offset(0);
    }];
   _qrCodeImageView = [[UIImageView alloc] init];
    [centerView addSubview:_qrCodeImageView];
    [_qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(hintLabel.mas_bottom).offset(19);
        make.width.height.offset(SIZE(134));
    }];
    UIButton *removeBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) normalImage:@"close" selectedImage:@"close" touchUpInsideEvent:nil];
    [self addSubview:removeBtn];
    [removeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(centerView.mas_bottom).offset(SIZE(30));
        make.width.height.offset(SIZE(29));
    }];
}
- (void)closeView {
    [self removeFromSuperview];
}
- (void)setCodeStr:(NSString *)codeStr {
    _codeStr = codeStr;
    NSDictionary *dic = @{@"counselorId":codeStr};
    NSError *error;
    NSData *jsonData= [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if (!error) {
         UIImage *codeImage = [SGQRCodeObtain generateQRCodeWithData:[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding] size:SIZE(134) logoImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.headImageUrl]]] ratio:0.3];    _qrCodeImageView.image = codeImage;
    }

}

@end
