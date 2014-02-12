//
//  ViewController.h
//  Flappy Bird
//
//  Created by Jimmy on 2/4/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSMutableArray *obstacles;
}

@property (nonatomic, strong) IBOutlet UIImageView *floor1, *floor2;
@property (nonatomic, strong) IBOutlet UIImageView *titleImageView, *getReadyImageView, *gameOverImageView;
@property (nonatomic, strong) IBOutlet UIImageView *tapImageView;
@property (nonatomic, strong) IBOutlet UIImageView *bird;
@property (nonatomic, strong) IBOutlet UIImageView *top1,*top2,*top3;
@property (nonatomic, strong) IBOutlet UIImageView *bot1,*bot2,*bot3;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;

@property int score;
@property BOOL hasPlayed;

@end
