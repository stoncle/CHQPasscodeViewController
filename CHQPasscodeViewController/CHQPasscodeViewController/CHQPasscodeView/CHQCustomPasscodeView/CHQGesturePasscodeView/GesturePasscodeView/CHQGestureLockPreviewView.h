//
//  CHQGestureLockView.h
//  CHQGestureLockView
//
//  Created by 陈鸿强 on 10/14/14.
//  Copyright (c) 2014 陈鸿强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CHQGestureLockPreviewView : UIView

@property (nonatomic, strong, readonly) NSArray *labels;
@property (nonatomic, assign) NSUInteger numberOfGestureNodes;
@property (nonatomic, assign) NSUInteger gestureNodesPerRow;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong, readonly) UIView *contentView;//the container of the gesture notes
@property (nonatomic, assign) UIEdgeInsets contentInsets;

- (float)getGapBetweenNote;
- (NSUInteger)getNodesPerRow;
- (float)getNodeWidth;
- (void)updateLabelsColor:(NSArray *)coloredButton;
- (void)resetLabelsColor;

@end
