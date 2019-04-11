//
//  CSBaseWebViewController.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSBaseWebViewController : CSBaseViewController
/**
 *加载html内容
 **/
@property(nonatomic,copy)NSString * htmlString;
/**
 *加载url网页
 **/
@property(nonatomic, strong)NSString *url;

/** share */
@property(nonatomic , assign)BOOL share;
/** collect */
@property(nonatomic , assign)BOOL collect;

@property(nonatomic, strong)NSString *shareContent;

@property(nonatomic, strong)NSString *shareIcon;

@property(nonatomic, strong)NSString *chirleId;

@end

NS_ASSUME_NONNULL_END
