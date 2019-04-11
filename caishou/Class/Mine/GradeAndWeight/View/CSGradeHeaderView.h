//
//  CSGradeHeaderView.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSGradeHeaderView : UIView


/** addWeigthClick */
@property(nonatomic , copy)void (^addWeightBlock)(void);

- (void)setupWeigth:(NSInteger)weight;

@end

NS_ASSUME_NONNULL_END
