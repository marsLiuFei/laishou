//
//  CSModuleViewCell.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSModuleViewCell : UITableViewCell
/** models */
@property(nonatomic , strong)NSArray *models;
/**
 *  经纬度信息
 */
@property(nonatomic, strong)NSDictionary *locationDic;
@end

NS_ASSUME_NONNULL_END
