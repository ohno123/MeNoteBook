//
//  NoteBL.m
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "NoteBL.h"
#import "NoteDAO.h"

@implementation NoteBL

//插入Note方法
-(NSMutableArray*) createNote:(Note*)model{
    NoteDAO *dao = [NoteDAO sharedManager];
    [dao create:model];
    return [dao findAll];
}

//删除Note方法
-(NSMutableArray*) remove:(Note*)model{
    NoteDAO *dao = [NoteDAO sharedManager];
    [dao remove:model];
    
    return [dao findAll];
}

//查询所用数据方法
-(NSMutableArray*) findAll{
    NoteDAO *dao = [NoteDAO sharedManager];
    return [dao findAll];

}

//修改数据方法
-(NSMutableArray*) update:(Note*)model{
    NoteDAO *dao = [NoteDAO sharedManager];
    [dao modify:model];
    return [dao findAll];
}

@end
