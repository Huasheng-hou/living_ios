//
//  LMFriendListRequest.m
//  living
//
//  Created by Ding on 2016/11/3.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMFriendListRequest.h"

@implementation LMFriendListRequest

-(id)initWithPageIndex:(NSInteger)pageIndex andPageSize:(NSInteger)pageSize
{
    self = [super init];
    if (self) {
        NSMutableDictionary *body = [NSMutableDictionary new];
        if (pageIndex != -1) {
            [body setObject:[NSString stringWithFormat:@"%ld", (long)pageIndex] forKey:@"pageIndex"];
        }
        if (pageSize != -1) {
            [body setObject:[NSString stringWithFormat:@"%ld", (long)pageSize] forKey:@"pageSize"];
        }
        
        NSMutableDictionary *parmDic = [self params];
        [parmDic setValue:body forKey:@"body"];
    }
    return self;
    
}
- (BOOL)isPost
{
    return YES;
}


- (NSString *)methodPath
{
    return @"friends/list";
}

@end
