//
//  UIImageView+Category.m
//  Flappy Bird
//
//  Created by Jimmy on 2/4/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)

-(void)rotateWithDegrees:(CGFloat)degrees {
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-self.frame.origin.x, -self.frame.origin.y);
    transform = CGAffineTransformRotate(transform, 0.0174532925 * degrees);
    transform = CGAffineTransformTranslate(transform, self.frame.origin.x, self.frame.origin.y);
    self.transform = transform;
}

@end
