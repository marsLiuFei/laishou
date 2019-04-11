//
//  CSModuleViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSModuleViewCell.h"
#import "CSModuleCollectionViewCell.h"
#import "CSModuleModel.h"

@interface CSModuleViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** collectionView */
@property(nonatomic , strong)UICollectionView *collectionView;
/** pushController */
@property(nonatomic , strong)NSArray *pushControllers;



@end

@implementation CSModuleViewCell

NSString *kModuleColl = @"kModuleColl";

- (NSArray *)pushControllers {
    if (!_pushControllers) {
        _pushControllers = @[@"CSHotActivitiesViewController",@"CSCounselorViewController",@"CSFairylandViewController",@"CSSignInViewController"];
    }
    return _pushControllers;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
        
    }
    return self;
}

#pragma mark - setupUI
- (void)setupUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView = collectionView;
    collectionView.backgroundColor = RGB(248, 248, 248);
    [collectionView registerNib:[UINib nibWithNibName:@"CSModuleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kModuleColl];
    collectionView.delegate = self;
    collectionView.dataSource  = self;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CSModuleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kModuleColl forIndexPath:indexPath];
    CSModuleModel *model = self.models[indexPath.row];
    cell.titleImageView.image = [UIImage imageNamed:model.imgStr];
//    cell.titleLabel.text = model.title;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.title attributes:@{NSFontAttributeName: MediumFont(SIZE(14)),NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    
    cell.titleLabel.attributedText = string;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
        NSString *loginType = [UDefault getObject:LoginType];
        if ([loginType isEqualToString:@"5"]) {
            [Dialog toastCenter:@"这是莱瘦会员服务，管家请注意"];
            return;
        }
    }
    
    Class vcClass = NSClassFromString(self.pushControllers[indexPath.row]);
    
    UIViewController *vc = [[vcClass alloc] init];
    
    UIViewController *currentVc =  [self getCurrentController];
    if ([vc isKindOfClass:NSClassFromString(@"CSSignInViewController")]) {
        if (!ISLOGIN) {
            [currentVc.navigationController pushViewController:[NSClassFromString(@"CSLoginViewController") new] animated:YES];
            return;
        }
    }
    [currentVc.navigationController pushViewController:vc animated:true];
}







- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.viewWidth / 4;
    return  CGSizeMake(width, self.viewHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)setModels:(NSArray *)models {
    _models = models;
    [self.collectionView reloadData];
}


/**
 获取当前控制器
 @return 当前控制器
 */
- (UIViewController *)getCurrentController{
    
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    if (window.windowLevel!= UIWindowLevelNormal) {
        NSArray *array = [[UIApplication sharedApplication]windows];
        for (UIWindow *win in array) {
            if (win.windowLevel == UIWindowLevelNormal) {
                window = win;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //1、通过present弹出VC，appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        //2、通过navigationcontroller弹出VC
        NSLog(@"subviews == %@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){//1、tabBarController
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //或者 UINavigationController * nav = tabbar.selectedViewController;
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){//2、navigationController
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{//3、viewControler
        result = nextResponder;
    }
    return result;
}

@end
