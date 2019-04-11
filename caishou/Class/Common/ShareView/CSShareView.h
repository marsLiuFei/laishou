//
//  CSShareView.h
//  caishou
//
//  Created by 刘飞 on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSShareView : UIView
/**
 *  @param view 展示在哪个视图上
 */
- (void)showInView:(UIView *)view;
/**
 *  点击了哪种分享功能 0-微信朋友圈 1-微信 2-qq 3-qq空间 4-微博
 */
@property(nonatomic, copy)void (^clickBtnBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
