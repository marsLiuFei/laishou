//
//  CSShowPicView.h
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSShowPicView : UIView
/**
 *  
 */
@property(nonatomic, copy)void (^clickImageBlock)(NSInteger index,NSArray *subViews,NSArray *imageArray);
/**
 *
 */
@property(nonatomic, strong)NSArray *photos;
@end

NS_ASSUME_NONNULL_END
