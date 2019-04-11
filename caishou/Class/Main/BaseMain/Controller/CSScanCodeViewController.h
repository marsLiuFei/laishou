//
//  CSScanCodeViewController.h
//  caishou
//
//  Created by 刘飞 on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSScanCodeViewController : CSBaseViewController
/**
 *  <#define#>
 */
@property(nonatomic, copy)void (^needFreshBlock)(void );
@end

NS_ASSUME_NONNULL_END
