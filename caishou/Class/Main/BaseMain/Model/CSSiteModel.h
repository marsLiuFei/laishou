//
//  CSSiteModel.h
//  caishou
//
//  Created by 刘飞 on 2019/3/5.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSSiteModel : NSObject
/**
 *  分站名称
 */
@property(nonatomic, copy)NSString *name;
/**
 *  分站id
 */
@property(nonatomic, copy)NSString *ID;
@end

NS_ASSUME_NONNULL_END
