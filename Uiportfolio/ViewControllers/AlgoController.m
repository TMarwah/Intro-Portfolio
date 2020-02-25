//
//  FileIOController.m
//  Calculator
//
//  Created by John Mortensen on 10/10/19.
//  Copyright © 2019 JM. All rights reserved.
//

#include "control.h"
#import "AlgoController.h"

@implementation AlgoController
@synthesize tableView, searchBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableData];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    
}

// sets up data to initial state
-(void)initTableData  // method to perform calculation
{
    // lanuages array populate
    LANGUAGES *pl = progLanguages();
    [self loadTableData:pl];
}

// filters data according to search term
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    // lanuages array populate according to search term
    const char *cString = [searchText cStringUsingEncoding:NSASCIIStringEncoding];
    LANGUAGES *pl = searchLanguages((char *)cString);
    // reload data and refresh view
    [self loadTableData:pl];
    [self.tableView reloadData];
}

-(void)loadTableData:(LANGUAGES *)pl;  // method to perform calculation
{
    // Convert struct to array
    NSMutableArray *tmpA = [[NSMutableArray alloc] initWithCapacity: FILE_BUFFER_SIZE];
    for (int i = 0; i < FILE_BUFFER_SIZE; i++)
    {
        // Only loading two fields
        [tmpA addObject: [NSString stringWithFormat:@"%4s\t%s", pl[i].yob, pl[i].name ]];
    }
    tableData = tmpA;
}

// table rows
- (NSInteger)tableView:(UITableViewCell *)table numberOfRowsInSection:(NSInteger)section;
{
    return [tableData count];
}

// table columns
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// assigns values to visible rows in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This ID is in ViewControl
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.text =  [tableData objectAtIndex:indexPath.row];
    NSLog(@"Assign: %@", [tableData objectAtIndex:indexPath.row]);

    return cell;
}

// Activates at button click on row, future enhancement
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"Select: %@", [tableData objectAtIndex:indexPath.row]);
}

// no idea what this is but required for definition, looks promising for edits
-(IBAction)addObjectButton:(UIButton *)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:
        @"Add Element"
        message: @"Input Data"
        preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
