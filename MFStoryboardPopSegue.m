//
//  MFStoryboardPopSegue.m
//  Mentally Friendly
//
//  Created by Kyle Fuller on 14/10/2013.
//  Copyright (c) 2013 Mentally Friendly. All rights reserved.
//

#import "MFStoryboardPopSegue.h"


@implementation MFStoryboardPopSegue

- (void)perform {
    UIViewController *sourceViewController = [self sourceViewController];
    UIViewController *destinationViewController = [self destinationViewController];
    UIView *sourceSnapshot = [[sourceViewController view] snapshotViewAfterScreenUpdates:YES];

    [sourceViewController dismissViewControllerAnimated:NO completion:nil];

    UIView *destinationView = [destinationViewController view];
    UIView *superView = [destinationView superview];
    [superView insertSubview:sourceSnapshot aboveSubview:destinationView];

    CGRect destinationFrame = [destinationView frame];
    CGRect snapshotFrame = [sourceSnapshot frame];
    [destinationView setFrame:CGRectMake(- roundf(destinationFrame.size.width / 3), 0, destinationFrame.size.width, destinationFrame.size.height)];

    [[sourceSnapshot layer] setShadowColor:[UIColor grayColor].CGColor];
    [[sourceSnapshot layer] setShadowOffset:CGSizeMake(-5, 0)];
    [[sourceSnapshot layer] setShadowOpacity:0.2f];

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [sourceSnapshot setFrame:CGRectMake(snapshotFrame.size.width, 0, snapshotFrame.size.width, snapshotFrame.size.height)];
        [destinationView setFrame:destinationFrame];
    } completion:^(BOOL finished) {
        [sourceSnapshot removeFromSuperview];
    }];
}

@end

