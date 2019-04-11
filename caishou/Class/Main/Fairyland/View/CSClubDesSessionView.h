//
//  CSClubDesSessionView.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/1.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSClubDesSessionHeaderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSClubDesSessionView : UITableViewHeaderFooterView
/** model */
@property(nonatomic , strong)CSClubDesSessionHeaderModel *headerModel;
/** copy */
@property(nonatomic , strong)void(^moreClickBlock)(void);


@end

NS_ASSUME_NONNULL_END
