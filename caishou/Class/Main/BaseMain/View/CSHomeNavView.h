//
//  CSHomeNavView.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSHomeNavView : UIView
/**
 *  0-选择分站 1-扫码
 */
@property(nonatomic, copy)void (^chooseSiteBtnClickBlock)(NSInteger index);
/**
 *  站点名称
 */
@property(nonatomic, copy)NSString *siteStr;

@end

NS_ASSUME_NONNULL_END
