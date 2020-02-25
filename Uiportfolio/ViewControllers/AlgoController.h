//
//  AlgoController.h
//  uiPortfolio
//
//  Created by John Mortensen on 10/10/19.
//  Copyright © 2019 JM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlgoController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSArray *tableData;
    BOOL isFiltered;
    
}

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addObjectButton:(UIButton *)sender;

@end
