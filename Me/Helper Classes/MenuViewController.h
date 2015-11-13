//
//  MenuViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface MenuViewController : UIViewController <UITableViewDelegate>

@property (nonatomic, strong) NSString *cellIdentifier;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
