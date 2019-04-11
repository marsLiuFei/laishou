//
//  UIView+CSViewSize.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "UIView+CSViewSize.h"

@implementation UIView (CSViewSize)
#pragma mark -- setupFrame
- (void)setviewOrign:(CGPoint)viewOrign {
    CGRect newFrame     = self.frame;
    newFrame.origin     = viewOrign;
    self.frame          = newFrame;
}
- (CGPoint)viewOrign {
    return self.frame.origin;
}
- (void)setviewSize:(CGSize)viewSize {
    CGRect newFrame     = self.frame;
    newFrame.size       = viewSize;
    self.frame          = newFrame;
}
- (CGSize)viewSize {
    return self.frame.size;
}

#pragma mark --setupPoint
- (void)setviewX:(CGFloat)viewX {
    CGRect newFrame     = self.frame;
    newFrame.origin.x   = viewX;
    self.frame          = newFrame;
}
- (CGFloat)viewX {
    return self.frame.origin.x;
}
- (void)setviewY:(CGFloat)viewY {
    CGRect newFrame     = self.frame;
    newFrame.origin.y   = viewY;
    self.frame          = newFrame;
}
- (CGFloat)viewY {
    return self.frame.origin.y;
}
- (void)setviewWidth:(CGFloat)viewWidth {
    CGRect newFrame     = self.frame;
    newFrame.size.width = viewWidth;
    self.frame          = newFrame;
}
- (CGFloat)viewWidth{
    return self.frame.size.width;
}
- (void)setviewHeight:(CGFloat)viewHeight {
    CGRect newFrame     = self.frame;
    newFrame.size.height = viewHeight;
    self.frame          = newFrame;
}
- (CGFloat)viewHeight {
    return self.frame.size.height;
}

- (void)setviewCenterX:(CGFloat)viewCenterX {
    CGPoint center = self.center;
    center.x = viewCenterX;
    self.center = center;
}
- (CGFloat)viewCenterX {
    return self.center.x;
}
- (void)setviewCenterY:(CGFloat)viewCenterY {
    CGPoint center = self.center;
    center.y = viewCenterY;
    self.center = center;
}
- (CGFloat)viewCenterY {
    return self.center.y;
}

#pragma mark -- setupbottom、right
- (void)setviewRight:(CGFloat)viewRight {
    self.viewX = viewRight - self.viewWidth;
}

- (CGFloat)viewRight {
    return CGRectGetMaxX(self.frame);
}
- (void)setviewBottom:(CGFloat)viewBottom {
    self.viewY = viewBottom - self.viewHeight;
}
- (CGFloat)viewBottom {
    return CGRectGetMaxY(self.frame);
}

@end
