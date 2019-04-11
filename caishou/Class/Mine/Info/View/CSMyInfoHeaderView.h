//
//  CSMyInfoHeaderView.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/4.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSMyInfoHeaderView : UIView

/** headerClick */
@property(nonatomic , copy)void(^headerImageClick)(void);
/** imageStr */
@property(nonatomic , strong)NSString *imageStr;


- (void)setupHeaderImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
