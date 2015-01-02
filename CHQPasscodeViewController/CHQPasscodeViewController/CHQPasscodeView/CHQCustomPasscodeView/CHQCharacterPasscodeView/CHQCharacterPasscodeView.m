//
//  CHQComplexDigitPasscodeView.m
//  CHQPasscodeViewController
//
//  Created by 陈鸿强 on 12/31/14.
//  Copyright (c) 2014 陈鸿强. All rights reserved.
//

#import "CHQCharacterPasscodeView.h"
#import "CHQPasscodeViewController.h"
@interface CHQCharacterPasscodeView() <UITextFieldDelegate>

@property (nonatomic, strong) UIView      *complexPasscodeOverlayView;
@property (nonatomic, strong) UITextField *passcodeTextField;
@property (nonatomic, strong) UIButton    *OKButton;
@end
@implementation CHQCharacterPasscodeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setupViews
{
    _complexPasscodeOverlayView = [[UIView alloc] initWithFrame:CGRectZero];
    _complexPasscodeOverlayView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_complexPasscodeOverlayView];
    _passcodeTextField = [[UITextField alloc] initWithFrame: CGRectZero];
    _passcodeTextField.delegate = self;
    _passcodeTextField.secureTextEntry = YES;
    _passcodeTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _passcodeTextField.font = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ?
    [UIFont fontWithName: @"AvenirNext-Regular" size: 23 * 1.5] :
    [UIFont fontWithName: @"AvenirNext-Regular" size: 23];
    [_complexPasscodeOverlayView addSubview:_passcodeTextField];
    [self _setupOKButton];
}

- (void)_setupOKButton {
    _OKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_OKButton setTitle:@"OK"
               forState:UIControlStateNormal];
    _OKButton.titleLabel.font = self.con.labelFont;
    _OKButton.backgroundColor = self.con.enterPasscodeLabelBackgroundColor;
    [_OKButton setTitleColor:[UIColor colorWithWhite:0.31f alpha:1.0f] forState:UIControlStateNormal];
    [_OKButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_OKButton addTarget:self
                  action:@selector(_validateComplexPasscode)
        forControlEvents:UIControlEventTouchUpInside];
    [_complexPasscodeOverlayView addSubview:_OKButton];
}
- (void)setupConstraints
{
    
}
- (void)_validateComplexPasscode
{
    [self validateWithPasscode:_passcodeTextField.text];
}
- (void)resetUI
{
    if (![_passcodeTextField isFirstResponder] && (!self.con.isUsingTouchID || self.con.useFallbackPasscode)) {
        [_passcodeTextField becomeFirstResponder];
    }
    _passcodeTextField.text = @"";
}
- (BOOL)anythingIsFirstResponder
{
    return [_passcodeTextField isFirstResponder];
}
- (void)anythingBecomeFirstResponder
{
    [_passcodeTextField becomeFirstResponder];
}
- (void)anythingResignFirstResponder
{
    [_passcodeTextField resignFirstResponder];
}
-(void)updateConstraints
{
    [super updateConstraints];
    _passcodeTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [_passcodeTextField reloadInputViews];
    [_complexPasscodeOverlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@100);
    }];
    [_passcodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_complexPasscodeOverlayView.mas_left).offset(10);
        make.centerY.equalTo(_complexPasscodeOverlayView.mas_centerY);
        make.right.equalTo(_OKButton.mas_left).offset(8);
        make.height.equalTo(@40);
    }];
    [_OKButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self);
        make.width.equalTo(@50);
    }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ((!self.con.displayedAsLockScreen && !self.con.displayedAsModal) || (self.con.isUsingTouchID || !self.con.useFallbackPasscode)) {
        return YES;
    }
    return !self.con.isCurrentlyOnScreen;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString: @"\n"]) return NO;
    
    NSString *typedString = [textField.text stringByReplacingCharactersInRange: range
                                                                    withString: string];
    _OKButton.hidden = [typedString length] == 0;
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
