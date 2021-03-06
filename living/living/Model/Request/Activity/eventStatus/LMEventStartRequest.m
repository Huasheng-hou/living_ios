//
//  LMEventStartRequest.m
//  living
//
//  Created by Ding on 2016/11/9.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMEventStartRequest.h"

@implementation LMEventStartRequest

-(id)initWithEvent_uuid:(NSString *)event_uuid

{
    self = [super init];
    
    if (self){
        
        NSMutableDictionary *bodyDict   = [NSMutableDictionary new];
        
        if (event_uuid){
            [bodyDict setObject:event_uuid forKey:@"event_uuid"];
        }
        
        
        
        NSMutableDictionary *paramsDict = [self params];
        [paramsDict setObject:bodyDict forKey:@"body"];
    }
    return self;
}

- (BOOL)isPost
{
    return YES;
}

- (NSString *)methodPath
{
    return @"event/start";
}

@end
