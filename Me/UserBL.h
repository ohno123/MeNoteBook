//
//  UserBL.h
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserBL : NSObject

//插入User方法
-(NSMutableArray*) createUser:(User*)model;

//删除User方法
-(NSMutableArray*) remove:(User*)model;

//查询所用数据方法
-(NSMutableArray*) findAll;

//修改数据方法
-(NSMutableArray*) update:(User*)model;

@end
