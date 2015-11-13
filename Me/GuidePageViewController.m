//
//  GuidePageViewController.m
//  Me
//
//  Created by 艾葭 on 15/8/28.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "GuidePageViewController.h"
#import "ViewController.h"

@interface GuidePageViewController ()

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加载新用户指导
    [self initGuide];
}

-(void)initGuide{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    //允许分页
    [self.scrollView setPagingEnabled:YES];
    //关闭弹簧
    [self.scrollView setBounces:NO];
    //关闭水平滚动条
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.scrollView];
    
    
    //pageControl
//    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*.88, self.view.frame.size.width+40, 20)];
//    //pageControl的颜色
//    self.pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
//    [self.view addSubview:self.pageControl];
    
    //pageControl的页数
    self.pageControl.numberOfPages = 3;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.scrollView.frame.size.height);
    
    //ScrollView开始的点
    CGPoint scrollPoint = CGPointMake(0, 0);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
    
    //显示3个不同的页面显示
    [self createViewOne];
    [self createViewTwo];
    [self createViewThree];
    
    //立即体验进入按钮
    self.pressButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.25, self.view.frame.size.height*.8, self.view.frame.size.width*.6, 34)];
    //按钮文字颜色
    [self.pressButton setTitleColor:[UIColor colorWithRed:82.0/255 green:173.0/255 blue:172.0/255 alpha:1.000] forState:UIControlStateNormal];
    [self.pressButton setTitle:@"立即体验" forState:UIControlStateNormal];
    [self.pressButton.titleLabel setFont:[UIFont fontWithName:@"幼圆" size:18.0]];
    
    // 按钮边框设置
    self.pressButton.layer.borderColor = [UIColor colorWithRed:82.0/255 green:173.0/255 blue:172.0/255 alpha:1.000].CGColor;
    [self.pressButton addTarget:self action:@selector(buttonPressedToStart) forControlEvents:UIControlEventTouchUpInside];
    self.pressButton.layer.borderWidth =1.0;
    self.pressButton.layer.cornerRadius = 18;
    
    [self.pressButton addTarget:self action:@selector(buttonPressedToStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pressButton];

    
}

-(void)buttonPressedToStart{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"SlideNavigationController"];
    [self presentViewController:vc animated:YES completion:nil];
   // [self presentModalViewController:vc animated:YES];  //点击button跳转到根视图
}

//scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
}


-(void)createViewOne{
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"引导页1"]]];
//    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    backgroundImageView.image = [UIImage imageNamed:@"引导页1"];
//    [view addSubview:backgroundImageView];
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}


-(void)createViewTwo{
    
    CGFloat originWidth = self.view.frame.size.width;
    CGFloat originHeight = self.view.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth, 0, originWidth, originHeight)];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = [UIImage imageNamed:@"引导页2"];
    [view addSubview:backgroundImageView];
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}

-(void)createViewThree{
    
    CGFloat originWidth = self.view.frame.size.width;
    CGFloat originHeight = self.view.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*2, 0, originWidth, originHeight)];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = [UIImage imageNamed:@"引导页3"];
    [view addSubview:backgroundImageView];

    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
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

@end
