//
//  MMShineManager.m
//  MMSkin
//
//  Created by 黄进文 on 2017/2/19.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import "MMShineManager.h"

@interface MMShineManager() {
    
    UIColor *shineColor;
    UIView *shineView;
    CAEmitterLayer *chargeLayer;
    CAEmitterLayer *explosionLayer;
}

@end

@implementation MMShineManager

+ (MMShineManager *)shareInstance {
    
    static MMShineManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)shineWithChildView:(UIView *)childView rootView:(UIView *)rootView fillColor:(UIColor *)fillColor {
    
    shineColor = fillColor;
    shineView = childView;
    
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.08 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CABasicAnimation *heart = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        heart.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        heart.duration = 0.08;
        heart.repeatCount = 1;
        heart.autoreverses = YES;
        heart.fromValue = [NSNumber numberWithFloat:0.6];
        heart.toValue = [NSNumber numberWithFloat:1.2];
        
        [[childView layer] addAnimation:heart forKey:nil];
        
        // 创建粒子效果
        // [self setupCAEmitterCell];
        
    } completion:^(BOOL finished) {
        
        // 开始粒子效果动画
        // [self startAnimation];
    }];
}

#pragma mark - 粒子效果
/// 开始动画
- (void)startAnimation {
    
    chargeLayer.beginTime = CACurrentMediaTime();
    [chargeLayer setValue:@80 forKeyPath:@"emitterCells.charge.birthRate"];
    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
}

- (void)explode {
    
    [chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    explosionLayer.beginTime = CACurrentMediaTime();
    [explosionLayer setValue:@300 forKeyPath:@"emitterCells.explosion.birthRate"];
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}

- (void)stop {
    
    [chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    [explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}

- (void)setupCAEmitterCell {
    
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosion";
    explosionCell.alphaRange = 0.20;
    explosionCell.alphaSpeed = -1.0;
    explosionCell.lifetime = 0.7;
    explosionCell.lifetimeRange = 0.3;
    explosionCell.birthRate = 0;
    explosionCell.velocity = 40.00;
    explosionCell.velocityRange = 10.00;
    explosionCell.contents = (id)[[UIImage imageNamed:@"MMSkin.bundle/shine.png"] CGImage];
    explosionCell.scale = 0.05;
    explosionCell.scaleRange = 0.02;
    
    explosionLayer = [CAEmitterLayer layer];
    explosionLayer.emitterPosition = shineView.center; // 确定中心点
    explosionLayer.name = @"emitterLayer";
    explosionLayer.emitterShape = kCAEmitterLayerCircle;
    explosionLayer.emitterMode = kCAEmitterLayerOutline;
    explosionLayer.emitterSize = CGSizeMake(25, 0);
    explosionLayer.emitterCells = @[explosionCell];
    explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    explosionLayer.masksToBounds = NO;
    explosionLayer.seed = 1366128504;
    [shineView.layer addSublayer:explosionLayer];
    
    CAEmitterCell *chargeCell = [CAEmitterCell emitterCell];
    chargeCell.name = @"charge";
    chargeCell.alphaRange = 0.20;
    chargeCell.alphaSpeed = -1.0;
    chargeCell.lifetime = 0.3;
    chargeCell.lifetimeRange = 0.1;
    chargeCell.birthRate = 0;
    chargeCell.velocity = -40.0;
    chargeCell.velocityRange = 0.00;
    chargeCell.contents = (id)[[UIImage imageNamed:@"MMSkin.bundle/shine.png"] CGImage];
    chargeCell.scale = 0.05;
    chargeCell.scaleRange = 0.02;
    
    chargeLayer = [CAEmitterLayer layer];
    chargeLayer.emitterPosition = shineView.center;  // 确定中心点
    chargeLayer.name = @"emitterLayer";
    chargeLayer.emitterShape = kCAEmitterLayerCircle;
    chargeLayer.emitterMode = kCAEmitterLayerOutline;
    chargeLayer.emitterSize = CGSizeMake(25, 0);
    chargeLayer.emitterCells = @[chargeCell];
    chargeLayer.renderMode = kCAEmitterLayerOldestFirst;
    chargeLayer.masksToBounds = NO;
    chargeLayer.seed = 1366128504;
    [shineView.layer addSublayer:chargeLayer];
}

@end






















