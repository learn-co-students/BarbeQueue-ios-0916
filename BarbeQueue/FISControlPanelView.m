//
//  FISControlPanelView.m
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/26/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISControlPanelView.h"

@implementation FISControlPanelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *createSessionLabel = [[UILabel alloc] init];
    createSessionLabel.backgroundColor = [UIColor yellowColor];
    createSessionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    createSessionLabel.text = @"No Session";
    [self addSubview:createSessionLabel];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:createSessionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:createSessionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.5 constant:0]];
    
    
    UIButton *createSessionButton = [[UIButton alloc] init];
    [createSessionButton setTitle:@"Create Session" forState:UIControlStateNormal];
    createSessionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [createSessionButton setBackgroundColor:[UIColor darkGrayColor]];
    [self addSubview:createSessionButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(createSessionLabel, createSessionButton);
    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[createSessionButton(>=createSessionLabel)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[createSessionLabel]-[createSessionButton]" options:0 metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:createSessionButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:createSessionLabel attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
}

@end
