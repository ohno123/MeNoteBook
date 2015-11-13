//
//  RegisterViewController.m
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUD+MJ.h"
#import "User.h"
#import "UserBL.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *regBtn;
- (IBAction)regAction:(id)sender;

@end

@implementation RegisterViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)regAction:(id)sender {
    if ([self.nameField.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    if ([self.pwdField.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    UserBL *bl = [[UserBL alloc]init];
    NSMutableArray* listData = [bl findAll];
    if ([listData count] > 0) {
        [MBProgressHUD showError:@"您已经注册过咯，请返回登陆页面登陆"];
        return;
    }
   // NSLog(@"reg run here 1");
    [MBProgressHUD showMessage:@"注册中，请稍后"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainView" bundle: nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SlideNavigationController"];
        [self presentViewController:vc animated:NO completion:nil];
    });
    User *user = [[User alloc]initWithName:self.nameField.text password:self.pwdField.text];
    [bl createUser:user];
    //NSLog(@"reg run here");

}
@end
