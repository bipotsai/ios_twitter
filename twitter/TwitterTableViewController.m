//
//  TwitterTableViewController.m
//  twitter
//
//  Created by Bipo Tsai on 7/2/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "TwitterTableViewController.h"
#import <UIImageView+AFNetworking.h>
#import "TwitterClient.h"
#import "TwitterCell.h"
#import "Tweet.h"
#import "TweetViewController.h"
#import "SVProgressHUD.h"

@interface TwitterTableViewController () <UITableViewDataSource, UITableViewDelegate, TwitterCellDelegate>

@property (strong, nonatomic) NSMutableArray *tweetsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TwitterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.title = @"Twitter";
    
    // Setup Navigation Bar
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    UIBarButtonItem* newTweetButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweet)];
    self.navigationItem.rightBarButtonItem = newTweetButton;

    // Refresh Table
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getInitialTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self getInitialTweets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getInitialTweets {
    self.tweetsArray = [[NSMutableArray alloc] init];
    [self getTweets:nil];
}

- (void)getTweets:(NSDictionary *)params {
    [SVProgressHUD setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:@"Loading Tweets"];
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        [self addTweetsToTable:tweets];
    }];
}

- (void)addTweetsToTable: (NSArray *)tweets {
    NSLog(@"addTweetsToTable");
    [self.tweetsArray addObjectsFromArray:tweets];
    [self.tableView reloadData];
    // Kill any and all UI loading helpers
    [self.refreshControl endRefreshing];
    [SVProgressHUD dismiss];
}

- (void)onLogout {
    [User logout];
}

- (void)onNewTweet {
    NSLog(@"New Tweet Please");

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TweetViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TweetView"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    //UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];

    

    [self.navigationController pushViewController:vc animated:YES];

    
    
    
}

- (void)TwitterCell:(TwitterCell *)tweetCell onReply:(BOOL)pressed {
    NSLog(@"Table View Controller on reply");
}

- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section{
    return self.tweetsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        TwitterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwitterCell" forIndexPath:indexPath];
    cell.tweet = self.tweetsArray[indexPath.row];
    cell.delegate = self;
    NSLog(@"cell");
    // End of the table?
//    if (indexPath.row == [self tableView:self.tableView numberOfRowsInSection:0] - 1) {
//        NSLog(@"load more");
//        [self getMoreTweets:nil];
//    }
    
    return cell;
}

- (void)getMoreTweets:(NSDictionary *) params {
    // Grab id of last tweet and set to max_id
    Tweet* lastTweet = self.tweetsArray.lastObject;
    NSNumber *maxID = [[NSNumber alloc] initWithInteger:lastTweet.tweetId];
    
    if (params == nil) {
        params = [[NSDictionary alloc] init];
    }
    
    NSMutableDictionary *paramsToSend = [NSMutableDictionary dictionaryWithDictionary:params];
    [paramsToSend setObject:maxID forKey:@"max_id"];
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:paramsToSend completion:^(NSArray *tweets, NSError *error) {
        [self addTweetsToTable:tweets];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TweetViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TweetView"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];

    vc.tweet = self.tweetsArray[indexPath.row];
    NSLog(@" id : %@", vc.tweet.tweetId);
   [self.navigationController pushViewController:vc animated:YES];
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
