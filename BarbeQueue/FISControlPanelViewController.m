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
#import "FISIngredient.h"
#import "FISIngredientStore.h"
@interface FISControlPanelViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UITextFieldDelegate, FISIngredientStoreDelegate>
@property(nonatomic) NSMutableArray *stuff;
@property(nonatomic, strong) FISControlPanelView *view;
@property(nonatomic) BOOL isAddingResource;
@property(nonatomic) UIGestureRecognizer *tapGestureRecognizer;
@property(nonatomic) FISIngredientStore *ingredientStore;
@end

@implementation FISControlPanelViewController

- (void)loadView {
    self.view = [[FISControlPanelView alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createResource:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTable:)];
    self.navigationItem.title = @"BBQ Ingredients :)";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tableView.delegate = self;
    self.view.tableView.dataSource = self;
    
    self.stuff = [[NSMutableArray alloc] initWithArray:[self.ingredientStore ingredientList]];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doneCreatingResource)];
    [self.view.tableView addGestureRecognizer:self.tapGestureRecognizer];
    
    self.ingredientStore = [FISIngredientStore sharedStore];
    self.ingredientStore.delegate = self;
}

- (void)createResource:(UIBarButtonItem *)sender {
    if (self.isAddingResource == NO) {
        self.isAddingResource = YES;
        [self.stuff insertObject:@"Default" atIndex:0];
        [self.view.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (void)doneCreatingResource {
    self.isAddingResource = NO;
    [self.view endEditing:NO];
}

- (void)refreshTable:(UIBarButtonItem *)sender {
    [self.ingredientStore refreshIngredientList];
}

#pragma mark - FISIngredientStore Delegate
- (void)ingredientListUpdated {
    self.stuff = [[NSMutableArray alloc] initWithArray:[self.ingredientStore ingredientList]];
    [self.view.tableView reloadData];
}

#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.tapGestureRecognizer.enabled = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        [self.stuff removeObjectAtIndex:0];
        [self.view.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    } else {
        FISIngredient *newIngredient = [[FISIngredient alloc] initWithName:textField.text];
        [self.stuff replaceObjectAtIndex:0 withObject:newIngredient];
        [self.view.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.ingredientStore addIngredient:newIngredient];
    }
    self.tapGestureRecognizer.enabled = NO;
}

#pragma mark - TableView Delegate

//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    [self.view.tableView setEditing:editing animated:animated];
//}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.stuff removeObjectAtIndex:(NSUInteger)indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//    }
//}
//
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
        [addCell.nameField becomeFirstResponder];
        cell = addCell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:basicCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:basicCellIdentifier];
        }
        FISIngredient *ingredient = self.stuff[(NSUInteger)indexPath.row];
        cell.textLabel.text = ingredient.name;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.text = ingredient.pendingWrite ? @"Pending Write: YES" : @"Pending Write: NO";
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    }
    return cell;
}


@end
