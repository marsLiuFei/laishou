//
//  CSOptimizeNewsCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSOptimizeNewsCell.h"

@implementation CSOptimizeNewsCell
{
    UILabel *titleLabel;
    UILabel *contentsLabel;
    UIImageView *newsImageView;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = WhiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    newsImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self.contentView addSubview:newsImageView];
    [newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-SIZE(15));
        make.width.height.offset(SIZE(90));
    }];
    
    titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"成为iOS顶尖高手，你必须来这里(这里有最好的开源项目和文章)" textColor:RGBA(53, 60, 54, 1) textAlignment:Left font:[UIFont fontWithName:@"PingFangSC-Medium" size: SIZE(14)]];
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(SIZE(15));
        make.right.mas_equalTo(self->newsImageView.mas_left).offset(-SIZE(30));
//        make.bottom.mas_equalTo(self->newsImageView.mas_centerY).offset(0);
        make.height.mas_lessThanOrEqualTo(SIZE(40));
    }];
    
    
    contentsLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"一个定期翻译国外iOS优质的技术、开源库、软件架构设计、测试等文章的开源项目https://github.com/520MobileDev/iOS-tech-frontier;Subscribe to a hand-picked round up of the best iOS development links every week. Curated byDave Verwer and published every Friday. Free." textColor:RGB153 textAlignment:Left font:[UIFont fontWithName:@"PingFangSC-Regular" size: SIZE(12)]];
    contentsLabel.numberOfLines = 0;
    [self.contentView addSubview:contentsLabel];
    [contentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
//        make.bottom.offset(-SIZE(10));
        make.height.mas_lessThanOrEqualTo(SIZE(50));
        make.right.mas_equalTo(self->newsImageView.mas_left).offset(-SIZE(15));
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(SIZE(5));
    }];
    
//    UIView *line = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(234, 234, 234)];
//    [self.contentView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.offset(0);
//        make.height.offset(SIZE(0.5));
//    }];
}





-(void)setArticleModel:(CSArticleListModel *)articleModel{
    _articleModel = articleModel;
    [newsImageView sd_setImageWithURL:[NSURL URLWithString:_articleModel.img] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    titleLabel.text = isEmptyStr(_articleModel.articleTitle)?@"":_articleModel.articleTitle;
    contentsLabel.text = isEmptyStr(_articleModel.simple)?@"":_articleModel.simple;
}








- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
