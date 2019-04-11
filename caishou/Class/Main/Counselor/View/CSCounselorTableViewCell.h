//
//  CSCounselorTableViewCell.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSCounselorPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSCounselorTableViewCell : UITableViewCell
/**
 *@pramas  counselorPageModel - 分页顾问model
 *@pramas index 排名
 */
- (void )setCounselorPageModel:(CSCounselorPageModel *)counselorPageModel index:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
