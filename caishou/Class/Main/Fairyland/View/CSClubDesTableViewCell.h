//
//  CSClubDesTableViewCell.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSClubDetailInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSClubDesTableViewCell : UITableViewCell
@property(nonatomic, strong)CSClubDetailInfoModel *clubDetailModel;
/**
 *  前往地址导航
 */
@property(nonatomic, copy)void (^goAreaBlock)(NSString *lat,NSString *lng);
@end

NS_ASSUME_NONNULL_END
