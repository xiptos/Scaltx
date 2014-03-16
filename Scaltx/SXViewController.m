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
#import "SXSanMarino.h"

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
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[SXSanMarino sharedInstance].trackName]];

    [self.view addSubview:imageView];

    track1View = [[SXTrackView alloc] initWithFrame:self.view.frame track:[SXSanMarino sharedInstance].track1];
    [self.view addSubview:track1View];
    track2View = [[SXTrackView alloc] initWithFrame:self.view.frame track:[SXSanMarino sharedInstance].track2];
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
    [[SXSanMarino sharedInstance].track1 update:currentTime deltaS:deltaS1];
    [[SXSanMarino sharedInstance].track2 update:currentTime deltaS:deltaS2];
    [self updateTrack];
}


-(void)updateTrack
{
    
    CGPathRef path1 = [SXSanMarino sharedInstance].track1.motionPath;
    double angle1 = [SXSanMarino sharedInstance].track1.carAngle;
    CGPathRef path2 = [SXSanMarino sharedInstance].track2.motionPath;
    double angle2 = [SXSanMarino sharedInstance].track2.carAngle;
    
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
            deltaS1 = previousPosition1 - touchPosition.x;
            previousPosition1 = touchPosition.x;

        } else if(touchPosition.y>330) {
            deltaS2 = touchPosition.x - previousPosition2;
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
