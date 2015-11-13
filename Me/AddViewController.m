//
//  AddViewController.m
//  Me
//
//  Created by 艾葭 on 15/8/31.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "AddViewController.h"
#import "Note.h"
#import "NoteBL.h"

@interface AddViewController ()<UITextViewDelegate>
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *addTextView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)addAction:(id)sender;


@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.addTextView becomeFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addAction:(id)sender{
    NSLog(@"run here");
    //关闭当前视图
    
    NoteBL *bl = [[NoteBL alloc] init];
    Note *note = [[Note alloc] init];
    
    NSDate *time = [NSDate date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeString = [timeFormatter stringFromDate:time];
    
    note.time = timeString;
    note.content = self.addTextView.text;
    
    NSLog(@"%@,%@\n",note.time,note.content);
    
    NSMutableArray *reslist = [bl createNote: note];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:reslist userInfo:nil];
    
    [self.addTextView resignFirstResponder];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
