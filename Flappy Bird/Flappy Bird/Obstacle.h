//
//  Obstacle.h
//  Flappy Bird
//
//  Created by Jimmy on 2/11/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import <Foundation/Foundation.h>

const static int DISTANCE_BTW_POLES = 180;
const static int DISTANCE_FROM_GROUND = 250;

@interface Obstacle : NSObject {
    BOOL movedPassed;
}

@property (nonatomic, strong) UIImageView *top, *bottom;
@property CGPoint position;

-(id)initWithTop:(UIImageView *)top Bottom:(UIImageView*)bottom;

-(BOOL)move:(float)deltaX Bird:(UIView *)bird ShouldKill:(BOOL)shouldKill;
-(void)spawn:(int)offset;
-(BOOL)collidesWith:(UIView*)bird;
-(BOOL)hasMovedPassed:(UIView*)bird;
-(void)killBird;

@end
