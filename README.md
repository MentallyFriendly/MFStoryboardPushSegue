MFStoryboardPushSegue
=====================

UIStoryboardPushSegue for use outside a navigation controller. It is designed
to look identical to UIStoryboardPushSegue on iOS 7.

## MFStoryboardPopSegue

This segue is equivilent to UIStoryboardPopSegue. You can use it by overiding
your unwinding method on the view controller you are unwinding to. For example:

```objective-c
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    return [[MFStoryboardPopSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
}
```

## Installation

```ruby
platform :ios, '6.0'

pod 'MFStoryboardPushSegue'
```

## License

MFStoryboardPushSegue is released under BSD license. See [LICENSE](LICENSE).

