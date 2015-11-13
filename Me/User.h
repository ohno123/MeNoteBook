//
//  User.h
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* password;

-(id)initWithName:(NSString*)name password:(NSString*)password;
@end
