//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//  CSShareArticleViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSShareArticleViewController.h"

@interface CSShareArticleViewController ()

@end

@implementation CSShareArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"noData"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(SIZE(-60));
        make.width.offset(SIZE(180));
        make.height.offset(SIZE(120));
    }];
    UILabel *label = [[UILabel alloc] init];
    label.text= @"暂无数据";
    label.textColor = RGB(102, 102, 102);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(SIZE(20));
        make.height.offset(SIZE(21));
        make.centerX.offset(0);
        make.width.offset(SIZE(80));
    }];
    
}


@end
