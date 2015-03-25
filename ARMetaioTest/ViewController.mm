//
//  ViewController.m
//  ARMetaioTest
//
//  Created by 池田昂平 on 2014/10/20.
//  Copyright (c) 2014年 池田昂平. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    //音の設定
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recogHover" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.recogSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    
    //glView生成 (metaio AR)
    self.glView = [[EAGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.glView];
    
    //ARView
    self.arview = [[ARView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.arview];
    
    //[self generateParticle];

    
    
    [super viewDidLoad];
    
    m_metaioSDK->setTrackingEventCallbackReceivesAllChanges(true); //常時onTrackingEventを呼ぶ
    
    NSString *trackingid01 = [[NSBundle mainBundle] pathForResource:@"idmarkerConfig" ofType:@"zip"];
    if(trackingid01){
        bool success = m_metaioSDK->setTrackingConfiguration([trackingid01 UTF8String]);
        if(!success){
            NSLog(@"No success loading the trackingconfiguration");
        }
    }else{
        NSLog(@"No success loading the trackingconfiguration");
    }

}

- (void)onTrackingEvent:(const metaio::stlcompat::Vector<metaio::TrackingValues> &)poses{
    
    if((poses[0].quality >= 0.5)||((poses[1].quality >= 0.5))){
        self.arview.armarkerRecog = YES;
        self.arview.capaRecog = NO;
        
        //[self.recogSound play];
        
        NSString *markerName = [NSString stringWithCString:poses[0].cosName.c_str() encoding:[NSString defaultCStringEncoding]];
        [self recogARID:markerName];
        
        
        self.arview.transComp = poses[0].translation;
        
        
        self.arview.arLocation = metaio::Vector2d(poses[0].translation.y, poses[0].translation.x);
        
        self.arview.arLocaCGPoint = CGPointMake(968*(self.arview.arLocation.x/175)+(968/2)-180, 1024*(self.arview.arLocation.y/210)+(1024/2));
        
        //角度  Rotation → Vector3d
        self.arview.rotation = poses[0].rotation.getEulerAngleDegrees();

        
        NSLog(@"3次元 x座標:%f, y座標:%f, z座標:%f", self.arview.transComp.y, self.arview.transComp.x, self.arview.transComp.z); //3次元座標

        NSLog(@"2次元 x座標:%f, y座標:%f ", self.arview.arLocaCGPoint.x, self.arview.arLocaCGPoint.y); //2次元座標
        
        NSLog(@"cosName: %s", poses[0].cosName.c_str());
        [self.arview setNeedsDisplay];
        //[self generateParticle];
        self.emitterLayer.emitterPosition = CGPointMake(self.arview.arLocaCGPoint.x, self.arview.arLocaCGPoint.y);
        
    }else{
        self.arview.armarkerRecog = NO;
        //[self.arview removeParticle];
        [self.arview setNeedsDisplay];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//マーカー設定ファイル読み込み (AR)
- (void)loadConfig {
    //NSString *trackingid01 = [[NSBundle mainBundle] pathForResource:@"idmarkerConfig" ofType:@"zip"];
    NSString *trackingid01 = [[NSBundle mainBundle] pathForResource:@"idmarkerConfig2D" ofType:@"zip"];
    if(trackingid01){
        bool success = m_metaioSDK->setTrackingConfiguration([trackingid01 UTF8String]);
        if(!success){
            NSLog(@"No success loading the trackingconfiguration");
        }
    }else{
        NSLog(@"No success loading the trackingconfiguration");
    }
}

- (void)recogARID:(NSString *)markerName{
    
    /*
    if([markerName isEqualToString:@"patt01_1"]){
        self.arview.aridNum = 1;
    }else{
        self.arview.aridNum = 0;
        NSLog(@"maker name is %@", markerName);
    }
     */
    
    
    /*
    if([markerName isEqualToString:@"id01_1_1"]){
        self.arview.aridNum = 1;
    }else{
        self.arview.aridNum = 0;
        NSLog(@"maker name is %@", markerName);
    }
    */
    
    if([markerName isEqualToString:@"ID marker 1"]){
        self.arview.aridNum = 1;
    }else if([markerName isEqualToString:@"ID marker 2"]){
        self.arview.aridNum = 2;
    }else{
        self.arview.aridNum = 0;
        NSLog(@"maker name is %@", markerName);
    }
}


/*
- (void)generateParticle {
    //NSLog(<#NSString *format, ...#>);
    //mouseX =
    self.emitterLayer.emitterPosition = CGPointMake(size.width / 2, size.height / 2);
    
    CAEmitterCell *emittercell = [CAEmitterCell emitterCell];
    UIImage *image = [UIImage imageNamed:@"particle2.png"];
    emittercell.contents = (__bridge id)(image.CGImage);
    emittercell.emissionLongitude = M_PI * 2;
    emittercell.emissionRange = M_PI * 2;
    emittercell.birthRate = 800;
    emittercell.lifetimeRange = 1.2;
    emittercell.velocity = 240;
    emittercell.color = [UIColor colorWithRed:0.85 green:0.56 blue:0.36 alpha:0.5].CGColor;
    
    self.emitterLayer.emitterCells = @[emittercell];
}
 */



@end
