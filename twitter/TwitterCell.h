//
//  TwitterCell.h
//  twitter
//
//  Created by Bipo Tsai on 7/2/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TwitterCell;

@protocol TwitterCellDelegate <NSObject>

- (void) TwitterCell:(TwitterCell *)tweetCell onReply:(BOOL)pressed;

@end

@interface TwitterCell : UITableViewCell

@property (strong, nonatomic) Tweet* tweet;
@property (weak, nonatomic) id<TwitterCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@end
