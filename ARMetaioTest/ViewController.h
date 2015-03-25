//
//  ViewController.h
//  ARMetaioTest
//
//  Created by 池田昂平 on 2014/10/20.
//  Copyright (c) 2014年 池田昂平. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import "MetaioSDKViewController.h"
#import "EAGLView.h"
#import "ARView.h"
#import <QuartzCore/QuartzCore.h>
#import "Particle.h"

@interface ViewController : MetaioSDKViewController{
    CGSize size;
}

@property AVAudioPlayer *recogSound;
@property ARView *arview;
@property Particle * particle;
@property CAEmitterLayer *emitterLayer;

@end
