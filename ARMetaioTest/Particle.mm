//
//  Particle.m
//  ARMetaioParticle
//
//  Created by 池田昂平 on 2015/03/09.
//  Copyright (c) 2015年 池田昂平. All rights reserved.
//

#import "Particle.h"

@implementation Particle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)generateParticle {
    //mouseX =
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    CGSize size = self.bounds.size;
    emitterLayer.emitterPosition = CGPointMake(size.width / 2, size.height / 2);
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    [self.layer addSublayer:emitterLayer];
    
    
    CAEmitterCell *emittercell = [CAEmitterCell emitterCell];
    UIImage *image = [UIImage imageNamed:@"particle2.png"];
    emittercell.contents = (__bridge id)(image.CGImage);
    emittercell.emissionLongitude = M_PI * 2;
    emittercell.emissionRange = M_PI * 2;
    emittercell.birthRate = 800;
    emittercell.lifetimeRange = 1.2;
    emittercell.velocity = 240;
    emittercell.color = [UIColor colorWithRed:0.85 green:0.56 blue:0.36 alpha:0.5].CGColor;
    
    emitterLayer.emitterCells = @[emittercell];
}


@end
