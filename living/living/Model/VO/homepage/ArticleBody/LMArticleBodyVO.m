//
//  LMArticleBodyVO.m
//  living
//
//  Created by Ding on 2016/11/5.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMArticleBodyVO.h"

@implementation LMArticleBodyVO

+ (LMArticleBodyVO *)LMArticleBodyVOWithJSONString:(NSString *)jsonString usingEncoding:(NSStringEncoding)stringEncoding error:(NSError **)error
{
    NSData *jsonData = [jsonString dataUsingEncoding:stringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:0
                                                                     error:error];
    
    if (nil != error && nil != jsonDictionary) {
        return [LMArticleBodyVO LMArticleBodyVOWithDictionary:jsonDictionary];
    }
    
    return nil;
}

+ (LMArticleBodyVO *)LMArticleBodyVOWithDictionary:(NSDictionary *)dictionary
{
    LMArticleBodyVO *instance = [[LMArticleBodyVO alloc] initWithDictionary:dictionary];
    return JSONAutoRelease(instance);
}

+ (NSArray *)LMArticleBodyVOListWithArray:(NSArray *)array
{
    if (!array || ![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    
    for (id entry in array) {
        if (![entry isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        [resultsArray addObject:[LMArticleBodyVO LMArticleBodyVOWithDictionary:entry]];
    }
    
    return JSONAutoRelease(resultsArray);
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        if (nil != [dictionary objectForKey:@"article_praise_num"] && ![[dictionary objectForKey:@"article_praise_num"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"article_praise_num"] isKindOfClass:[NSNumber class]]) {
            self.articlePraiseNum = [(NSNumber *)[dictionary objectForKey:@"article_praise_num"] intValue];
        }
        
        if (nil != [dictionary objectForKey:@"avatar"] && ![[dictionary objectForKey:@"avatar"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"avatar"] isKindOfClass:[NSString class]]) {
            self.avatar = [dictionary objectForKey:@"avatar"];
        }
        
        if (nil != [dictionary objectForKey:@"article_title"] && ![[dictionary objectForKey:@"article_title"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"article_title"] isKindOfClass:[NSString class]]) {
            self.articleTitle = [dictionary objectForKey:@"article_title"];
        }
        
        if (nil != [dictionary objectForKey:@"article_content"] && ![[dictionary objectForKey:@"article_content"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"article_content"] isKindOfClass:[NSString class]]) {
            self.articleContent = [dictionary objectForKey:@"article_content"];
        }
        
        if (nil != [dictionary objectForKey:@"describe"] && ![[dictionary objectForKey:@"describe"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"describe"] isKindOfClass:[NSString class]]) {
            self.describe = [dictionary objectForKey:@"describe"];
        }
        
        if (nil != [dictionary objectForKey:@"has_praised"] && ![[dictionary objectForKey:@"has_praised"] isEqual:[NSNull null]]) {
            self.hasPraised = [(NSNumber *)[dictionary objectForKey:@"has_praised"] boolValue];
        }
        
        if (nil != [dictionary objectForKey:@"publish_time"] && ![[dictionary objectForKey:@"publish_time"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"publish_time"] isKindOfClass:[NSString class]]) {
            NSDateFormatter     *formatter  = [[NSDateFormatter alloc] init];
            
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            self.publishTime = [formatter dateFromString:[dictionary objectForKey:@"publish_time"]];
            
        }
        
        if (nil != [dictionary objectForKey:@"comment_num"] && ![[dictionary objectForKey:@"comment_num"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"comment_num"] isKindOfClass:[NSNumber class]]) {
            self.commentNum = [(NSNumber *)[dictionary objectForKey:@"comment_num"] intValue];
        }
        
        if (nil != [dictionary objectForKey:@"uuid"] && ![[dictionary objectForKey:@"uuid"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"uuid"] isKindOfClass:[NSNumber class]]) {
            self.fakaid = [(NSNumber *)[dictionary objectForKey:@"uuid"] intValue];
        }
        
        if (nil != [dictionary objectForKey:@"article_name"] && ![[dictionary objectForKey:@"article_name"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"article_name"] isKindOfClass:[NSString class]]) {
            self.articleName = [dictionary objectForKey:@"article_name"];
        }
        
        if (nil != [dictionary objectForKey:@"user_uuid"] && ![[dictionary objectForKey:@"user_uuid"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"user_uuid"] isKindOfClass:[NSString class]]) {
            self.userUuid = [dictionary objectForKey:@"user_uuid"];
        }
        
        if (nil != [dictionary objectForKey:@"article_uuid"] && ![[dictionary objectForKey:@"article_uuid"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"article_uuid"] isKindOfClass:[NSString class]]) {
            self.articleUuid = [dictionary objectForKey:@"article_uuid"];
        }
        
        if (dictionary[@"article_imgs"] && [dictionary[@"article_imgs"] isKindOfClass:[NSArray class]]) {
            self.articleImgs = dictionary[@"article_imgs"];
        }
        
        if (nil != [dictionary objectForKey:@"type"] && ![[dictionary objectForKey:@"type"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"type"] isKindOfClass:[NSString class]]) {
            self.type = [dictionary objectForKey:@"type"];
        }
        /******/
        if (nil != [dictionary objectForKey:@"name"] && ![[dictionary objectForKey:@"name"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"name"] isKindOfClass:[NSString class]]) {
            self.name = [dictionary objectForKey:@"name"];
        }
        if (nil != [dictionary objectForKey:@"title"] && ![[dictionary objectForKey:@"title"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"title"] isKindOfClass:[NSString class]]) {
            self.title = [dictionary objectForKey:@"title"];
        }
        if (nil != [dictionary objectForKey:@"content"] && ![[dictionary objectForKey:@"content"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"content"] isKindOfClass:[NSString class]]) {
            self.content = [dictionary objectForKey:@"content"];
        }
        if (nil != [dictionary objectForKey:@"review_uuid"] && ![[dictionary objectForKey:@"review_uuid"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"review_uuid"] isKindOfClass:[NSString class]]) {
            self.reviewUuid = [dictionary objectForKey:@"review_uuid"];
        }
        if (nil != [dictionary objectForKey:@"imgs"] && ![[dictionary objectForKey:@"imgs"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"imgs"] isKindOfClass:[NSArray class]]) {
            self.imgs = [dictionary objectForKey:@"imgs"];
        }
        if (nil != [dictionary objectForKey:@"praise_num"] && ![[dictionary objectForKey:@"praise_num"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"praise_num"] isKindOfClass:[NSNumber class]]) {
            self.praiseNum = [[dictionary objectForKey:@"praise_num"] intValue];
        }
    }
    return self;
}

@end
