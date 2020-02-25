//
//  GolfController.h
//  Uiportfolio
//
//  Created by Shah, Tanay on 1/15/20.
//  Copyright © 2020 JM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
// These values simulate speed and friction
#define speedScale 0.20
#define speedDamping .92  // friction rate
#define stopSpeed 5.0
@interface GolfController : UIViewController
{
  AVAudioPlayer *player;
}
@property (strong, nonatomic) IBOutlet UIImageView *hole;
@property (strong, nonatomic) IBOutlet UIImageView *ball;
@property (nonatomic) CGPoint firstPoint;
@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) float ballVelocityX;
@property (nonatomic) float ballVelocityY;
@property (strong, nonatomic) NSTimer *gameTimer;
@property (weak, nonatomic) IBOutlet UILabel *win;
@property (nonatomic, retain) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UIImageView *wall;
@property (weak, nonatomic) IBOutlet UILabel *start;
@property (weak, nonatomic) IBOutlet UIButton *restart;

@end
