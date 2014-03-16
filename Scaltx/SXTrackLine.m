//
//  SXTrackLine.m
//  Scaltx
//
//  Created by Rui Lopes on 15/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import "SXTrackLine.h"

@implementation SXTrackLine

-(id)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    self = [super init];
    if(self) {
        _startPoint = startPoint;
        _endPoint = endPoint;
    }
    return self;
}

+(SXTrackLine*)lineWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    SXTrackLine* line = [[SXTrackLine alloc] initWithStartPoint:startPoint endPoint:endPoint];
    return line;
}

-(double)sin
{
    double s = (self.endPoint.y - self.startPoint.y)/sqrt(pow(self.endPoint.y-self.startPoint.y, 2) + pow(self.endPoint.x - self.startPoint.x, 2));
    return s;
}

-(double)cos
{
    double s = (self.endPoint.x - self.startPoint.x)/sqrt(pow(self.endPoint.y-self.startPoint.y, 2) + pow(self.endPoint.x - self.startPoint.x, 2));
    return s;
}

-(CGPoint)coordinatesWithLength:(double)length
{
    CGPoint p = CGPointMake(length * self.cos, length * self.sin);
    return p;
}

-(double)length
{
    return sqrt(pow(self.endPoint.x-self.startPoint.x, 2) + pow(self.endPoint.y - self.startPoint.y, 2));
}

-(NSArray*)pointsSpaced:(double)space
{
    NSMutableArray* array = [NSMutableArray array];
    double totalSpace = 0;
    double length = [self length];
    while(totalSpace < length) {
        CGPoint p = CGPointMake(self.startPoint.x + (self.endPoint.x - self.startPoint.x)*totalSpace/length, self.startPoint.y + (self.endPoint.y - self.startPoint.y)*totalSpace/length);
        [array addObject:[NSValue valueWithCGPoint:p]];
        totalSpace += space;
    }

    return array;
}

@end
