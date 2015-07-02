//
//  TweetViewController.h
//  twitter
//
//  Created by Bipo Tsai on 7/2/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"


@interface TweetViewController : UIViewController

@property (strong, nonatomic) Tweet* tweet;
@property NSString *tweetIDForResponse;
@end
