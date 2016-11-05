//
//  LMEventDetailLeavingMessages.h
//
//  Created by   on 2016/11/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LMEventDetailLeavingMessages : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *commentContent;
@property (nonatomic, strong) NSString *replyTime;
@property (nonatomic, strong) NSString *replyUuid;
@property (nonatomic, strong) NSString *userUuid;
@property (nonatomic, strong) NSString *commentTime;
@property (nonatomic, strong) NSString *commentUuid;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *respondentNickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) BOOL hasPraised;
@property (nonatomic, assign) double praiseCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
