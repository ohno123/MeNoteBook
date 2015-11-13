//
//  PwdChangeViewController.m
//  Me
//
//  Created by 艾葭 on 15/9/2.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "PwdChangeViewController.h"
#import "MBProgressHUD+MJ.h"
#import "UserBL.h"
#import "User.h"

@interface PwdChangeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwdOldField;
@property (weak, nonatomic) IBOutlet UITextField *pwdNewField;
- (IBAction)pwdChangeAction:(id)sender;

@end

@implementation PwdChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//按完Done键以后关闭键盘
- (IBAction) textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pwdChangeAction:(id)sender {
    UserBL *bl = [[UserBL alloc]init];
    NSMutableArray *listData = [bl findAll];
    User *user = listData[0];
    NSLog(@"run to changea show%@,%@",user.name,user.password);
    
    if ([self.pwdOldField.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入原密码"];
        return;
    }
    if ([self.pwdNewField.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入新密码"];
        return;
    }
    if (![self.pwdOldField.text isEqualToString:user.password]) {
        [MBProgressHUD showError:@"原密码输入错误"];
        return;
    }
    
    [MBProgressHUD showMessage:@"密码修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainView" bundle: nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SlideNavigationController"];
        [self presentViewController:vc animated:NO completion:nil];
    });
    
    
    User *userNew = [[User alloc]initWithName:user.name password:self.pwdNewField.text];

    NSLog(@"run to changea show new%@,%@",userNew.name,userNew.password);
    
    [bl update:userNew];
}
@end
