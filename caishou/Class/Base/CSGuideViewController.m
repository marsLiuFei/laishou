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
//  CSGuideViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/30.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSGuideViewController.h"
#import "CSBaseTabbarController.h"

@interface CSGuideViewController ()<UIScrollViewDelegate>
{
    
    UIScrollView *_scrolV;
    NSArray *_imageArr;
}
@end

@implementation CSGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
}
- (void)initData{
    _imageArr = [NSMutableArray arrayWithObjects:@"guide_image",@"viewer_icon", nil];
}

- (void)createUI
{
    [self scrollViewShow];
    
}
- (void)scrollViewShow
{
    _scrolV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrolV.contentSize = CGSizeMake(SCREEN_WIDTH*_imageArr.count, SCREEN_HEIGHT);
    _scrolV.showsVerticalScrollIndicator = NO;
    _scrolV.bounces = NO;
    _scrolV.pagingEnabled = YES;
    _scrolV.delegate = self;
    _scrolV.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_scrolV];
    for (int i = 0; i < _imageArr.count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _scrolV.frame.size.width, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imgView.tag = i;
        imgView.userInteractionEnabled = YES;
        imgView.image = [UIImage imageNamed:_imageArr[i]];
        [_scrolV addSubview:imgView];
        if (i == _imageArr.count -1) {
            //在最后一页添加按钮跳转
            UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //    [startBtn setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
//            startBtn.backgroundColor = [UIColor redColor];
            [startBtn addTarget:self action:@selector(starrtClick) forControlEvents:UIControlEventTouchUpInside];
            [imgView addSubview:startBtn];
            [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.bottom.offset(-SafeAreaHeight-SIZE(20));
                make.width.offset(SIZE(200));
                make.height.offset(SIZE(60));
            }];
        }
     
    }
   
    
}

- (void)starrtClick
{
  [UIApplication sharedApplication].keyWindow.rootViewController = [[CSBaseTabbarController alloc]init];
    
}



@end
