//
//  UserBL.m
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "UserBL.h"
#import "UserDAO.h"

@implementation UserBL

//插入User方法
-(NSMutableArray*) createUser:(User*)model{
    UserDAO *dao = [UserDAO sharedManager];
    [dao create:model];
    return [dao findAll];
}

//删除User方法
-(NSMutableArray*) remove:(User*)model{
    UserDAO *dao = [UserDAO sharedManager];
    [dao remove:model];
    return [dao findAll];
}

//查询所用数据方法
-(NSMutableArray*) findAll{
    UserDAO *dao = [UserDAO sharedManager];
    return [dao findAll];
}

//修改数据方法
-(NSMutableArray*) update:(User*)model{
    UserDAO *dao = [UserDAO sharedManager];
    [dao modify:model];
    return [dao findAll];
}

//修改密码
-(void) updatePwd:(User*)model{
    UserDAO *dao = [UserDAO sharedManager];
    [dao modify:model];
}

@end
