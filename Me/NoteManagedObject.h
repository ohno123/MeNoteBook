//
//  NoteManagedObject.h
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//
//实体类，需要被CoreData管理

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteManagedObject : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * time;

@end
