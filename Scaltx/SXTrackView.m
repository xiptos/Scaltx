//
//  SXTrackView.m
//  Scaltx
//
//  Created by Rui Lopes on 14/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import "SXTrackView.h"
#import "SXTrack.h"

@implementation SXTrackView {
    SXTrack* track;
}

- (id)initWithFrame:(CGRect)frame track:(SXTrack*)t
{
    self = [super initWithFrame:frame];
    self.multipleTouchEnabled = YES;
    
    if (self) {
        track = t;
        self.opaque = false;
        
        if (self.carLayer != nil) {
            [self.carLayer removeFromSuperlayer];
            self.carLayer = nil;
        }

        UIImage *carImage = [UIImage imageNamed:track.carName];
        _carLayer = [CALayer layer];
        _carLayer.contents = (id)carImage.CGImage;
        _carLayer.frame = CGRectMake(0.0f, 0.0f, carImage.size.width, carImage.size.height);
        _carLayer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.layer addSublayer:_carLayer];
    }
    return self;
}

//- (void)drawRect:(CGRect)rect {
//    NSLog(@"Draw rect");
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextAddPath(ctx, track.path);
//    CGContextSetStrokeColorWithColor(ctx,[UIColor whiteColor].CGColor);
//    CGContextStrokePath(ctx);
//
//    [track.trackPoints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSValue* value = (NSValue*)obj;
//        CGPoint p = value.CGPointValue;
//
//        CGRect cRect = CGRectMake(p.x,p.y,2,2);
//
//        CGContextAddEllipseInRect(ctx, cRect);
//        CGContextStrokePath(ctx);
//
//    }];
//}

- (void) moveCarOnPath:(CGPathRef)path angle:(double)angle duration:(double)duration
{
    [self.carLayer removeAllAnimations];
    
    self.carLayer.hidden = NO;
    
    self.carLayer.transform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0);
    
    CAKeyframeAnimation *carAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    carAnimation.duration = duration;
    carAnimation.path = path;
    carAnimation.calculationMode = kCAAnimationPaced;
    carAnimation.delegate = self;
    [self.carLayer addAnimation:carAnimation forKey:@"position"];
}

#pragma mark animation delegate methods
- (void)animationWillStart:(NSString *)animationID context:(void *)context
{
    
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    
}
@end
