//
//  LMVoiceStartRequest.m
//  living
//
//  Created by Ding on 2016/12/14.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMVoiceStartRequest.h"

@implementation LMVoiceStartRequest

- (id)initWithVoice_uuid:(NSString *)voice_uuid
{
    self = [super init];
    
    if (self){
        
        NSMutableDictionary *bodyDict   = [NSMutableDictionary new];
        
        if (voice_uuid){
            [bodyDict setObject:voice_uuid forKey:@"voice_uuid"];
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
    return @"voice/start";//导师开始课程
}

@end
