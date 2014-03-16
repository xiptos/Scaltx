//
//  SXTrackLine.h
//  Scaltx
//
//  Created by Rui Lopes on 15/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXTrackLine : NSObject

@property(nonatomic) CGPoint startPoint;
@property(nonatomic) CGPoint endPoint;

-(id)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

+(SXTrackLine*)lineWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

-(double)sin;
-(double)cos;
-(double)length;

-(CGPoint)coordinatesWithLength:(double)length;

-(NSArray*)pointsSpaced:(double)space;

@end
