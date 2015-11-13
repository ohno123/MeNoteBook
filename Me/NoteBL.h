//
//  NoteBL.h
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface NoteBL : NSObject

//插入Note方法
-(NSMutableArray*) createNote:(Note*)model;

//删除Note方法
-(NSMutableArray*) remove:(Note*)model;

//查询所用数据方法
-(NSMutableArray*) findAll;

//修改数据方法
-(NSMutableArray*) update:(Note*)model;

@end
