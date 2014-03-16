//
//  SXTrackView.h
//  Scaltx
//
//  Created by Rui Lopes on 14/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SXTrack.h"

@interface SXTrackView : UIView
@property (nonatomic, retain) CALayer *carLayer;


-(id)initWithFrame:(CGRect)frame track:(SXTrack*)track;
-(void)moveCarOnPath:(CGPathRef)path angle:(double)angle duration:(double)duration;

@end
