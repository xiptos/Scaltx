//
//  SXTrack.m
//  Scaltx
//
//  Created by Rui Lopes on 14/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import "SXTrack.h"
#import "SXTrackLine.h"
#import "SXTrackArc.h"

#define A 10000
#define POINT_INTERVAL 5

@implementation SXTrack {
    
    NSMutableArray* trackElements;
    NSMutableArray* _trackPoints;
    NSInteger trackPointsIndex;
    
    CGMutablePathRef _motionPath;
    
    double previousTime;
    double acculumatedDelta;
    double speed;
    double _carAngle;
    
    CGPoint _startPoint;
}

@dynamic path;
@dynamic carAngle;
@dynamic trackPoints;
@dynamic motionPath;

-(NSArray*)trackPoints
{
    return _trackPoints;
}

-(double)carAngle
{
    return _carAngle;
}

-(CGPathRef)motionPath
{
    return _motionPath;
}

-(CGPathRef)path
{
    CGMutablePathRef mutablePath;
    mutablePath = CGPathCreateMutable();
    CGPathMoveToPoint(mutablePath, NULL, _startPoint.x, _startPoint.y);

    [trackElements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[SXTrackLine class]]) {
            SXTrackLine* line = (SXTrackLine*) obj;
            CGPathAddLineToPoint(mutablePath, NULL, line.endPoint.x, line.endPoint.y);

        } else if([obj isKindOfClass:[SXTrackArc class]]) {
            SXTrackArc* arc = (SXTrackArc*) obj;
            CGPathAddArc(mutablePath, NULL, arc.center.x, arc.center.y, arc.radius, arc.startAngle, arc.endAngle, arc.clockwise);
        }

    }];

    CGPathCloseSubpath(mutablePath);

    return mutablePath;
}

-(id)initWithPoint:(CGPoint)point carName:(NSString *)c carAngle:(double)angle
{
    self = [super init];
    if(self) {
        trackElements = [NSMutableArray array];
        _trackPoints = [NSMutableArray array];
        trackPointsIndex = 0;
        
        acculumatedDelta = 0;
        speed = 0;
        previousTime = 0;
        
        _startPoint = point;
        _carName = c;
        _carAngle = angle;

    }
    return self;
}

-(void)lineTo:(CGPoint)point
{
    CGPoint startPoint;
    if(trackElements.count==0) {
        startPoint = _startPoint;
    } else {
        id lastElement = [trackElements lastObject];
        if([lastElement isKindOfClass:[SXTrackLine class]]) {
            startPoint = ((SXTrackLine*)lastElement).endPoint;
        } else if([lastElement isKindOfClass:[SXTrackArc class]]) {
            startPoint = ((SXTrackArc*)lastElement).endPoint;
        }
    }
    
    SXTrackLine* line = [SXTrackLine lineWithStartPoint:startPoint endPoint:point];
    [trackElements addObject:line];
    [_trackPoints addObjectsFromArray:[line pointsSpaced:POINT_INTERVAL]];
}

-(void)close
{
    CGPoint startPoint;
    
    id firstElement = [trackElements firstObject];
    if([firstElement isKindOfClass:[SXTrackLine class]]) {
        startPoint = ((SXTrackLine*)firstElement).startPoint;
    } else if([firstElement isKindOfClass:[SXTrackArc class]]) {
        startPoint = ((SXTrackArc*)firstElement).endPoint;
    }
    
    [self lineTo:startPoint];
}

-(void)arcWithCenter:(CGPoint)center radius:(double)radius startAngle:(double)startAngle endAngle:(double)endAngle clockwise:(bool)clockwise
{
    SXTrackArc* arc = [SXTrackArc arcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    [trackElements addObject:arc];
    [_trackPoints addObjectsFromArray:[arc pointsSpaced:POINT_INTERVAL]];
}

-(void)update:(double)time deltaS:(double)deltaS
{
    if(previousTime == 0) {
        previousTime = time;
    }

    if(deltaS>0) {
        speed = deltaS / (time - previousTime);
    }
    
    double calculatedDeltaS = speed * (time - previousTime);
    if(speed>0) {
        speed = speed - A * (time - previousTime);
    } else {
        speed = 0;
    }

    acculumatedDelta+=calculatedDeltaS;
    
    NSValue* currentValuePoint = [_trackPoints objectAtIndex:trackPointsIndex];
    CGPoint currentPoint = currentValuePoint.CGPointValue;
    
    while(acculumatedDelta>POINT_INTERVAL) {
        trackPointsIndex = (trackPointsIndex + 1) % _trackPoints.count;
        acculumatedDelta -= POINT_INTERVAL;
    }

    NSValue* dstValuePoint = [_trackPoints objectAtIndex:trackPointsIndex];
    CGPoint dstPoint = dstValuePoint.CGPointValue;

    if(_motionPath != NULL) {
        CGPathRelease(_motionPath);
    }
    _motionPath = CGPathCreateMutable();
    CGPathMoveToPoint(_motionPath, NULL, currentPoint.x, currentPoint.y);
    CGPathAddLineToPoint(_motionPath, NULL, dstPoint.x, dstPoint.y);
    
    float yDiff = dstPoint.y - currentPoint.y;
    float xDiff = dstPoint.x - currentPoint.x;
    if(yDiff!=0 && xDiff!=0) {
        _carAngle = atan2(yDiff, xDiff);
    }
    previousTime = time;
}

@end
