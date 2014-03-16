//
//  SXSanMarino.m
//  Scaltx
//
//  Created by Rui Lopes on 15/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import "SXSanMarino.h"

@implementation SXSanMarino

-(id)init
{
    self = [super init];
    if(self) {
        _trackName = @"track";
        [self setupTracks];
    }
    return self;
}

+ (SXSanMarino*)sharedInstance
{
    static SXSanMarino *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SXSanMarino alloc] init];
    });
    return _sharedInstance;
}

-(void)setupTracks
{
    _track1 = [[SXTrack alloc] initWithPoint:CGPointMake(260, 150) carName:@"greencar" carAngle:3*M_PI_2];
    [_track1 lineTo:CGPointMake(260, 123)];
    [_track1 arcWithCenter:CGPointMake(200, 123) radius:60 startAngle:0 endAngle:3*M_PI_2 clockwise:TRUE];
    [_track1 lineTo:CGPointMake(100, 62)];
    [_track1 arcWithCenter:CGPointMake(100, 123) radius:60 startAngle:3*M_PI_2 endAngle:M_PI clockwise:TRUE];
    [_track1 lineTo:CGPointMake(40, 154)];
    [_track1 lineTo:CGPointMake(55, 215)];
    [_track1 lineTo:CGPointMake(55, 253)];
    [_track1 arcWithCenter:CGPointMake(100, 253) radius:45 startAngle:M_PI endAngle:M_PI_2 clockwise:TRUE];
    [_track1 lineTo:CGPointMake(207, 298)];
    [_track1 arcWithCenter:CGPointMake(207, 358) radius:60 startAngle:3*M_PI_2 endAngle:M_PI clockwise:FALSE];
    [_track1 lineTo:CGPointMake(147, 155)];
    [_track1 arcWithCenter:CGPointMake(179, 155) radius:32 startAngle:M_PI endAngle:0 clockwise:FALSE];
    [_track1 lineTo:CGPointMake(211, 250)];
    [_track1 arcWithCenter:CGPointMake(228, 250) radius:17 startAngle:M_PI endAngle:0 clockwise:TRUE];
    [_track1 lineTo:CGPointMake(260, 189)];
    [_track1 close];
    
    
    _track2 = [[SXTrack alloc] initWithPoint:CGPointMake(245, 150) carName:@"yellowcar" carAngle:3*M_PI_2];
    [_track2 lineTo:CGPointMake(245, 123)];
    [_track2 arcWithCenter:CGPointMake(200, 123) radius:45 startAngle:0 endAngle:3*M_PI_2 clockwise:TRUE];
    [_track2 lineTo:CGPointMake(100, 77)];
    [_track2 arcWithCenter:CGPointMake(100, 123) radius:45 startAngle:3*M_PI_2 endAngle:M_PI clockwise:TRUE];
    [_track2 lineTo:CGPointMake(55, 154)];
    [_track2 lineTo:CGPointMake(39, 215)];
    [_track2 lineTo:CGPointMake(39, 253)];
    [_track2 arcWithCenter:CGPointMake(100, 253) radius:60 startAngle:M_PI endAngle:M_PI_2 clockwise:TRUE];
    [_track2 lineTo:CGPointMake(207, 313)];
    [_track2 arcWithCenter:CGPointMake(207, 358) radius:45 startAngle:3*M_PI_2 endAngle:M_PI clockwise:FALSE];
    [_track2 lineTo:CGPointMake(162, 155)];
    [_track2 arcWithCenter:CGPointMake(179, 155) radius:17 startAngle:M_PI endAngle:0 clockwise:FALSE];
    [_track2 lineTo:CGPointMake(194, 250)];
    [_track2 arcWithCenter:CGPointMake(228, 250) radius:32 startAngle:M_PI endAngle:0 clockwise:TRUE];
    [_track2 lineTo:CGPointMake(245, 189)];
    [_track2 close];

}
@end
