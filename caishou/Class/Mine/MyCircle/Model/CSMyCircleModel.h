//
//  CSMyCircleModel.h
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSMyCircleModel : NSObject


/**
 *
 */
@property(nonatomic, strong)NSString *createTime;
/**
 *
 */
@property(nonatomic, strong)NSString *headImg;
/**
 *
 */
@property(nonatomic, strong)NSString *ID;
/**
 *
 */
@property(nonatomic, strong)NSString *introduce;
/**
 *
 */
@property(nonatomic, strong)NSString *name;
/**
 *
 */
@property(nonatomic, strong)NSArray *photoList;
/**
 *
 */
@property(nonatomic, strong)NSString *picture;


/**
 *
 */
@property(nonatomic, strong)NSString *strCreateTime;


@property(nonatomic, assign)CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END

/*
 
 {
 createTime = "2019-03-21T14:07:52.943";
 headImg = "http://47.99.100.88:81/file/showimg?filename=201903211345502458.png";
 id = "c2f5271e-fb10-4282-bfb5-97877eeee289";
 introduce = "\U63d0\U4ea4\U4e00\U4e2a\U6d4b\U8bd5";
 name = "";
 photoList =                 (
 "http://47.99.100.88:81/file/showimg?filename=201903211407520060.png",
 "http://47.99.100.88:81/file/showimg?filename=201903211407520060.png",
 "http://47.99.100.88:81/file/showimg?filename=201903211407528587.png",
 "http://47.99.100.88:81/file/showimg?filename=201903211407522201.png",
 "http://47.99.100.88:81/file/showimg?filename=201903211407522201.png"
 );
 picture = "201903211407520060.png;201903211407520060.png;201903211407528587.png;201903211407522201.png;201903211407522201.png";
 strCreateTime = "2019\U5e7403\U670821\U65e5\U53d1\U8868";
 }
 
 
 **/
