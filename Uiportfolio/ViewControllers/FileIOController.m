//
//  FileIOController.m
//  Calculator
//
//  Created by John Mortensen on 10/10/19.
//  Copyright © 2019 JM. All rights reserved.
//

#include "control.h"
#import "FileIOController.h"

@implementation FileIOController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableData];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

// read data from C file operation
-(void)loadTableData  // method to perform calculation
{
    // static file name
    char *fn="/Users/johnmortensen/Downloads/p1-jm1021/portfolio/fileparse.c";
    CANDIDATE_FUNCS *functions = fileParse(fn);
    
    // Convert struct to array
    NSMutableArray * tmpary = [[NSMutableArray alloc] initWithCapacity: FILE_BUFFER_SIZE];
    for (int i = 0; i < FILE_BUFFER_SIZE; i++)
    {
        //[tmpary addObject: [NSString stringWithCString: functions[i].name encoding:NSASCIIStringEncoding]];
        [tmpary addObject: [NSString stringWithFormat:@"%4d\t%s", functions[i].functionStartLine, functions[i].name ]];
    }
    tableData = tmpary;
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
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.text =  [tableData objectAtIndex:indexPath.row];
    NSLog(@"Assign: %@", [tableData objectAtIndex:indexPath.row]);

    return cell;
}

// activates at button click on row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"Select: %@", [tableData objectAtIndex:indexPath.row]);
}

@end
