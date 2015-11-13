//
//  NoteDAO.h
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "CoreDataDAO.h"
#import "Note.h"

@interface NoteDAO : CoreDataDAO

+ (NoteDAO*)sharedManager;

//插入Note方法
-(int) create:(Note*)model;

//删除Note方法
-(int) remove:(Note*)model;

//修改Note方法
-(int) modify:(Note*)model;

//查询所有数据方法
-(NSMutableArray*) findAll;

//按照主键查询数据方法
-(Note*) findById:(Note*)model;

@end
