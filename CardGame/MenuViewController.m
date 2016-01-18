//
//  MenuViewController.m
//  CardGame
//
//  Created by xinye lei on 15/12/24.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewController.h"
@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *gameTitle;
@property (weak, nonatomic) IBOutlet UILabel *stats1;
@property (weak, nonatomic) IBOutlet UILabel *stats2;
@property (weak, nonatomic) IBOutlet UILabel *stats3;

@end

@implementation MenuViewController

- (void)viewWillAppear:(BOOL)animated {
    self.stats1.hidden = YES;
    self.stats2.hidden = YES;
    self.stats3.hidden = YES;
}

- (IBAction)settingsButton {
}

- (IBAction)statsButton {
    self.stats1.hidden = !self.stats1.hidden;
    self.stats2.hidden = !self.stats2.hidden;
    self.stats3.hidden = !self.stats3.hidden;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger setsFound = [userDefaults integerForKey:TOTAL_SETS_FOUND];
    NSInteger gameWon = [userDefaults integerForKey:TOTAL_GAMES_WON];
    NSInteger giveup = [userDefaults integerForKey:TOTAL_GAMES_GIVEUP];
    self.stats1.text = [NSString stringWithFormat:@"Total Sets Found: %ld",(long)setsFound];
    self.stats2.text = [NSString stringWithFormat:@"Total Games Won: %ld",(long)gameWon];
    self.stats3.text = [NSString stringWithFormat:@"Total Games Given up: %ld",(long)giveup];
}

@end
