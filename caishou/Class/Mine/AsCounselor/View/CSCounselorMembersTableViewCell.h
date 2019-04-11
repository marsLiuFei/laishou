//
//  CSCounselorMembersTableViewCell.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUserMemberModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSCounselorMembersTableViewCell : UITableViewCell
/** MemberModel */
@property(nonatomic , strong)CSUserMemberModel *userModel;
/** 是否黑色 */
@property(nonatomic , assign)BOOL black;
/** 是否显示*** */
@property(nonatomic , assign)BOOL show;

@end

NS_ASSUME_NONNULL_END
