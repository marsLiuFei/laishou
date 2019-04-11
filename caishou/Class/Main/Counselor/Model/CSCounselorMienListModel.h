//
//  CSCounselorMienListModel.h
//  caishou
//
//  Created by 刘飞 on 2019/3/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSCounselorMienListModel : NSObject

/**
 *
 */
@property(nonatomic, strong)NSString *createTime;
/**
 *
 */
@property(nonatomic, strong)NSString *creater;
/**
 *
 */
@property(nonatomic, strong)NSString *ID ;
/**
 *
 */
@property(nonatomic, strong)NSString *picture;
/**
 *
 */
@property(nonatomic, strong)NSString *status;

+ (CSCounselorMienListModel *)addMoreModel;

@end

NS_ASSUME_NONNULL_END
