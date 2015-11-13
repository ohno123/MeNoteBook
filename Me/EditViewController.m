//
//  EditViewController.m
//  Me
//
//  Created by 艾葭 on 15/8/31.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "EditViewController.h"
#import "Note.h"
#import "NoteBL.h"

@interface EditViewController ()

- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
- (IBAction)editAction:(id)sender;

@end

@implementation EditViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    if (self.detailItem) {
        Note* note = self.detailItem;
        self.detailTextView.text = note.content;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)editAction:(id)sender {
    NSLog(@"run here,Edit");

    NoteBL *bl = [[NoteBL alloc] init];
    Note *noteNew = [[Note alloc] init];

    if (self.detailItem) {
        Note* note = self.detailItem;
        noteNew.time = note.time;
    }

    noteNew.content = self.detailTextView.text;
    
    NSLog(@"%@,%@\n",noteNew.time,noteNew.content);
    
    NSMutableArray *reslist = [bl update:noteNew];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:reslist userInfo:nil];
    
    //关闭当前页面
    [self.navigationController popViewControllerAnimated:YES];

}
@end
