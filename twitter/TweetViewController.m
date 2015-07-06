//
//  TweetViewController.m
//  twitter
//
//  Created by Bipo Tsai on 7/2/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "Tweet.h"

@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentInput;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* newTweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweet)];
    self.navigationItem.rightBarButtonItem = newTweetButton;

    User *user = [User currentUser];

    if(_tweet.tweetId.length > 0){
        self.title = @"Reply Tweet";
        [self.profileImage setImageWithURL:[NSURL URLWithString:_tweet.user.profileImageUrl]];
        self.idLabel.text = _tweet.user.name;
        self.locationLabel.text = _tweet.user.location;
        
        self.tweetIDForResponse = _tweet.tweetId;
        self.contentLabel.text = _tweet.text;

    }else{
        self.title = @"New Tweet";
        [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
        self.idLabel.text = user.name;
        self.locationLabel.text = user.location;
        self.tweetIDForResponse = @"";
        [self.contentLabel setHidden:YES];

    } 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setTweet:(Tweet *)tweet {
    _tweet = tweet;
}
- (void)onNewTweet {

    User *user = [User currentUser];
    
    NSString *string1 = [NSString stringWithFormat:@"@%@ %@", user.screenname, self.contentInput.text];
    NSLog(@"%@", string1);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:string1 forKey:@"status"];
    if(self.tweetIDForResponse.length > 0){
        [params setObject:self.tweetIDForResponse forKey:@"in_reply_to_status_id"];
    }
    
    
    
    
    [[TwitterClient sharedInstance] tweet:params completion:^(Tweet* tweet, NSError *error){
        if (error != nil) {
            
            NSLog(@"Compose failed!");
        } else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TweetViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TwitterTableViewController"];
            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
            //UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
            
            
            
            [self.navigationController pushViewController:vc animated:YES];
        };
    }];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
