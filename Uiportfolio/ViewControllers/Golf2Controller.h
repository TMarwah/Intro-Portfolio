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
@interface Golf2Controller : UIViewController
{
  AVAudioPlayer *player;
}
@property (weak, nonatomic) IBOutlet UILabel *win;
@property (weak, nonatomic) IBOutlet UIImageView *hole;
@property (weak, nonatomic) IBOutlet UIImageView *ball;
@property (weak, nonatomic) IBOutlet UIImageView *wall;
@property (weak, nonatomic) IBOutlet UIImageView *portalin;
@property (weak, nonatomic) IBOutlet UIImageView *portalout;
@property (weak, nonatomic) IBOutlet UIButton *nextlvl;
@property (nonatomic) CGPoint firstPoint;
@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) float ballVelocityX;
@property (nonatomic) float ballVelocityY;
@property (strong, nonatomic) NSTimer *gameTimer;

@end
