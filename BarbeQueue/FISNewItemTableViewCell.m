//
//  FISNewItemTableViewCell.m
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/27/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISNewItemTableViewCell.h"

@interface FISNewItemTableViewCell ()
@property (weak, nonatomic, readwrite) UITextField *nameField;
@end
@implementation FISNewItemTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
//    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"nameField": self.nameField} ;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[nameField]-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[nameField]-|" options:0 metrics:nil views:views]];
}

- (UITextField *)nameField {
    if (!_nameField) {
        UITextField *textField = [[UITextField alloc] init];
        [self.contentView addSubview:textField];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        _nameField = textField;
        _nameField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _nameField;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
