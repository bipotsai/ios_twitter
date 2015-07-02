//
//  LoginViewController.m
//  twitter
//
//  Created by Bipo Tsai on 7/2/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "LoginViewController.h"

#import "TwitterClient.h"
#import "TwitterTableViewController.h"
#import "User.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
           NSLog(@"LoginViewController LoggedIn %@", user.name);
          // Modally presents the tweets view
          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
          TwitterTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TwitterTableViewController"];
            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
          [self.navigationController pushViewController:nvc animated:YES];
        } else {
             NSLog(@"LoginViewController Not LoggedIn ");
            // Presents Error View
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Twitter Login";
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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