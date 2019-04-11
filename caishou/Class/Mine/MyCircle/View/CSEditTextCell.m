//
//  CSEditTextCell.m
//  caishou
//
//  Created by 刘飞 on 2019/3/12.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSEditTextCell.h"

@interface CSEditTextCell ()<UITextViewDelegate>
{
    UILabel *textViewPlaceholderLabel;
}

@end

@implementation CSEditTextCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.offset(SIZE(9));
        make.right.offset(-SIZE(9));
    }];
    _textView = [UITextView new];
    _textView.delegate = self;
    _textView.font = FONT(16);
    [bgView addSubview:_textView];
//    _textView.layer.borderColor = RGB(234, 234, 234).CGColor;
//    _textView.layer.borderWidth = SIZE(0.5);
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.offset(SIZE(5));
        make.right.offset(-12);
        make.bottom.offset(-SIZE(5));
    }];
    
    textViewPlaceholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 200, 20)];
    textViewPlaceholderLabel.text = @"请输入内容";
    textViewPlaceholderLabel.textColor = [UIColor grayColor];
    textViewPlaceholderLabel.font = FONT(16);
    [_textView addSubview: textViewPlaceholderLabel];
    
    //    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:@"订单备注 (可输入特殊要求)"];
    //
    //    [att addAttributes:@{
    //                         NSForegroundColorAttributeName:RGB(140, 140, 140),
    //                         NSFontAttributeName:FONT(14),
    //                         } range:NSMakeRange(0, 4)];
    //
    //    [att addAttributes:@{
    //                         NSForegroundColorAttributeName:RGB(140, 140, 140),
    //                         NSFontAttributeName:FONT(14),
    //                         } range:NSMakeRange(4, att.length-4)];
    //
    //    textViewPlaceholderLabel.attributedText =  att;
}
//设置textView的placeholder
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //[text isEqualToString:@""] 表示输入的是退格键
    if ([text length] > 0)
    {
        textViewPlaceholderLabel.hidden = YES;
    }else if ([textView.text length] == 1 && [text isEqualToString:@""]){
        textViewPlaceholderLabel.hidden = NO;
    }
    if([text rangeOfString:@"\n"].location !=NSNotFound)//_roaldSearchText
    {
        [textView endEditing:YES];
    }
    else
    {
        NSLog(@"no");
    }
    
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (toBeString.length > 300 && range.length!=1){
        
        textView.text = [toBeString substringToIndex:300];
        
        return NO;
    }
    
    return YES;
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
