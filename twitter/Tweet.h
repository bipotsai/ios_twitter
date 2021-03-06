//
//  Tweet.h
//  twitter
//
//  Created by Bipo Tsai on 6/30/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, assign) NSInteger favoriteCount;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, strong) NSString *tweetId;
@property (nonatomic, assign) NSInteger retweetCount;
@property (nonatomic, assign) BOOL retweeted;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) Tweet *childTweet; // for retweet/like/reply. For example, for retweet, it is under "retweeted_status"
@property (nonatomic, strong) NSDate *createAt;
@property (nonatomic, strong) NSString *createdAgo;
@property (nonatomic, strong) User *user;
// TODO: add one for hashtags
// TODO: add one for other media/urls
@property (nonatomic, strong) NSString *tweetPhotoUrl;
@property (nonatomic, strong) NSMutableArray *tweetPhotoUrls;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)tweetsWithArray:(NSArray *)dictionaries;

@end