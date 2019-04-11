//
//  CSMyCircleListCell.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMyCircleListCell.h"
#import "CSShowPicView.h"

@implementation CSMyCircleListCell
{
    UIImageView *headerImageView;
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *contentsLabel;
    CSShowPicView *bottomView;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    headerImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
    [self.contentView addSubview:headerImageView];
    headerImageView.layer.masksToBounds = YES;
    headerImageView.layer.cornerRadius = SIZE(15);
    
    titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"text" textColor:RGB44 textAlignment:Left font:MediumFont(14)];
    [self.contentView addSubview:titleLabel];
    
    
    timeLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"text" textColor:RGB102 textAlignment:Left font:RegularFont(10)];
    [self.contentView addSubview:timeLabel];
    
    
    contentsLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGB44 textAlignment:Left font:FONT(14)];
    contentsLabel.numberOfLines = 0;
    [self.contentView addSubview:contentsLabel];
    
    ws(bself);
    bottomView = [CSShowPicView new];
    bottomView.clickImageBlock = ^(NSInteger index, NSArray * _Nonnull subViews, NSArray * _Nonnull imageArray) {
        if (bself.clickImageBlock) {
            bself.clickImageBlock(index, subViews, imageArray);
        }
    };
    [self.contentView addSubview:bottomView];
    
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(SIZE(15));
        make.width.height.offset(SIZE(30));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->headerImageView.mas_centerY).offset(0);
        make.left.mas_equalTo(self->headerImageView.mas_right).offset(SIZE(5));
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->headerImageView.mas_centerY).offset(0);
        make.right.offset(-SIZE(15));
    }];
    [contentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.right.offset(-SIZE(15));
        make.top.mas_equalTo(self->headerImageView.mas_bottom).offset(SIZE(15));
    }];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.right.offset(-SIZE(15));
        make.bottom.offset(0);
        make.top.mas_equalTo(self->contentsLabel.mas_bottom).offset(0);
    }];
}

-(void)setCircleModel:(CSMyCircleModel *)circleModel{
    _circleModel = circleModel;
    if ([_circleModel.headImg hasPrefix:@"http"]) {
        [headerImageView sd_setImageWithURL:[NSURL URLWithString:_circleModel.headImg]];
    }else {
        headerImageView.image = [UIImage imageNamed:_circleModel.headImg];
    }
    titleLabel.text = isEmptyStr(_circleModel.name)?@"匿名":_circleModel.name;
    contentsLabel.text = isEmptyStr(_circleModel.introduce)?@"":_circleModel.introduce;
    bottomView.photos = _circleModel.photoList;
    timeLabel.text = isEmptyStr(_circleModel.createTime)?@"":_circleModel.createTime;//[XBWCSCommonTool timeStampStringToLocalTime:_circleModel.createTime]
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
