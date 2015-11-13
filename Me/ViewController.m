//
//  ViewController.m
//  Me
//
//  Created by 艾葭 on 15/8/31.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "ViewController.h"
//#import "SlideNavigationController.h"
#import "GuidePageViewController.h"
#import "LoginViewController.h"

@interface ViewController (){
   // SlideNavigationController *_mainNav;
    LoginViewController *_mainView;
    GuidePageViewController   *_guideController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpViewControllers{
   
    //判断是不是第一次启动应用
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"firstLaunch"]){
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        
        //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Guide" bundle:nil];
        _guideController = [storyBoard instantiateInitialViewController];
        [self addChildViewController:_guideController];
        
        [self.view addSubview:_guideController.view];
        _guideController.view.frame = self.view.bounds;
        
    }else{
        
        NSLog(@"不是第一次启动");
        
//        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
//        UIViewController *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SlideNavigationController"];  //test2为viewcontroller的StoryboardId
//        [self.view addSubview:_mainView.view];
//        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        //如果不是第一次启动的话,使用LoginViewController作为根视图
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        _mainView = [storyBoard instantiateInitialViewController];
        [self addChildViewController:_mainView];
        [self.view addSubview:_mainView.view];
        [self.view removeFromSuperview];
        _mainView.view.frame = self.view.bounds;
        //_mainNav = [storyBoard instantiateInitialViewController];
//        [self addChildViewController:_mainNav];
//        
//        [self.view addSubview:_mainNav.view];
//        _mainNav.view.frame = self.view.bounds;
        
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
//        _mainNav = [storyBoard instantiateViewControllerWithIdentifier:@"SlideNavigationController"];
//        [self presentViewController:_mainNav animated:YES completion:nil];

  }
    


}

@end
