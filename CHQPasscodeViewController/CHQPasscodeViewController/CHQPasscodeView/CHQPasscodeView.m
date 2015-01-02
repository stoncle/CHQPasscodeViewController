//
//  CHQPasscodeView.m
//  CHQPasscodeViewController
//
//  Created by 陈鸿强 on 12/30/14.
//  Copyright (c) 2014 陈鸿强. All rights reserved.
//

#import "CHQPasscodeView.h"

@implementation CHQPasscodeView

- (instancetype)init
{
    if(self = [super init])
    {
    }
    return self;
}

- (instancetype)initWithViewController:(CHQPasscodeViewController<CHQPasscodeViewDelegate> *)vc
{
    self = [self init];
    self.con = vc;
    [self setupViews];
    return self;
}

- (void)setupViews
{
    
}

- (void)resetUI
{
    
}

- (void)validateWithPasscode:(NSString *)passcode
{
    if([self.delegate respondsToSelector:@selector(validatePasscode:)])
        [self.delegate performSelector:@selector(validatePasscode:) withObject:passcode];
}
- (void)anythingBecomeFirstResponder
{
    
}
- (BOOL)anythingIsFirstResponder
{
    return NO;
}
-(void)anythingResignFirstResponder
{
    
}

@end
