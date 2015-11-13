//
//  NoteDAO.m
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "NoteDAO.h"
#import "NoteManagedObject.h"

@implementation NoteDAO

static NoteDAO *shareManager = nil;

+ (NoteDAO*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once,^{
    
        shareManager = [[self alloc]init];
        [shareManager managedObjectContext];
    });
    return shareManager;
}

//插入Note方法
-(int) create:(Note*)model{
    NSManagedObjectContext *context = [self managedObjectContext];
    NoteManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Notes" inManagedObjectContext:context];
    [note setValue:model.content forKey:@"content"];
    [note setValue:model.time forKey:@"time"];
    
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"插入数据失败：%@，%@",error,[error userInfo]);
    }
    return 0;
}

//删除Note方法
-(int) remove:(Note*)model{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *note = [NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:note];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time = %@",model.time];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        NoteManagedObject *noteModel = [listData lastObject];
        [self.managedObjectContext deleteObject:noteModel];
        
        error = nil;
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"插入数据失败：%@，%@",error,[error userInfo]);
            return  -1;
        }
    }
    return  0;
}

//修改Note方法
-(int) modify:(Note*)model{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *note = [NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:note];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time = %@",model.time];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        note.content = model.content;
        
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
    NSEntityDescription *note = [NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:note];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"time" ascending:YES];
    NSArray *sortArr = @[sortDescriptor];
    request.sortDescriptors = sortArr;
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];
    
    NSMutableArray *resListData = [[NSMutableArray alloc]init];
    
    for (NoteManagedObject *mo in listData) {
        Note *noteModel = [[Note alloc]initWithContent:mo.content time:mo.time];
        [resListData addObject:noteModel];
    }
    
    return resListData;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *note = [NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:note];
    [request setPredicate:[NSPredicate predicateWithFormat:@"time = %@",model.time]];
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];

    if ([listData count] > 0 ) {
        NoteManagedObject *mo = [listData lastObject];
        Note *noteModel = [[Note alloc]initWithContent:mo.content time:mo.time];
        return noteModel;
    }

    return nil;
}



@end
