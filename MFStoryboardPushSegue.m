//
//  MFStoryboardPushSegue.m
//  Mentally Friendly
//
//  Created by Kyle Fuller on 14/10/2013.
//  Copyright (c) 2013 Mentally Friendly. All rights reserved.
//

#import "MFStoryboardPushSegue.h"


@implementation MFStoryboardPushSegue

- (void)perform {
    UIViewController *sourceViewController = [self sourceViewController];
    UIViewController *destinationViewController = [self destinationViewController];
    UIView *sourceSnapshot = [[sourceViewController view] snapshotViewAfterScreenUpdates:YES];

    [sourceViewController presentViewController:destinationViewController animated:NO completion:nil];

    UIView *destinationView = [destinationViewController view];
    UIView *superView = [destinationView superview];

    [superView insertSubview:sourceSnapshot belowSubview:destinationView];

    CGRect destinationFrame = [destinationView frame];
    CGRect snapshotFrame = [sourceSnapshot frame];

    [destinationView setFrame:CGRectMake(destinationFrame.size.width, 0, destinationFrame.size.width, destinationFrame.size.height)];
    [[destinationView layer] setShadowColor:[UIColor grayColor].CGColor];
    [[destinationView layer] setShadowOffset:CGSizeMake(-5, 0)];
    [[destinationView layer] setShadowOpacity:0.2f];

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [sourceSnapshot setFrame:CGRectMake(- roundf(snapshotFrame.size.width / 3), 0, snapshotFrame.size.width, snapshotFrame.size.height)];
        [destinationView setFrame:destinationFrame];
    } completion:^(BOOL finished) {
        [sourceSnapshot removeFromSuperview];
    }];
}

@end

