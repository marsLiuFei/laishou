//
//  CSExhibitionTableViewCell.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSExhibitionTableViewCell : UITableViewCell
/**
 *
 **/
@property(nonatomic, strong)NSArray *sourceData;
/**
 *
 */
@property(nonatomic, copy)void (^clickImageBlock)(NSInteger index,NSArray *subViews,NSArray *imageArray);
@end

NS_ASSUME_NONNULL_END
