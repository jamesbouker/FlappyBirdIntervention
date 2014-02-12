//
//  UIView+Category.h
//  Pong
//
//  Created by Jimmy on 8/29/13.
//  Copyright (c) 2013 Jimmy Bouker. All rights reserved.
//
//
//  This is a category! Categories allow you to add methods to existing Classes without actually subclassing them
//
//  This category is for any UIView, it simplifies the way we can get and set the coordinates of all UIView's
//  Another thing worth noting, UIButton, UIImageView, UILabel, UITextView, etc... are all subclasses of UIView and this
//   category would work for all of those classes as well.
//
//  This file is #import'd inside the "Pong-Prefix.pch" file
//  Files that are imported there can be used anywhere.
//  Doing so just makes it very simple to use :D
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

@property float x,y,width,height,centerX,centerY, left, right, top, bottom;

-(void)roundEdges:(float)cornerRadius;
-(BOOL)doesCollideWith:(UIView*)view;

@end
