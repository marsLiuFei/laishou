//
//  CSShareAlertView.h
//  caishou
//
//  Created by 刘飞 on 2019/4/10.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSShareAlertView : UIView
/**
 *  @param view 展示在哪个视图上
 */
- (void)showInView:(UIView *)view shareUrl:(NSString *)shareUrl;
@end

NS_ASSUME_NONNULL_END
