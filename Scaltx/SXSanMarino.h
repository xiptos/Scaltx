//
//  SXSanMarino.h
//  Scaltx
//
//  Created by Rui Lopes on 15/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXTrack.h"

@interface SXSanMarino : NSObject

@property(nonatomic, readonly, strong) SXTrack* track1;
@property(nonatomic, readonly, strong) SXTrack* track2;

@property(nonatomic, readonly, strong) NSString* trackName;

+ (SXSanMarino*)sharedInstance;

@end
