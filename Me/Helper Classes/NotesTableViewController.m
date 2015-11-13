//
//  NotesTableViewController.m
//  Me
//
//  Created by 艾葭 on 15/8/30.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "NotesTableViewController.h"
#import "EditViewController.h"
#import "Note.h"
#import "NoteBL.h"

@interface NotesTableViewController ()<UITableViewDelegate>
@property(nonatomic, strong)EditViewController *editViewController;
//保存数据
@property(nonatomic, strong) NSMutableArray* listData;
@property(nonatomic, strong) NoteBL* bl;

@end

@implementation NotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView的背景图片
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainpage"]];
    self.tableView.backgroundView = view;
    
    self.bl = [[NoteBL alloc]init];
    self.listData = [self.bl findAll];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView:) name:@"reloadViewNotification" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView:) name:@"reloadViewNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Note  *note = self.listData[indexPath.row];
    cell.textLabel.text = note.content;
    //cell.detailTextLabel.text = [note.time description];
    cell.detailTextLabel.text = note.time;

    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = [self.listData objectAtIndex:[indexPath row]];
        NoteBL *bl = [[NoteBL alloc] init];
        self.listData = [bl remove: note];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

#pragma mark - 处理通知
-(void)reloadView:(NSNotification*)notification {
    NSMutableArray *resList = [notification object];
    self.listData  = resList;
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Note *object = self.listData[indexPath.row];
        EditViewController *controller = segue.destinationViewController;
        [controller setDetailItem:object];
    }

}

#pragma TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
