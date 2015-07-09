//
//  PKActivityIndicator.m
//  PKRefreshControlDemo
//
//  Created by shimokawa on 1/12/15.
//  Copyright (c) 2015 Goodpatch. All rights reserved.
//

#import "PKActivityIndicator.h"

static NSString * const PKActivityIndicatorAnimationKey = @"PKActivityIndicatorAnimationKey";

@interface PKActivityIndicator ()
@property (nonatomic) CALayer *marker;
@property (nonatomic) CAReplicatorLayer *spinnerReplicator;
@property (nonatomic) CABasicAnimation *fadeAnimation;
@property (nonatomic) NSUInteger spinnerInstanceCount;
@end

@implementation PKActivityIndicator

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor clearColor];

    self.marker = [CALayer layer];
    self.spinnerReplicator = [CAReplicatorLayer layer];
    self.fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    self.fadeAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    self.fadeAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    self.fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    self.fadeAnimation.repeatCount = HUGE_VALF;
    
    self.marker.opacity = 1.0f;
    self.spinnerReplicator.transform = CATransform3DRotate(self.spinnerReplicator.transform, M_PI, 0.0f, 0.0f, 1.0f);
    self.aperture = 10.0f;
    self.barWidth = 2.0f;
    self.barHeight = 8.0f;
    self.barColor = [UIColor colorWithWhite:0 alpha:.8];
    self.numberOfBars = 12.0f;
    self.anmDuration = 1.0f;
    
    [self createLayers];
    [self updateLayers];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateLayers];
}

- (void)updateLayers
{
    CGFloat side = self.aperture*2 + self.barHeight*2;
    self.bounds = CGRectMake(0, 0, side, side);
    // Update marker
    self.marker.bounds = CGRectMake(0.0f, 0.0f, self.barWidth, self.barHeight);
    self.marker.cornerRadius = self.barWidth/2;
    self.marker.backgroundColor = self.barColor.CGColor;
    self.marker.position = CGPointMake(side * 0.5f, side * 0.5f + self.aperture);
    
    // Update replicaitons
    self.spinnerReplicator.bounds = CGRectMake(0.0f, 0.0f, side, side);
    self.spinnerReplicator.cornerRadius = 10.0f;
    self.spinnerReplicator.position = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds));
    
    CGFloat angle = (2.0f * M_PI) / (self.numberOfBars);
    CATransform3D instanceRotation = CATransform3DMakeRotation(angle, 0.0f, 0.0f, 1.0f);
    self.spinnerReplicator.instanceCount = self.spinnerInstanceCount;
    self.spinnerReplicator.instanceTransform = instanceRotation;
}

- (void)createLayers {
    [self.spinnerReplicator addSublayer:self.marker];
    [self.layer addSublayer:self.spinnerReplicator];
    self.marker.opacity = 0.0f;
}

#pragma mark - public

- (void)startAnimating {
    [self.fadeAnimation setDuration:self.anmDuration];
    CGFloat markerAnimationDuration = self.anmDuration / self.numberOfBars;
    self.spinnerReplicator.instanceDelay = markerAnimationDuration;
    [self.marker addAnimation:self.fadeAnimation forKey:PKActivityIndicatorAnimationKey];
    self.spinnerReplicator.instanceCount = self.spinnerInstanceCount;
}

- (void)stopAnimating
{
    [self.marker removeAnimationForKey:PKActivityIndicatorAnimationKey];
}

- (BOOL)isAnimating
{
    return [self.marker animationForKey:PKActivityIndicatorAnimationKey] != nil;
}

- (void)setSpinnerReplicatorInstanceCountWithPercentage:(CGFloat)percentage {
    self.marker.opacity = 1.0;
    NSInteger count = MAX(0,percentage) * self.numberOfBars;
    self.spinnerReplicator.instanceCount = count;
    self.spinnerInstanceCount = count;
}

#pragma mark - Accessor

- (void)setBarColor:(UIColor *)barColor {
    _barColor = barColor;
    [self updateLayers];
}

- (void)setBarWidth:(CGFloat)barWidth {
    _barWidth = barWidth;
    [self updateLayers];
}

- (void)setBarHeight:(CGFloat)barHeight {
    _barHeight = barHeight;
    [self updateLayers];
}

- (void)setAperture:(CGFloat)aperture {
    _aperture = aperture;
    [self updateLayers];
}

- (void)setNumberOfBars:(NSUInteger)numberOfBars {
    _numberOfBars = numberOfBars;
    _spinnerInstanceCount = numberOfBars;
    [self updateLayers];
}

@end
