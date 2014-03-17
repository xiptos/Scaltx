//
//  SXRaceTrackFactory.h
//  Scaltx
//
//  Created by Rui Lopes on 17/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXRaceTrack.h"

@interface SXRaceTrackFactory : NSObject

+(SXRaceTrackFactory*)sharedInstance;

-(int)count;
-(id<SXRaceTrack>)raceTrack:(int)n;

@end
