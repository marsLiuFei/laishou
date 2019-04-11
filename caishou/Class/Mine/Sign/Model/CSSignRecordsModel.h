//
//  CSSignRecordsModel.h
//  caishou
//
//  Created by 刘飞 on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSSignRecordsModel : NSObject
/**
 *  是否已签到
 */
@property(nonatomic, assign)BOOL isSign;
/**
 *  签到时间
 */
@property(nonatomic, strong)NSString *strTime;
@end

NS_ASSUME_NONNULL_END
