//
//  HistoController.m
//  Calculator
//
//  Created by John Mortensen on 10/10/19.
//  Copyright © 2019 JM. All rights reserved.
//

#include "control.h"
#import "HistoController.h"

@implementation HistoController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    tableData = [NSArray arrayWithObjects:@[@"1",@"0"], @[@"2",@"0"], @[@"3",@"0"], @[@"4",@"0"], @[@"5",@"0"], @[@"6",@"0"], @[@"7",@"0"], @[@"8",@"0"], @[@"9",@"0"], nil];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

// table rows
- (NSInteger)tableView:(UITableViewCell *)table numberOfRowsInSection:(NSInteger)section;
{
    NSInteger rsize = [tableData count];
    return rsize;
}

// table columns
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger csize = 2;
    return csize;
}

// assigns values to visible rows in table as needed
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    cell.textLabel.text =  [NSString stringWithFormat:@"#%@\t\t%@",
                            [tableData objectAtIndex:indexPath.row][0],
                            [tableData objectAtIndex:indexPath.row][1] ];
    NSLog(@"Assign: %@ to %@",
          [tableData objectAtIndex:indexPath.row][0],
          [tableData objectAtIndex:indexPath.row][1] );


    return cell;
}

// activates at button click on row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"Select: %@ is equal to  %@",
          [tableData objectAtIndex:indexPath.row][0],
          [tableData objectAtIndex:indexPath.row][1] );
}

@end
