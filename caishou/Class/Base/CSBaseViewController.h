//
//  CSBaseViewController.h
//  caishou
//
//  Created by 刘飞 on 2019/2/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSBaseViewController : UIViewController
@property (nonatomic,copy) NSString *navTitleStr;
#pragma mark - 设置导航栏
- (void)setNavWithTitle:(NSString *)title isShowBack:(BOOL)isShowBack;
#pragma mark -- 分享
- (void )shareWithTitle:(NSString *)title contents:(NSString *)contents imageName:(NSString *)imageName linkUrl:(NSString *)linkUrl;
/**
 *跳转网页
 **/
- (void )loadHtmlContents:(NSString *)htmlContents;
/**
 *加载url网址
 */
- (void )loadUrl:(NSString *)url;

- (void )loadHtmlContents:(NSString *)htmlContents isShare:(BOOL)share collect:(BOOL)collect chirleId:(NSString *)chirleId shareContent:(NSString *)shareContent shareIcon:(NSString *)shareIcon;
/**
 *  跳转视频播放
 */
- (void )videoPlayerWithUrl:(NSString *)videoUrl placeholdImage:(NSString *)imageUrl;
/**
 *  查看图片大图
 */
-(void)post:(NSInteger)index subviews:(NSArray *)subviews arr:(NSArray *)imageUrl;
@end

NS_ASSUME_NONNULL_END
