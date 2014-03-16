//
//  SXTrack.h
//  Scaltx
//
//  Created by Rui Lopes on 14/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXTrack : NSObject
@property(nonatomic, readonly) CGPathRef path;
@property(nonatomic, readonly) NSArray* trackPoints;
@property(nonatomic, readonly) NSString* carName;

-(id)initWithPoint:(CGPoint)point carName:(NSString*)carName carAngle:(double)angle;

-(void)lineTo:(CGPoint)point;
-(void)arcWithCenter:(CGPoint)center radius:(double)radius startAngle:(double)startAngle endAngle:(double)endAngle clockwise:(bool)clockwise;

@property(nonatomic, readonly) double carAngle;
@property(nonatomic, readonly) CGPathRef motionPath;

-(void)update:(double)time deltaS:(double)deltaS;
-(void)close;

@end
