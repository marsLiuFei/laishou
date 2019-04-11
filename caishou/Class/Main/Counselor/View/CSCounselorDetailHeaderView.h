//
//  CSCounselorDetailHeaderView.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSCounselorDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSCounselorDetailHeaderView : UIView
/** isEdit */
@property(nonatomic , assign)BOOL edit;
/** editClock */
@property(nonatomic , strong)void(^editIntroBlock)(NSString *editStr);


@property(nonatomic, strong)CSCounselorDetailModel *counselorDetailModel;
@end

NS_ASSUME_NONNULL_END
