//
//  FISControlPanelViewController.m
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/26/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISControlPanelViewController.h"

#import "FISControlPanelView.h"
#import "FISNewItemTableViewCell.h"

@interface FISControlPanelViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (nonatomic) NSMutableArray *stuff;
@property (nonatomic, strong) FISControlPanelView *view;
@property (nonatomic) BOOL isAddingResource;
@property (nonatomic) UIGestureRecognizer *tapGestureRecognizer;

@end

@implementation FISControlPanelViewController

- (void)loadView {
    self.view = [[FISControlPanelView alloc] init];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createResource:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tableView.delegate = self;
    self.view.tableView.dataSource = self;
    
    self.stuff = [[NSMutableArray alloc] initWithArray:@[@"Bob", @"Jack", @"Henry"]];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doneCreatingResource)];
}

- (void)createResource:(UIBarButtonItem *)sender {
    if (!self.isAddingResource) {
        self.isAddingResource = YES;
        [self.stuff insertObject:@"Default" atIndex:0];
        [self.view.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (void)doneCreatingResource {
    self.isAddingResource = NO;
    [self.view endEditing:NO];
}

#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.view.tableView addGestureRecognizer:self.tapGestureRecognizer];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.stuff replaceObjectAtIndex:0 withObject:textField.text];
    [self.view.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    [self.view.tableView removeGestureRecognizer:self.tapGestureRecognizer];
}

#pragma mark - TableView Delegate

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.view.tableView setEditing:editing animated:animated];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.stuff removeObjectAtIndex:(NSUInteger)indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)self.stuff.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *basicCellIdentifier = @"basicCell";
    static NSString *addCellIdentifier = @"addCell";
    
    UITableViewCell *cell;
    if (indexPath.row == 0 && self.isAddingResource) {
        FISNewItemTableViewCell *addCell = [tableView dequeueReusableCellWithIdentifier:addCellIdentifier];
        if (!cell) {
            addCell = [[FISNewItemTableViewCell alloc] init];
        }
        addCell.nameField.delegate = self;
        cell = addCell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:basicCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:basicCellIdentifier];
        }
        cell.textLabel.text = self.stuff[(NSUInteger)indexPath.row];
    }
    return cell;
}


@end
