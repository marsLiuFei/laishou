//
//  CSAddWeigthAlert.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSAddWeigthAlert : UIView

/** addBtnClick */
@property(nonatomic , copy)void (^addWeightBtnBlock)(NSString *number);


@end

NS_ASSUME_NONNULL_END
