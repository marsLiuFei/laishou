//
//  CSArticleListModel.h
//  caishou
//
//  Created by 刘飞 on 2019/3/9.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSArticleListModel : NSObject

/**
 *
 */
@property(nonatomic, strong)NSString *ID;
/**
 *
 */
@property(nonatomic, strong)NSString *substationId;
/**
 *
 */
@property(nonatomic, strong)NSString *articleTitle;
/**
 *
 */
@property(nonatomic, strong)NSString *simple;
/**
 *
 */
@property(nonatomic, strong)NSString *articleContent;
/**
 *
 */
@property(nonatomic, strong)NSString *status;
/**
 *
 */
@property(nonatomic, strong)NSString *shareNumber;
/**
 *
 */
@property(nonatomic, strong)NSString *likeNumber;
/**
 *
 */
@property(nonatomic, strong)NSString *collectNumber;
/**
 *
 */
@property(nonatomic, strong)NSString *noPassNote;
/**
 *
 */
@property(nonatomic, strong)NSString *creater;
/**
 *
 */
@property(nonatomic, strong)NSString *createrType;
/**
 *
 */
@property(nonatomic, strong)NSString *createTime;
/**
 *
 */
@property(nonatomic, strong)NSString *clubId;
/**
 *
 */
@property(nonatomic, strong)NSString *articleType;
/**
 *
 */
@property(nonatomic, assign)BOOL isVideo;
/**
 *
 */
@property(nonatomic, strong)NSString *img;
/**
 *
 */
@property(nonatomic, strong)NSString *counselorId;

@end

NS_ASSUME_NONNULL_END

/**
 
 {
 "id": "6fab5d8e-31dc-49bf-a8f6-c291e3d74f9c",
 "substationId": "9784e38e-2b9f-4b04-8326-1f1eadb00837",
 "articleTitle": "好人",
 "articleContent": "呵呵呵",
 "status": 2,
 "shareNumber": 0,
 "likeNumber": 0,
 "collectNumber": 0,
 "noPassNote": "1",
 "creater": "0785166c-fb6f-4f90-801f-f8dba372bc07",
 "createrType": 1,
 "createTime": "2019-02-28T15:23:46.223",
 "clubId": null,
 "articleType": 1,
 "isVideo": 0,
 "img": "http://47.94.172.208:20192/file/showimg?filename=20190302094640.jpg",
 "counselorId": null
 }
 
 
 articleTitle = "\U60f3\U8981\U51cf\U80a5\U6210\U529f\Uff0c\U4e3a\U4ec0\U4e48\U4e00\U5b9a\U8981\U575a\U630190\U5929\U4ee5\U4e0a\Uff1f\U539f\U56e0\U90fd\U5728\U8fd9\U91cc\Uff01";
 articleType = 1;
 clubId = "155536d9-f83e-4ba2-8e1c-6647d2e31fb3";
 collectNumber = 0;
 counselorId = "76904c6c-6a4e-49e7-9420-849cb0ebb1be";
 createTime = "2019-03-19T22:16:48.317";
 creater = "0785166c-fb6f-4f90-801f-f8dba372bc07";
 createrType = 1;
 id = "614cbf9c-0cd3-4e28-abc3-4e227cdfe959";
 img = "http://47.99.100.88:81/file/showimg?filename=20190319221624.jpg";
 isVideo = 0;
 likeNumber = 0;
 noPassNote = "<null>";
 shareNumber = 0;
 simple = "\U60f3\U8981\U51cf\U80a5\U6210\U529f\Uff0c\U4e3a\U4ec0\U4e48\U4e00\U5b9a\U8981\U575a\U630190\U5929\U4ee5\U4e0a\Uff1f\U539f\U56e0\U90fd\U5728\U8fd9\U91cc\Uff01";
 status = 2;
 substationId = "4554081b-aa46-48d4-a5f9-0472a38a6f5f";
 
 */
