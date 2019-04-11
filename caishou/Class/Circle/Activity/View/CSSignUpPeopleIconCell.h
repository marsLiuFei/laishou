//
//  CSSignUpPeopleIconCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSMemberInfoModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CSSignUpPeopleIconCell : UICollectionViewCell
- (void )setTitle:(NSString *)title imageName:(NSString *)imageName;
/**
 *  报名人数
 */
@property(nonatomic, strong)CSMemberInfoModel *memberModel;
@end

NS_ASSUME_NONNULL_END
