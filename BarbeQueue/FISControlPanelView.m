//
//  FISControlPanelView.m
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/26/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISControlPanelView.h"

@interface FISControlPanelView ()
@property (nonatomic, weak,readwrite) UITableView *tableView;
@end
@implementation FISControlPanelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    NSDictionary *views = @{@"tableView": self.tableView} ;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views]];
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        [self addSubview:tableView];
        _tableView = tableView;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tableView;
}

@end
