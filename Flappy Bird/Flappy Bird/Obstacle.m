//
//  Obstacle.m
//  Flappy Bird
//
//  Created by Jimmy on 2/11/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import "Obstacle.h"
#import "UIView+Category.h"

@implementation Obstacle

-(id)initWithTop:(UIImageView *)top Bottom:(UIImageView*)bottom {
    self = [super init];
    if(self) {
        self.top = top;
        self.bottom = bottom;
    }
    return self;
}

-(BOOL)move:(float)deltaX Bird:(UIView *)bird ShouldKill:(BOOL)shouldKill {
    _position = CGPointMake(_position.x + deltaX, _position.y);
    
    _top.frame = CGRectMake(_position.x, _top.frame.origin.y, _top.frame.size.width, _top.frame.size.height);
    _bottom.frame = CGRectMake(_position.x, _bottom.frame.origin.y, _bottom.frame.size.width, _bottom.frame.size.height);
    
    if(_top.frame.origin.x + _top.frame.size.width < 0) {
        [self spawn:DISTANCE_BTW_POLES];
    }
    
    if(shouldKill && [self shouldKillFlappy:bird]) {
        [self killBird];
        return YES;
    }
    
    return NO;
}

-(void)spawn:(int)offset {
    movedPassed = NO;
    float y = [UIScreen mainScreen].bounds.size.height - DISTANCE_FROM_GROUND;
    y = (arc4random() % (int)y);
    _position = CGPointMake(320 + offset, y);
    _top.frame = CGRectMake(_position.x, _position.y - _top.frame.size.height, _top.frame.size.width, _top.frame.size.height);
    _bottom.frame = CGRectMake(_position.x, _top.frame.size.height + _top.frame.origin.y + 120, _bottom.frame.size.width, _bottom.frame.size.height);
}

-(BOOL)collidesWith:(UIView*)bird {
    return [_top doesCollideWith:bird] || [_bottom doesCollideWith:bird];
}

-(BOOL)shouldKillFlappy:(UIView*)bird {
    if(movedPassed == NO && bird.x >= _top.x+_top.width/2) {
        movedPassed = YES;
        return YES;
    }
    return NO;
}

-(void)killBird {
    [UIView animateWithDuration:0.05 animations:^{
        _top.y += 60;
        _bottom.y -= 60;
    }];
}

-(BOOL)hasMovedPassed:(UIView*)bird {
    if(movedPassed == NO && bird.x >= _top.x+_top.width) {
        movedPassed = YES;
        return YES;
    }
    return NO;
}

@end
