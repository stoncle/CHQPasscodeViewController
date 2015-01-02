//
//  CHQGesturePasscodeView.m
//  CHQPasscodeViewController
//
//  Created by 陈鸿强 on 1/1/15.
//  Copyright (c) 2015 陈鸿强. All rights reserved.
//

#import "CHQGesturePasscodeView.h"
#import "KKGestureLockView.h"
#import "CHQGestureLockPreviewView.h"
#import "CHQPasscodeViewController.h"
@interface CHQGesturePasscodeView() <KKGestureLockViewDelegate>
@property (nonatomic, strong) KKGestureLockView *lockView;
@property (nonatomic, strong) CHQGestureLockPreviewView *lockPreView;
@end
@implementation CHQGesturePasscodeView
- (void)commonInit
{
    self.numberOfGestureNodes = 9;
    self.gestureNodesPerRow = 3;
    self.normalGestureNodeImage = [UIImage imageNamed:@"gesture_node_normal.png"];
    self.selectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selected.png"];
    self.lineColor = [UIColor orangeColor];
    self.lineWidth = 5;
}
- (void)setupViews
{
    [self commonInit];
    _lockView = [[KKGestureLockView alloc]initWithFrame:CGRectZero];
    _lockView.delegate = self;
    _lockPreView = [[CHQGestureLockPreviewView alloc]initWithFrame:CGRectZero];
    _lockPreView.hidden = YES;
    [self addSubview:_lockPreView];
    [self addSubview:_lockView];
    _lockView.numberOfGestureNodes = self.numberOfGestureNodes;
    _lockView.gestureNodesPerRow = self.gestureNodesPerRow;
    _lockView.normalGestureNodeImage = self.normalGestureNodeImage;
    _lockView.selectedGestureNodeImage = self.selectedGestureNodeImage;
    _lockView.lineColor = self.lineColor;
    _lockView.lineWidth = self.lineWidth;
}

- (void)updateConstraints
{
    [super updateConstraints];
    [_lockPreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-140);
        make.width.and.height.equalTo(@45);
    }];
    [_lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(30);
        make.width.and.height.equalTo(@270);
    }];
}

- (void)resetUI
{
    if(self.con.isUserEnablingPasscode || self.con.isUserConfirmingPasscode || self.con.isUserBeingAskedForNewPasscode)
    {
        _lockPreView.hidden = NO;
    }
    else
    {
        _lockPreView.hidden = YES;
    }
}
#pragma mark - KKGestureLockViewDelegate
- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode
{
    
}
- (void)gestureLockView:(KKGestureLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode
{
    
}
- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode
{
    [self validateWithPasscode:passcode];
    if((self.con.isUserEnablingPasscode && !self.con.isUserConfirmingPasscode) ||self.con.isUserBeingAskedForNewPasscode)
    {
        [UIView animateKeyframesWithDuration:0 delay:self.con.slideAnimationDuration+0.1 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
            [_lockPreView resetLabelsColor];
            [_lockPreView updateLabelsColor:[passcode componentsSeparatedByString:@","]];
        } completion:nil];
    }
    else
    {
        [UIView animateKeyframesWithDuration:0 delay:self.con.slideAnimationDuration+0.1 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
            [_lockPreView resetLabelsColor];
        } completion:nil];
    }
}

@end
