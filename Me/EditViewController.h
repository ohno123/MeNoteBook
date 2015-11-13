//
//  EditViewController.h
//  Me
//
//  Created by 艾葭 on 15/8/31.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController

@property(nonatomic, strong) id detailItem;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;


@end
