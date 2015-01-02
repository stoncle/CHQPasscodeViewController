//
//  CHQGesturePasscodeView.h
//  CHQPasscodeViewController
//
//  Created by 陈鸿强 on 1/1/15.
//  Copyright (c) 2015 陈鸿强. All rights reserved.
//

#import "CHQPasscodeView.h"

@interface CHQGesturePasscodeView : CHQPasscodeView
@property (nonatomic, assign) NSUInteger numberOfGestureNodes;
@property (nonatomic, assign) NSUInteger gestureNodesPerRow;

@property (nonatomic, strong) UIImage *normalGestureNodeImage;
@property (nonatomic, strong) UIImage *selectedGestureNodeImage;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@end
