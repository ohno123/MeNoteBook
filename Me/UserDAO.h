//
//  UserDAO.h
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "CoreDataDAO.h"
#import "User.h"

@interface UserDAO : CoreDataDAO

+ (UserDAO*)sharedManager;

//插入User方法
-(int) create:(User*)model;

//删除User方法
-(int) remove:(User*)model;

//修改User方法
-(int) modify:(User*)model;

//查询所有数据方法
-(NSMutableArray*) findAll;


@end
