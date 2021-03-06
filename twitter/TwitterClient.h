//
//  TwitterClient.h
//  twitter
//
//  Created by Bipo Tsai on 6/30/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;

- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)mentionsWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)userTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)userFavoritesWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)tweet:(NSDictionary *)params completion:(void (^)(Tweet *tweet, NSError *error))completion;

- (void)favorite:(NSString *)tweetIdStr completion:(void (^)(NSError *error))completion;
- (void)unfavorite:(NSString *)tweetIdStr completion:(void (^)(NSError *error))completion;
- (void)retweet:(NSString *)tweetIdStr completion:(void (^)(NSError *error))completion;
- (void)getProfileBanner:(NSString *)userIdStr completion:(void (^)(NSDictionary *bannerData, NSError *error))completion;
- (User *)getUser;

@end