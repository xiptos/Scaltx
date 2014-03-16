//
//  SXTrackArc.m
//  Scaltx
//
//  Created by Rui Lopes on 15/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import "SXTrackArc.h"

@implementation SXTrackArc

-(CGPoint)startPoint
{
    CGPoint startPoint = CGPointMake(self.center.x+self.radius*cos(self.startAngle), self.center.y+self.radius*sin(self.startAngle));
    return startPoint;
}

-(CGPoint)endPoint
{
    CGPoint endPoint = CGPointMake(self.center.x+self.radius*cos(self.endAngle), self.center.y+self.radius*sin(self.endAngle));
    return endPoint;
    
}

-(id)initWithCenter:(CGPoint)center radius:(double)radius startAngle:(double)startAngle endAngle:(double)endAngle clockwise:(bool)clockwise
{
    self = [super init];
    if(self) {
        _center = center;
        _radius = radius;
        _startAngle = [self normalizeAngle:startAngle];
        _endAngle = [self normalizeAngle:endAngle];
        _clockwise = clockwise;
    }
    return self;
}

-(double)normalizeAngle:(double)angle
{
    double newAngle = angle;
    while (newAngle <= -M_PI) newAngle += 2*M_PI;
    while (newAngle > M_PI) newAngle -= 2*M_PI;
    return newAngle;
}

+(SXTrackArc*)arcWithCenter:(CGPoint)center radius:(double)radius startAngle:(double)startAngle endAngle:(double)endAngle clockwise:(bool)clockwise
{
    SXTrackArc* arc = [[SXTrackArc alloc] initWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    return arc;
}

-(double)lengthAngle
{
    return self.endAngle - self.startAngle;
}

-(NSArray*)pointsSpaced:(double)space
{
    NSMutableArray* array = [NSMutableArray array];
    double angle = self.startAngle;
    double spaceAngle = space/self.radius;

    while(fabs(self.endAngle-angle)>=spaceAngle) {
        CGPoint p = CGPointMake(self.center.x + self.radius*cos(angle), self.center.y + self.radius*sin(angle));
        [array addObject:[NSValue valueWithCGPoint:p]];
        if(self.clockwise) {
            angle -= spaceAngle;
        } else {
            angle += spaceAngle;
        }
        angle = [self normalizeAngle:angle];
    }

    return array;
}

@end
