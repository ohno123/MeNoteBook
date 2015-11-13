//
//  UserDAO.m
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "UserDAO.h"
#import "UserManagedObject.h"

@implementation UserDAO

static UserDAO *shareManager = nil;

+ (UserDAO*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        shareManager = [[self alloc]init];
        [shareManager managedObjectContext];
    });
    return shareManager;
}

//插入User方法
-(int) create:(User*)model{
    NSManagedObjectContext *context = [self managedObjectContext];
    UserManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    [user setValue:model.name forKey:@"name"];
    [user setValue:model.password forKey:@"password"];
    
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"插入数据失败：%@，%@",error,[error userInfo]);
    }
    return 0;
}

//删除User方法
-(int) remove:(User*)model{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *note = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:note];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",model.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        UserManagedObject *userModel = [listData lastObject];
        [self.managedObjectContext deleteObject:userModel];
        
        error = nil;
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"插入数据失败：%@，%@",error,[error userInfo]);
            return  -1;
        }
    }
    return  0;
}

//修改User方法
-(int) modify:(User*)model{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *user = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:user];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",model.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        UserManagedObject *userModel = [listData lastObject];
        userModel.password = model.password;
        //NSLog(@"看看是不是来修改了啊");
        error = nil;
        if ([context hasChanges] && ![context save:&error]){
            NSLog(@"修改数据失败:%@, %@", error, [error userInfo]);
            return -1;
        }
    }
    return 0;
}


//查询所有数据方法
-(NSMutableArray*) findAll{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *note = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:note];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    NSArray *sortArr = @[sortDescriptor];
    request.sortDescriptors = sortArr;
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];
    
    NSMutableArray *resListData = [[NSMutableArray alloc]init];
    
    for (UserManagedObject *mo in listData) {
        User *userModel = [[User alloc]initWithName:mo.name password:mo.password];
        [resListData addObject:userModel];
    }
    
    return resListData;
}

@end
