//
//  SXTrackArc.h
//  Scaltx
//
//  Created by Rui Lopes on 15/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXTrackArc : NSObject

@property(nonatomic) CGPoint center;
@property(nonatomic) double radius;
@property(nonatomic) double startAngle;
@property(nonatomic) double endAngle;
@property(nonatomic) bool clockwise;
@property(nonatomic, readonly) CGPoint endPoint;
@property(nonatomic, readonly) CGPoint startPoint;

-(id)initWithCenter:(CGPoint)center radius:(double)radius startAngle:(double)startAngle endAngle:(double)endAngle clockwise:(bool)clockwise;

+(SXTrackArc*)arcWithCenter:(CGPoint)center radius:(double)radius startAngle:(double)startAngle endAngle:(double)endAngle clockwise:(bool)clockwise;

-(NSArray*)pointsSpaced:(double)space;

@end
