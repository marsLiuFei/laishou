//
//  CSEditMyCircleContentsViewController.h
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSEditMyCircleContentsViewController : CSBaseViewController
/**
 *  <#define#>
 */
@property(nonatomic, copy)void (^needRefreshBlock)(void );
@end

NS_ASSUME_NONNULL_END
