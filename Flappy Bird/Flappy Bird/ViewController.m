//
//  ViewController.m
//  Flappy Bird
//
//  Created by Jimmy on 2/4/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+Category.h"
#import "Obstacle.h"
#import "UIView+Category.h"

static const float degreesToRadians = 0.0174532925f;

@implementation ViewController {
    //states
    BOOL moving, started, gameOver, presentedGameOverScreen;
    
    
    float birdVelocity, timeSinceGameOver;
}

#pragma mark - Game Setup

-(void)viewDidLayoutSubviews {
    static BOOL hasRan = NO;
    if(hasRan)
        return;
    
    [self updateScoreLabel];
    
    hasRan = YES;
    moving = YES;
    started = NO;
    
    [_gameOverImageView setHidden:YES];
    
    [self setupBird];
    [self setupObstacles];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    tapGesture.delaysTouchesBegan = NO;
    tapGesture.delaysTouchesEnded = NO;
    [self.view addGestureRecognizer:tapGesture];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(updateGame) userInfo:nil repeats:YES];
}

-(void)setupObstacles {
    obstacles = [[NSMutableArray alloc] init];
    [obstacles addObject:[[Obstacle alloc] initWithTop:_top1 Bottom:_bot1]];
    [obstacles addObject:[[Obstacle alloc] initWithTop:_top2 Bottom:_bot2]];
    [obstacles addObject:[[Obstacle alloc] initWithTop:_top3 Bottom:_bot3]];
    
    for(int i=0; i<obstacles.count; i++) {
        Obstacle *o = obstacles[i];
        [o spawn:i*DISTANCE_BTW_POLES];
    }
}

-(void)setupBird {
    birdVelocity = -5;
    _bird.y = self.view.height/2;
    
    NSMutableArray *birdImages = [[NSMutableArray alloc] init];
    [birdImages addObject:[UIImage imageNamed:@"birdBottom"]];
    [birdImages addObject:[UIImage imageNamed:@"birdMiddle"]];
    [birdImages addObject:[UIImage imageNamed:@"birdTop"]];
    [birdImages addObject:[UIImage imageNamed:@"birdMiddle"]];
    _bird.animationImages = birdImages;
    _bird.animationDuration = .5;
    [_bird startAnimating];
}

#pragma mark - Game Loop

-(void)updateGame {
    if(gameOver)
        timeSinceGameOver += 1.0/30.0;
    else
        timeSinceGameOver = 0;
    
    [self animateFloor];
    [self updateBird];
    [self updatePipes];
}

-(void)updatePipes {
    if(moving && started) {
        float deltaX = -160 * 1.0/30.0;
        for(Obstacle *o in obstacles) {
            if([o move:deltaX Bird:_bird ShouldKill:self.hasPlayed]) {
                _bird.alpha = 0;
            }
            
            if([o hasMovedPassed:_bird]) {
                
                if(self.hasPlayed == NO) {
                    self.score = self.score+1;
                    [self updateScoreLabel];
                }
            }
        }
    }
}

-(void)animateFloor {
    if(moving) {
        float deltaX = -160 * 1.0/30.0;
        _floor1.frame = CGRectMake(_floor1.frame.origin.x+deltaX, _floor1.frame.origin.y, 320, _floor1.frame.size.height);
        _floor2.frame = CGRectMake(_floor2.frame.origin.x+deltaX, _floor1.frame.origin.y, 320, _floor1.frame.size.height);
        
        if(_floor1.frame.origin.x <= -320) {
            float d = _floor1.frame.origin.x + _floor1.frame.size.width;
            _floor1.frame = CGRectMake(d, _floor1.frame.origin.y, 320, _floor1.frame.size.height);
            _floor2.frame = CGRectMake(320+d, _floor1.frame.origin.y, 320, _floor1.frame.size.height);
        }
    }
}

-(void)updateBird {
    if((!moving || !started) && !gameOver)
        return;
    
    //Gravity
    birdVelocity += (40.0) * 1.0/30.0;
    birdVelocity = MIN(birdVelocity, 22.5);
    
    _bird.frame = CGRectMake(_bird.frame.origin.x, _bird.frame.origin.y + birdVelocity, _bird.frame.size.width, _bird.frame.size.height);
    
    if(_bird.frame.origin.y + _bird.frame.size.height >= _floor1.frame.origin.y) {
        _bird.y = _floor1.y - _bird.height;
        [self gameOver];
        
        if(!presentedGameOverScreen) {
            
        }
    }
    else if(_bird.frame.origin.y <= 0) {
        [self gameOver];
    }
    else if([self collided]) {
        [self gameOver];
    }
}

-(BOOL)collided {
    for(Obstacle *o in obstacles) {
        if([o collidesWith:_bird])
            return YES;
    }
    return NO;
}

-(void)gameOver {
    if(gameOver)
        return;
    
    gameOver = YES;
    moving = NO;
    [_bird stopAnimating];
    [self setHasPlayed:YES];
    
    //show game over screen and score
    _gameOverImageView.hidden = NO;
    _gameOverImageView.alpha = 0;
    
    [UIView animateWithDuration:1.0 animations:^{
        _gameOverImageView.alpha = 1;
    }];
}

#pragma mark - UI Updates

-(void)updateScoreLabel {
    _scoreLabel.text = [NSString stringWithFormat:@"%d", self.score];
}

#pragma mark - Actions

-(void)fingerTapped:(UIGestureRecognizer*)gesture {
    if(gameOver && timeSinceGameOver > 1.0f)
        [self restartGame];
    
    
    if(!moving)
        return;
    
    [self startButtonHit:nil];
    birdVelocity = -12.5;
}

-(void)restartGame {
    
    [UIView animateWithDuration:1.0 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        _gameOverImageView.alpha = 0;
        _titleImageView.alpha = 1;
        _getReadyImageView.alpha = 1;
        _tapImageView.alpha = 1;
        _bird.alpha = 1;
        
        started = NO;
        moving = YES;
        gameOver = NO;
        presentedGameOverScreen = NO;
        [self setupBird];
        [self setupObstacles];
        
        [UIView animateWithDuration:1.0 animations:^{
            self.view.alpha = 1;
        } completion:^(BOOL finished) {

        }];
    }];
}

-(void)startButtonHit:(id)sender {
    if(started)
        return;
    
    birdVelocity = -5;
    started = YES;
    
    [UIView animateWithDuration:1.0 animations:^{
        _titleImageView.frame = CGRectMake(_titleImageView.frame.origin.x, -_titleImageView.frame.size.height, _titleImageView.frame.size.width, _titleImageView.frame.size.height);
        _getReadyImageView.alpha = 0;
        _tapImageView.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - User Defaults

-(void)setScore:(int)score {
    [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"score"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(int)score {
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
}

-(void)setHasPlayed:(BOOL)hasPlayed {
    [[NSUserDefaults standardUserDefaults] setBool:hasPlayed forKey:@"hasPlayed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)hasPlayed {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"hasPlayed"];
}

@end
