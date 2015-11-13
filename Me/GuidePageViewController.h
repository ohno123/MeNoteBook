//
//  GuidePageViewController.h
//  Me
//
//  Created by 艾葭 on 15/8/28.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol StartPageViewControllerDelegate <NSObject>
//
//-(void)buttonPressedToStart:(UIViewController *)sender;
//
//@end

@interface GuidePageViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property UIButton *pressButton;
//@property (nonatomic, weak) id<StartPageViewControllerDelegate> delegate;

@end
