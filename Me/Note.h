//
//  Note.h
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//
//未被管理的实体类

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property(nonatomic, strong) NSString* content;
@property(nonatomic, strong) NSString* time;

-(id)initWithContent:(NSString*)content time:(NSString*)time;

@end
