//
//  User.m
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithName:(NSString*)name password:(NSString*)password{
    self = [super init];
    if (self) {
        self.name     = name;
        self.password = password;
    }
    return  self;
}

@end
