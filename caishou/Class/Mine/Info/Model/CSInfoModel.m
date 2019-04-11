//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//
//
//  CSInfoModel.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/5.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSInfoModel.h"

@implementation CSInfoModel

+ (NSArray *)loadDatasWithNormalModel:(CSPersonalInfoModel *)infoModel {
    CSInfoModel *model1 = [[CSInfoModel alloc] init];
    model1.type = MyInfoTypeDef;
    model1.iconStr = @"name";
    model1.title = @"姓名";
    model1.placeholder = @"请输入您的姓名";
    model1.text = infoModel.name?infoModel.name:@"";
    model1.tag = 1000;
    
    CSInfoModel *model2 = [[CSInfoModel alloc] init];
    model2.type = MyInfoTypeSelect;
    model2.iconStr = @"gender";
    model2.title = @"性别";
    model2.placeholder = @"请输入您的性别";
    model2.subArr = @[@"男",@"女"];
    model2.text = infoModel.sex == 0?@"男":@"女";
    model2.tag = 1001;
    
    CSInfoModel *model3 = [[CSInfoModel alloc] init];
    model3.type = MyInfoTypeSelect;
    model3.iconStr = @"birthday";
    model3.title = @"生日";
    model3.placeholder = @"请选择您的生日";
    model3.text = infoModel.birthday?infoModel.birthday:nil;
    model3.tag = 1002;
    
    CSInfoModel *model4 = [[CSInfoModel alloc] init];
    model4.type = MyInfoTypeDef;
    model4.iconStr = @"stature";
    model4.title = @"身高";
    model4.placeholder = @"请输入您的身高";
    model4.text = infoModel.height?infoModel.height:@"";
    model4.tag = 1003;
    
    CSInfoModel *model5 = [[CSInfoModel alloc] init];
    model5.type = MyInfoTypeDef;
    model5.iconStr = @"weight";
    model5.title = @"体重";
    model5.placeholder = @"请输入您的体重";
    model5.text = infoModel.weight?infoModel.weight:@"";
    model5.tag = 1004;
    
    CSInfoModel *model6 = [[CSInfoModel alloc] init];
    model6.type = MyInfoTypeDef;
    model6.iconStr = @"weight";
    model6.title = @"目标体重";
    model6.placeholder = @"请输入您的目标体重";
    model6.text = infoModel.targetWeight?infoModel.targetWeight:@"";
    model6.tag = 1005;
    
    CSInfoModel *model7 = [[CSInfoModel alloc] init];
    model7.type = MyInfoTypeOther;
    model7.iconStr = @"like";
    model7.title = @"个人喜好";
    model7.subArr = @[@"足球",@"篮球",@"健身",@"音乐",@"读书",@"游戏"];
    model7.selectTag = infoModel.befond?infoModel.befond:@"";
    model7.tag = 1006;
    
    CSInfoModel *model8 = [[CSInfoModel alloc] init];
    model8.type = MyInfoTypeSelect;
    model8.iconStr = @"industry";
    model8.title = @"所处行业";
    model8.placeholder = @"请输入您的行业";
    model8.subArr = @[@"建筑业",@"医学",@"老师",@"公务员",@"IT计算机",@"广告",@"其他"];
    model8.text = infoModel.industry?infoModel.industry:nil;
    model8.tag = 1007;
    
    CSInfoModel *model9 = [[CSInfoModel alloc] init];
    model9.type = MyInfoTypeDef;
    model9.iconStr = @"birthday";
    model9.title = @"工作职位";
    model9.placeholder = @"请输入您的职位";
    model9.text = infoModel.job?infoModel.job:@"";
    model9.tag = 1008;
    
    CSInfoModel *model10 = [[CSInfoModel alloc] init];
    model10.type = MyInfoTypeDef;
    model10.iconStr = @"name";
    model10.title = @"手机号";
    model10.placeholder = @"请输入您的手机号";
    model10.text = infoModel.mobile?infoModel.mobile:@"";
    model10.tag = 1009;
    
    CSInfoModel *model11 = [[CSInfoModel alloc] init];
    model11.type = MyInfoTypeDef;
    model11.iconStr = @"weight";
    model11.title = @"胸围";
    model11.placeholder = @"请输入您的胸围";
    model11.text = infoModel.chestWai?infoModel.chestWai:@"";
    model11.tag = 1010;
    
    CSInfoModel *model12 = [[CSInfoModel alloc] init];
    model12.type = MyInfoTypeDef;
    model12.iconStr = @"weight";
    model12.title = @"腰围";
    model12.placeholder = @"请输入您的腰围";
    model12.text = infoModel.waistWai?infoModel.waistWai:@"";
    model12.tag = 1011;
    
    CSInfoModel *model13 = [[CSInfoModel alloc] init];
    model13.type = MyInfoTypeDef;
    model13.iconStr = @"weight";
    model13.title = @"臀围";
    model13.placeholder = @"请输入您的臀围";
    model13.text = infoModel.hipWai?infoModel.hipWai:@"";
    model13.tag = 1012;
    
    return @[model1,model10,model2,model3,model4,model5,model6,model7,model8,model9,model11,model12,model13];
}

@end
