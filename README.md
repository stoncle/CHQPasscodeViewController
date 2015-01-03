CHQPasscodeViewController
=========================
base on [LTHPasscodeViewController](https://github.com/rolandleth/LTHPasscodeViewController) by [rolandleth](https://github.com/rolandleth).

add passcode to your app, including digit, letter and gesture passcode, and you would be able to customise your own passcode view, and change them freely when using.

#INSTALLAION
Drag the `CHQPasscodeViewController` to your project, and `#import "CHQPasscodeViewController.h"` when you use it. 
This library make use of [Masonry](https://github.com/Masonry/Masonry) to configure the constraints, so you may need to add [Masonry](https://github.com/Masonry/Masonry) to your project.

#USAGE
Example : called in `application:didFinishLaunchingWithOptions:`
```Objective-C
[CHQPasscodeViewController useKeychain:NO];
if ([CHQPasscodeViewController doesPasscodeExist]) {
    if ([CHQPasscodeViewController didPasscodeTimerEnd])
        [[CHQPasscodeViewController sharedUser] showLockScreenWithAnimation:YES
                                                                 withLogout:NO
                                                             andLogoutTitle:nil];
}
```
###Displaying a passcode view
```Objective-C
- (void)showLockScreenWithAnimation:(BOOL)animated withLogout:(BOOL)hasLogout andLogoutTitle:(NSString*)logoutTitle;
```
###Show passcode view for enabling, changing, disabling the passcode or changing the passcode type.
```Objective-C
/**
 @param viewController The view controller where the passcode view controller will be displayed.
 @param asModal        Set to YES to present as a modal, or to NO to push on the current nav stack.
 */
- (void)showForEnablingPasscodeInViewController:(UIViewController *)viewController asModal:(BOOL)isModal;
- (void)showForDisablingPasscodeInViewController:(UIViewController *)viewController asModal:(BOOL)isModal;
- (void)showForChangingPasscodeInViewController:(UIViewController *)viewController asModal:(BOOL)isModal;
- (void)setLockType:(CHQLockType)type inViewController:(UIViewController *)viewController asModal:(BOOL)isModal
```
###Keychain
this library saves the passcode in the keychain by default. You are able to customise your own saving, to do this customisation, you need to call `[CHQPasscodeViewController useKeychain:NO]` after initializing and implement some protocol methods:
```Objective-C
- (void)deletePasscode;
- (void)savePasscode:(NSString *)passcode;
- (NSString *)passcode;
```

###Timer
this library supports for setting the start time when the passcode view take effects, this also handled by keychain by default, if you want to customize your timer, you need to call `[CHQPasscodeViewController useKeychain:NO]` and implement some protocol methods:
```Objective-C
- (NSTimeInterval)timerDuration;
- (void)saveTimerDuration:(NSTimeInterval)duration;
- (NSTimeInterval)timerStartTime;
- (void)saveTimerStartTime;
- (BOOL)didPasscodeTimerEnd;
```

###Tracking behavior
implement some protocol methods to track the passcode view:
```Objective-C
- (void)passcodeViewControllerWillClose;
- (void)maxNumberOfFailedAttemptsReached;
- (void)passcodeWasEnteredSuccessfully;
- (void)logoutButtonWasPressed;
```
#SUPPORTING PASSCODE TYPE FOR NOW
this library support 3 passcode type currently, they are Digit, Character and Gesture.
![Screenshot](https://github.com/stoncle/CHQPasscodeViewController/image/digit.png)
![Screenshot](https://github.com/stoncle/CHQPasscodeViewController/image/character.png)
![Screenshot](https://github.com/stoncle/CHQPasscodeViewController/image/gesture.png)

#CUSTOMISATION
###you can create your own personalized passcode view!
to do this, you need to subclassing the `CHQPasscodeView`:
```Objective-C
- (void)setupViews;
- (BOOL)anythingIsFirstResponder;
- (void)anythingBecomeFirstResponder;
- (void)anythingResignFirstResponder;
- (void)resetUI;
- (void)validateWithPasscode:(NSString *)typedString;
```
    # setupViews
      this method would be called when the passcode view is first generated, implement this method to configure your 
      passcode view.
    # anythingIsFirstResponder
      this method would be called to comfirm that is some of compoments(like textfileds) in your passcode view is 
      first responder. return `[xx isFirstResponder]` in this method if you need one of your subviews to be 
      first responder.
    # anythingBecomeFirstResponder
      this method would be called when the passcode view is ready in sight, and is ready to let your subview to take 
      over the first responder, call `[xx becomeFirstResonder]` in this method if you need one of your subviews to 
      be first responder.
    # anythingResignFirstResponder
      this method would be called when the passcode view is about to dismiss in sight, call `[xx resignFirstResponder]`
      if you have set your subview to be first responder.
    # resetUI
      this method would be called each time you interactive with the passcode view. implement this method to make 
      sure your passcode view displaying correctly in defferent states.
    # validateWithPasscode:
      once your passcode view gets the passcode, call this method to validate the passcode.
Done subclassing the CHQPasscodeView, the last thing you need to do is attach it to the process of       CHQPasscodeViewController:
* add new LockType ENUM `CHQLockType` in `CHQPasscodeViewController.h`
* call `_passcodeView = [[YourPasscodeView alloc]initWithViewController:self]` in the switch block in 
  `- (void)_changePasscodeViewToAimLockType:(CHQLockType)lockType` in `CHQPasscodeViewControler.m`
