//
//  CHQSimpleDigitalPasscodeView.m
//  CHQPasscodeViewController
//
//  Created by 陈鸿强 on 12/30/14.
//  Copyright (c) 2014 陈鸿强. All rights reserved.
//
#import "CHQPasscodeView.h"
#import "CHQDigitPasscodeView.h"
#import "CHQPasscodeViewController.h"
#import "Masonry.h"
@interface CHQDigitPasscodeView() <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *passcodeTextField;
@property (nonatomic, strong) UITextField *firstDigitTextField;
@property (nonatomic, strong) UITextField *secondDigitTextField;
@property (nonatomic, strong) UITextField *thirdDigitTextField;
@property (nonatomic, strong) UITextField *fourthDigitTextField;

@end
@implementation CHQDigitPasscodeView

- (instancetype)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

- (void)setupViews
{
    _passcodeTextField = [[UITextField alloc] initWithFrame: CGRectZero];
    _passcodeTextField.delegate = self;
    _passcodeTextField.secureTextEntry = YES;
    _passcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passcodeTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_passcodeTextField];
    [self _setupDigitFields];
}

- (void)_setupDigitFields {
    _firstDigitTextField = [self _makeDigitField];
    [self addSubview:_firstDigitTextField];
    
    _secondDigitTextField = [self _makeDigitField];
    [self addSubview:_secondDigitTextField];
    
    _thirdDigitTextField = [self _makeDigitField];
    [self addSubview:_thirdDigitTextField];
    
    _fourthDigitTextField = [self _makeDigitField];
    [self addSubview:_fourthDigitTextField];
}

- (UITextField *)_makeDigitField{
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectZero];
    field.backgroundColor = self.con.passcodeBackgroundColor;
    field.textAlignment = NSTextAlignmentCenter;
    field.text = @"\u2014";
    field.textColor = [UIColor colorWithWhite:0.31f alpha:1.0f];
    field.font = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ?
    [UIFont fontWithName: @"AvenirNext-Regular" size: 33 * 1.5] :
    [UIFont fontWithName: @"AvenirNext-Regular" size: 33];
    field.secureTextEntry = NO;
    field.userInteractionEnabled = NO;
    [field setBorderStyle:UITextBorderStyleNone];
    return field;
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
        if (typedString.length >= 1) _firstDigitTextField.secureTextEntry = YES;
        else _firstDigitTextField.secureTextEntry = NO;
        if (typedString.length >= 2) _secondDigitTextField.secureTextEntry = YES;
        else _secondDigitTextField.secureTextEntry = NO;
        if (typedString.length >= 3) _thirdDigitTextField.secureTextEntry = YES;
        else _thirdDigitTextField.secureTextEntry = NO;
        if (typedString.length >= 4) _fourthDigitTextField.secureTextEntry = YES;
        else _fourthDigitTextField.secureTextEntry = NO;
        
        if (typedString.length == 4) {
            // Make the last bullet show up
            [self validateWithPasscode:typedString];
        }
        if (typedString.length > 4) return NO;
    return YES;
}
- (void)resetUI
{
    if (![_passcodeTextField isFirstResponder] && (!self.con.isUsingTouchID || self.con.useFallbackPasscode)) {
        [_passcodeTextField becomeFirstResponder];
    }
    _firstDigitTextField.secureTextEntry = NO;
    _secondDigitTextField.secureTextEntry = NO;
    _thirdDigitTextField.secureTextEntry = NO;
    _fourthDigitTextField.secureTextEntry = NO;
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
- (void)updateConstraints
{
    [super updateConstraints];
    _passcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passcodeTextField.hidden = YES;
    [_passcodeTextField reloadInputViews];
    [_firstDigitTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(- 60 * 1.5f + 10.0f);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_secondDigitTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(- 60 * 2/3 + 10.0f);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_thirdDigitTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(60 * 1/6 + 10.0f);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_fourthDigitTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(60 - 2.0f + 10.0f);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
