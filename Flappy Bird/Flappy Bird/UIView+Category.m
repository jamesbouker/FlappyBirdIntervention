//
//  UIView+Category.m
//  Pong
//
//  Created by Jimmy on 8/29/13.
//  Copyright (c) 2013 Jimmy Bouker. All rights reserved.
//
//
//  So yeah, this is where we actually fill in the methods that are declared in
//  the UIView+Category.h file
//
//  If you look at the code below, just pretend every time we did:
//  playerPaddle.centerY++
//
//  we would instead have to write:
//  playerPaddle.frame = CGRectMake(self.frame.origin.x, centerY - self.frame.size.height/2, self.frame.size.width, self.frame.size.height);
//
//  Try deleting this category and modifying the code to work...Only then can you apreciate the category! 
//

#import "UIView+Category.h"

@implementation UIView (Category)

-(void)setX:(float)x {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)setY:(float)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

-(void)setWidth:(float)width {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

-(void)setHeight:(float)height {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

-(void)setCenterX:(float)centerX {
    self.frame = CGRectMake(centerX - self.frame.size.width/2, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)setCenterY:(float)centerY {
    self.frame = CGRectMake(self.frame.origin.x, centerY - self.frame.size.height/2, self.frame.size.width, self.frame.size.height);
}

-(void)setLeft:(float)left {
    self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)setRight:(float)right {
    self.frame = CGRectMake(right - self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)setTop:(float)top {
    self.frame = CGRectMake(self.frame.origin.x, top, self.frame.size.width, self.frame.size.height);
}

-(void)setBottom:(float)bottom {
    self.frame = CGRectMake(self.frame.origin.x, bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

-(void)roundEdges:(float)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = NO;
}

-(float)centerX {
    return self.frame.origin.x + self.frame.size.width/2;
}

-(float)centerY {
    return self.frame.origin.y + self.frame.size.height/2;
}

-(float)x {
    return self.frame.origin.x;
}

-(float)y {
    return self.frame.origin.y;
}

-(float)width {
    return self.frame.size.width;
}

-(float)height {
    return self.frame.size.height;
}

-(float)left {
    return self.frame.origin.x;
}

-(float)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(float)top {
    return self.frame.origin.y;
}

-(float)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(BOOL)doesCollideWith:(UIView*)view {
    if(self.left < view.right && self.right > view.left) {
        if(self.bottom > view.top && self.top < view.bottom) {
            return YES;
        }
    }
    return NO;
}

@end
