//
//  CHQPasscodeView.h
//  CHQPasscodeViewController
//
//  Created by 陈鸿强 on 12/30/14.
//  Copyright (c) 2014 陈鸿强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Masonry.h"
@class CHQPasscodeViewController;
@protocol CHQPasscodeViewDelegate <NSObject>

- (BOOL)validatePasscode:(NSString *)passcode;

@end
@interface CHQPasscodeView : UIView
@property (nonatomic, weak) CHQPasscodeViewController<CHQPasscodeViewDelegate> *con;
@property (nonatomic, strong) id<CHQPasscodeViewDelegate> delegate;

- (instancetype)initWithViewController:(CHQPasscodeViewController<CHQPasscodeViewDelegate> *)con;
- (void)setupViews;
- (BOOL)anythingIsFirstResponder;
- (void)anythingBecomeFirstResponder;
- (void)anythingResignFirstResponder;
- (void)resetUI;
- (void)validateWithPasscode:(NSString *)typedString;
@end
