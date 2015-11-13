//
//  Note.m
//  Me
//
//  Created by 艾葭 on 15/9/8.
//  Copyright (c) 2015年 艾葭. All rights reserved.
//

#import "Note.h"

@implementation Note

-(id)initWithContent:(NSString*)content time:(NSString*)time{
    self = [super init];
    if (self) {
        self.content = content;
        self.time    = time;
    }
    return  self;
}

@end
