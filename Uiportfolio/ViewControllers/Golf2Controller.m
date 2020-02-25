//
//  GolfController.m
//  Uiportfolio
//
//  Created by Shah, Tanay on 1/15/20.
//  Copyright © 2020 JM. All rights reserved.
//
#include "control.h"
#import "Golf2Controller.h"
@implementation Golf2Controller
@synthesize hole, wall, ball, firstPoint, lastPoint, portalin, portalout, nextlvl, win;
- (void)viewDidLoad {
  [super viewDidLoad];
    nextlvl.hidden = TRUE;
  // changes hole image to be circular
  self.hole.layer.cornerRadius = .46*self.hole.layer.frame.size.height;
  self.hole.layer.masksToBounds = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches Began");
    UITouch *touch = [touches anyObject];
    // turn user interaction off as swipe begins
    [self.view setUserInteractionEnabled:NO];
     
    // store point a touch began
    self.firstPoint = [touch locationInView:self.view];
     
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches Ended");
     
    UITouch *touch = [touches anyObject];
     
    // store point a touch end
    self.lastPoint = [touch locationInView:self.view];
     
    // logic to calculate swipevector as distance between touch began and touch end
    CGPoint swipeVector = CGPointMake(self.lastPoint.x - self.firstPoint.x, self.lastPoint.y - self.firstPoint.y);
     
    // velocity of ball based off of swipe
    self.ballVelocityX = speedScale * swipeVector.x;
    self.ballVelocityY = speedScale * swipeVector.y;
     
    // move ball occurs multiple times at this sampling rate, until friction causes ball to stop
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:.045 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
}

-(void)moveBall {
    // simulates friction by reducing velocity
    self.ballVelocityX = speedDamping * self.ballVelocityX;
    self.ballVelocityY = speedDamping * self.ballVelocityY;
     
    // this is the ball move
    self.ball.center = CGPointMake(self.ball.center.x + self.ballVelocityX, self.ball.center.y + self.ballVelocityY);
     
    // logic to calculate if ball and hole collide
    if (CGRectIntersectsRect(self.ball.frame, self.hole.frame)) {
      [self.gameTimer invalidate];
      [self.view setUserInteractionEnabled:YES];
      self.ball.center = CGPointMake(self.hole.center.x, self.hole.center.y);
      self.ball.alpha = 0.2;
        win.text = [NSString stringWithFormat:@"Congratulations! You win!"];
        nextlvl.hidden = FALSE;
        // applause
        NSString *path = [[NSBundle mainBundle] pathForResource:@"clapping" ofType:@"mp3"];
        NSURL *url = [NSURL URLWithString:path];
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
        [player play];
        [wall setBackgroundColor:[UIColor orangeColor]];
        [hole setBackgroundColor:[UIColor orangeColor]];
    }
    
    if (CGRectIntersectsRect(self.ball.frame, self.wall.frame)) {
        self.ballVelocityX = speedDamping * self.ballVelocityX * (-1);
        self.ballVelocityY = speedDamping * self.ballVelocityY * (-1);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pong" ofType:@"mp3"];
        NSURL *url = [NSURL URLWithString:path];
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
        [player play];
    }
    
    if (CGRectIntersectsRect(self.ball.frame, self.portalin.frame)) {
        self.ball.center = CGPointMake(self.portalout.center.x, self.portalout.center.y);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"portal" ofType:@"mp3"];
        NSURL *url = [NSURL URLWithString:path];
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
        [player play];
    }
    // if ball slows/stops turn off game timer and turn user interaction back on
    if(fabs(self.ballVelocityX) < stopSpeed && fabs(self.ballVelocityY) < stopSpeed) {
      [self.gameTimer invalidate];
      [self.view setUserInteractionEnabled:YES];
    }
}
    
@end
