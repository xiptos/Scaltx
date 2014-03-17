//
//  SXRaceTrack.h
//  Scaltx
//
//  Created by Rui Lopes on 17/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXTrack;

@protocol SXRaceTrack <NSObject>

@property(nonatomic, readonly, strong) NSString* trackName;

-(int)numberOfTracks;
-(SXTrack*)track:(int)index;

@end
