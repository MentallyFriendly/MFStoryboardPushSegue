//
//  MFStoryboardPopSegue.m
//  Mentally Friendly
//
//  Created by Kyle Fuller on 14/10/2013.
//  Copyright (c) 2013-2014 Mentally Friendly. All rights reserved.
//

#import "MFStoryboardPopSegue.h"


@implementation MFStoryboardPopSegue

- (void)perform {
    UIViewController *sourceViewController = [self sourceViewController];
    UIViewController *destinationViewController = [self destinationViewController];

    UIView *sourceSnapshot;
    if ([sourceViewController.view respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        sourceSnapshot = [sourceViewController.view snapshotViewAfterScreenUpdates:YES];
    } else {
        UIGraphicsBeginImageContextWithOptions(sourceViewController.view.bounds.size, NO, 0.0f);
        [sourceViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        sourceSnapshot = [[UIImageView alloc] initWithImage:screenshot];
        sourceSnapshot.frame = sourceViewController.view.frame;
    }

    [sourceViewController dismissViewControllerAnimated:NO completion:^{
        UIView *destinationView = [destinationViewController view];
        UIView *superView = [destinationView superview];
        [superView insertSubview:sourceSnapshot aboveSubview:destinationView];

        CGRect destinationFrame = [destinationView frame];
        CGRect snapshotFrame = [sourceSnapshot frame];

        destinationFrame.origin.x = - roundf(destinationFrame.size.width / 3);
        destinationView.frame = destinationFrame;
        destinationFrame.origin.x = 0.0f;

        sourceSnapshot.layer.shadowColor = [UIColor grayColor].CGColor;
        sourceSnapshot.layer.shadowOffset = CGSizeMake(-5, 0);
        sourceSnapshot.layer.shadowOpacity = 0.2f;

        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [sourceSnapshot setFrame:CGRectMake(snapshotFrame.size.width, snapshotFrame.origin.y, snapshotFrame.size.width, snapshotFrame.size.height)];
            [destinationView setFrame:destinationFrame];
        } completion:^(BOOL finished) {
            [sourceSnapshot removeFromSuperview];
        }];
    }];
}

@end

