//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCell.h"

@implementation MenuViewController
@synthesize cellIdentifier;

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.myTableView.tableFooterView = [[UIView alloc]init];
    self.myTableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    
    self.myTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 120)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 120)];
    imageView.image = [UIImage imageNamed:@"我思我念我写"];
    [self.myTableView.tableHeaderView addSubview:imageView];
    
    static NSString *cellID = @"basicCell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil){
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:nil options:nil];
        cell = [cellArray lastObject];
    }
	
	switch (indexPath.row)
	{
		case 0:
            cell.icon.image = [UIImage imageNamed:@"首页"];
			cell.cellLabel.text = @"首页";
			break;
			
		case 1:
            cell.icon.image = [UIImage imageNamed:@"帮助"];
			cell.cellLabel.text = @"帮助";
			break;
			
		case 2:
            cell.icon.image = [UIImage imageNamed:@"分享"];
			cell.cellLabel.text = @"分享";
			break;
			
        case 3:
            cell.icon.image = [UIImage imageNamed:@"分享"];
            cell.cellLabel.text = @"修改密码";
            break;
            
		case 4:
            cell.icon.image = [UIImage imageNamed:@"注销"];
			cell.cellLabel.text = @"注销";
			break;
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainView" bundle: nil];
	
	UIViewController *vc ;
	
	switch (indexPath.row)
	{
		case 0:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"NotesTableViewController"];
			break;
			
		case 1:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HelpViewController"];
			break;
			
		case 2:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ShareViewController"];
			break;
            
        case 3:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"PwdChangeViewController"];
            break;
	
		case 4:
			[[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:NO];
			return;
			break;
	}
	
	[[SlideNavigationController sharedInstance] switchToViewController:vc withCompletion:nil];
}


@end
