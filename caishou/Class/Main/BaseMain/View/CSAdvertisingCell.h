//
//  CSAdvertisingCell.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSAdvertisingCell : UITableViewCell

@property(nonatomic, strong)NSArray *activityImages;

/**
 *跳转链接
 **/
@property(nonatomic, strong)void (^jumpBannerDetailBlock)(NSString *jumpUrl);

@end

NS_ASSUME_NONNULL_END
