//
//  CSBenifitGoodsBannerCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/27.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSBenifitGoodsBannerCell : UITableViewCell

@property (nonatomic, copy) NSArray *imageArray;

@property (nonatomic,copy) void(^bannerClick)(NSInteger index,NSArray *imageArray);
@end

NS_ASSUME_NONNULL_END
