//
//  TwitterCell.m
//  twitter
//
//  Created by Bipo Tsai on 7/2/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "TwitterCell.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"

@implementation TwitterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTweet:(Tweet *)tweet {
    _tweet = tweet;
    NSLog(@" name = %@", tweet.user.name);
    [self.profileImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    self.idLabel.text = tweet.user.name;
    self.locationLabel.text = tweet.user.location;
    self.tweetTimeLabel.text = tweet.createdAgo;
    self.contentLabel.text = tweet.text;
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%ld",(long)tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%ld", tweet.retweetCount];
}

- (void) onReply {
    NSLog(@"Replying to tweet");
}

@end
