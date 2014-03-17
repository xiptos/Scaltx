//
//  SXRaceTrackFactory.m
//  Scaltx
//
//  Created by Rui Lopes on 17/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import "SXRaceTrackFactory.h"
#import "SXSanMarino.h"

@implementation SXRaceTrackFactory {
    NSArray* raceTracks;
}

-(id)init
{
    self = [super init];
    if(self) {
        raceTracks = [NSArray arrayWithObjects:[[SXSanMarino alloc] init], nil];
    }
    return self;
}

+ (SXRaceTrackFactory*)sharedInstance
{
    static SXRaceTrackFactory *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SXRaceTrackFactory alloc] init];
    });
    return _sharedInstance;
}

-(int)count
{
    return raceTracks.count;
}

-(id<SXRaceTrack>)raceTrack:(int)n
{
    return [raceTracks objectAtIndex:n];
}

@end
