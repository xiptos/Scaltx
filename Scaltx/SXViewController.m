//
//  SXViewController.m
//  Scaltx
//
//  Created by Rui Lopes on 06/03/14.
//  Copyright (c) 2014 Rui Lopes. All rights reserved.
//

#import "SXViewController.h"

@interface SXViewController ()

@end

@implementation SXViewController {
    double speed1;
    double previousTime;
    double previousPosition;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch=[touches anyObject];
    CGPoint touchPosition=[touch locationInView:self.view];
    speed1 = 0;
    previousTime = CACurrentMediaTime();
    previousPosition = touchPosition.x;
    
    NSLog(@"TouchesBegan: %f,%f",touchPosition.x, touchPosition.y);
//    for(int i=0;i<9;i++) {
//        if(CGRectContainsPoint(_boardPositions[i].frame, touchPosition)) {
//            [_board playForPosition:i];
//            [self updateBoard];
//        }
//    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch=[touches anyObject];
    CGPoint touchPosition=[touch locationInView:self.view];
    
    double currentTime = CACurrentMediaTime();
    double currentPosition = touchPosition.x;
    
    speed1 = (currentPosition - previousPosition) / (currentTime - previousTime);
    
    previousPosition = currentPosition;
    previousTime = currentTime;
    NSLog(@"Speed: %f",speed1);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch=[touches anyObject];
    CGPoint touchPosition=[touch locationInView:self.view];
    NSLog(@"TouchesEnded: %f,%f",touchPosition.x, touchPosition.y);
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch=[touches anyObject];
    CGPoint touchPosition=[touch locationInView:self.view];
    NSLog(@"TouchesCancelled: %f,%f",touchPosition.x, touchPosition.y);
    
}

@end
