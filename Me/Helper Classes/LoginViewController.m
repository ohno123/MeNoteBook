//
//  LoginViewController.m
//  Me
//
//  Created by 艾葭 on 15/8/28.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+MJ.h"
#import "User.h"
#import "UserBL.h"

#define UserNameKey @"name"
#define PwdKey @"pwd"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitAction;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fieldChanged) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fieldChanged) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    
    self.nameField.delegate  = self;
    self.pwdField.delegate   = self;
    //读取数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.nameField.text      = [defaults valueForKey:UserNameKey];
    self.pwdField.text       = [defaults valueForKey:PwdKey];
    if(self.nameField.text!=nil && self.pwdField.text!=nil){
        self.submitBtn.enabled = YES;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)fieldChanged{
    self.submitBtn.enabled = (self.nameField.text.length && self.pwdField.text.length);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//按完Done键以后关闭键盘
- (IBAction) textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}


-(User *)loadData{
    UserBL *bl = [[UserBL alloc]init];
    NSMutableArray *listData = [bl findAll];
    User *user;
    if (listData.count == 0) {
        user = nil;
    }else{
        user = listData[0];
    }
    return user;
}

- (IBAction)submitAction {
    User *user = [self loadData];
    if (user == nil) {
        [MBProgressHUD showError:@"还未注册，请先注册!"];
        return;
    }
    
    if (![self.nameField.text isEqualToString:user.name]) {
        [MBProgressHUD showError:@"用户名不存在"];
        return;
    }
    if (![self.pwdField.text isEqualToString:user.password]) {
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    [MBProgressHUD showMessage:@"努力加载中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self performSegueWithIdentifier:@"LoginToContact" sender:nil];
    });
    
    //保存数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.nameField.text forKey:UserNameKey];
    [defaults setObject:self.pwdField.text forKey:PwdKey];
    [defaults synchronize];
}

#pragma mark -
#pragma mark 解决虚拟键盘挡住UITextField的方法
- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    float height = 216.0;
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
#pragma mark -


@end
