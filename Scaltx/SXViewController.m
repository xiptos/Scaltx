//
//  SXViewController.m
//  Scaltx
//
//  Created by Rui Lopes on 06/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import "SXViewController.h"
#import "SXTrack.h"
#import "SXTrackView.h"
#import "SXRaceTrack.h"
#import "SXRaceTrackFactory.h"

#define DELAY 100

@interface SXViewController ()

@end


@implementation SXViewController {
    CADisplayLink* _displayLink;
    
    SXTrackView* track1View;
    SXTrackView* track2View;

    float previousPosition1;
    float previousPosition2;
    
    double deltaS1;
    double deltaS2;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    id<SXRaceTrack> raceTrack = [[SXRaceTrackFactory sharedInstance] raceTrack:0];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:raceTrack.trackName]];

    [self.view addSubview:imageView];

    track1View = [[SXTrackView alloc] initWithFrame:self.view.frame track:[raceTrack track:0]];
    [self.view addSubview:track1View];
    track2View = [[SXTrackView alloc] initWithFrame:self.view.frame track:[raceTrack track:1]];
    [self.view addSubview:track2View];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop)];
    
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark game logic

-(void)gameLoop
{
    double currentTime = CACurrentMediaTime();
    
    id<SXRaceTrack> raceTrack = [[SXRaceTrackFactory sharedInstance] raceTrack:0];
    [[raceTrack track:0] update:currentTime deltaS:deltaS1];
    [[raceTrack track:1] update:currentTime deltaS:deltaS2];
    [self updateTrack];
}


-(void)updateTrack
{
    id<SXRaceTrack> raceTrack = [[SXRaceTrackFactory sharedInstance] raceTrack:0];

    CGPathRef path1 = [raceTrack track:0].motionPath;
    double angle1 = [raceTrack track:0].carAngle;
    CGPathRef path2 = [raceTrack track:1].motionPath;
    double angle2 = [raceTrack track:1].carAngle;
    
    [track1View moveCarOnPath:path1 angle:angle1 duration:1];
    [track2View moveCarOnPath:path2 angle:angle2 duration:1];

    // Check for victory...
}


#pragma mark user input

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch * touch = obj;

        CGPoint touchPosition=[touch locationInView:self.view];
        
        if(touchPosition.y<150) {
            previousPosition1 = touchPosition.x;
        } else if(touchPosition.y>330) {
            previousPosition2 = touchPosition.x;
        }
        
    }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch * touch = obj;
        
        CGPoint touchPosition=[touch locationInView:self.view];
    
        if(touchPosition.y<150) {
            deltaS1 = (previousPosition1 - touchPosition.x)/DELAY;
            previousPosition1 = touchPosition.x;

        } else if(touchPosition.y>330) {
            deltaS2 = (touchPosition.x - previousPosition2)/DELAY;
            previousPosition2 = touchPosition.x;

        }
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch * touch = obj;
        
        CGPoint touchPosition=[touch locationInView:self.view];
        if(touchPosition.y<150) {
            deltaS1 = 0;
        } else if(touchPosition.y>330) {
            deltaS2 = 0;
        }
    }];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch * touch = obj;
        
        CGPoint touchPosition=[touch locationInView:self.view];
        if(touchPosition.y<150) {
            deltaS1 = 0;
        } else if(touchPosition.y>330) {
            deltaS2 = 0;
        }
    }];
    
    
}

@end
