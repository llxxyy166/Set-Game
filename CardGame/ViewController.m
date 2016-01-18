//
//  ViewController.m
//  CardGame
//
//  Created by xinye lei on 15/12/15.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import "ViewController.h"
#import "SetGame.h"
#import "SetCardView.h"
#import "SymbolView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *whatHappens;
@property (strong, nonatomic) IBOutletCollection(SetCardView) NSArray *setCardsViews;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *totalSets;
@property (weak, nonatomic) IBOutlet UIButton *showAnswerButton;

@property (strong, nonatomic)SetGame *game;
@property (strong, nonatomic)SetDeck *deck;
@property (weak, nonatomic) UILabel *gameCompleteLabel;

@property (strong, nonatomic)NSArray *originPosition;
@property (strong, nonatomic)NSMutableArray *setCardsNeedToAnimate;
@end

@implementation ViewController

-(void)awakeFromNib {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults integerForKey:TOTAL_SETS_FOUND]) {
        [userDefaults setInteger:0 forKey:TOTAL_SETS_FOUND];
    }
    if (![userDefaults integerForKey:TOTAL_GAMES_WON]) {
        [userDefaults setInteger:0 forKey:TOTAL_GAMES_WON];
    }
    if (![userDefaults integerForKey:TOTAL_GAMES_GIVEUP]) {
        [userDefaults setInteger:0 forKey:TOTAL_GAMES_GIVEUP];
    }
}

- (NSMutableArray *)setCardsNeedToAnimate {
    if (!_setCardsNeedToAnimate) {
        _setCardsNeedToAnimate = [[NSMutableArray alloc] init];
    }
    return _setCardsNeedToAnimate;
}
NSUInteger numOfSetsFound = 0;
NSUInteger answerIndex = 0;

- (IBAction)resetButton:(UIButton *)sender {
    self.game = nil;
    self.deck = nil;
    self.setCardsNeedToAnimate = nil;
    if (self.gameCompleteLabel) {
        [self.gameCompleteLabel removeFromSuperview];
    }
    for (SetCardView *view in self.setCardsViews) {
        [view viewWithTag:1].hidden = NO;
        [view viewWithTag:2].hidden = NO;
        [view viewWithTag:3].hidden = NO;
    }
    [self setUp];
}

- (IBAction)chooseCard:(UITapGestureRecognizer *)sender {
    SetCardView *view = (SetCardView *)sender.view;
    NSUInteger index = [self.setCardsViews indexOfObject:view];
    [self.game chooseCardAtIndex:index];
    BOOL isThisViewInAnimateQueue = NO;
    for (SetCardView *sview in self.setCardsNeedToAnimate) {
        if (view == sview) {
            isThisViewInAnimateQueue = YES;
        }
    }
    if (!isThisViewInAnimateQueue) {
        [self.setCardsNeedToAnimate addObject:view];
    }
    [self updateUI];
    
}

- (IBAction)showAnswer:(UIButton *)sender {
    for (SetCardView *view in self.setCardsViews) {
        view.marked = NO;
        view.chosen = NO;
        view.alpha = 0.5;
        for (UIGestureRecognizer *gesture in view.gestureRecognizers) {
            gesture.enabled = NO;
        }
    }
    self.whatHappens.text = @"";
    NSArray *answer = [self.game setsExiseted];
    if (answerIndex == self.game.numOfSets) {
        answerIndex = 0;
    }
    NSSet *set = [answer objectAtIndex:answerIndex];
    for (SetCard *card in set) {
        NSUInteger index = [self.game.gameDeck indexOfObject:card];
        SetCardView *view = [self.setCardsViews objectAtIndex: index];
        view.marked = YES;
    }
    answerIndex++;
}

- (void)updateUI {
    for (SetCardView *view in self.setCardsViews) {
        NSUInteger index = [self.setCardsViews indexOfObject:view];
        SetCard *card = [self.game.gameDeck objectAtIndex:index];
        view.chosen = card.chosen;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger setsFound = [userDefaults integerForKey:TOTAL_SETS_FOUND];
    NSInteger gameWon = [userDefaults integerForKey:TOTAL_GAMES_WON];
     NSInteger giveup = [userDefaults integerForKey:TOTAL_GAMES_GIVEUP];
    if (self.game.score == self.game.numOfSets) {
        [userDefaults setInteger:++setsFound forKey:TOTAL_SETS_FOUND];
        [userDefaults setInteger:++gameWon forKey:TOTAL_GAMES_WON];
        [userDefaults setInteger:--giveup forKey:TOTAL_GAMES_GIVEUP];
        [UIView animateWithDuration:2 animations:^{
            for (SetCardView *view in self.setCardsViews) {
                int x = (arc4random()%(int)(self.view.bounds.size.width*5)) - (int)self.view.bounds.size.width*2;
                int y = self.view.bounds.size.height;
                view.center = CGPointMake(x, 2 * y);
            }
        }
         completion:^(BOOL finished) {
             self.whatHappens.text = @"";
             self.score.text = @"";
             self.totalSets.text = @"";
             self.showAnswerButton.enabled = NO;
             for (SetCardView *view in self.setCardsViews) {
                 view.marked = NO;
                 view.alpha = 0;
                 for (UIGestureRecognizer *gesture in view.gestureRecognizers) {
                     gesture.enabled = NO;
                 }
             }
             CGRect frame;
             frame.origin = CGPointZero;
             frame.size = self.view.bounds.size;
             UILabel *label = [[UILabel alloc] initWithFrame:frame];
             label.textAlignment = NSTextAlignmentCenter;
             label.lineBreakMode = NSLineBreakByWordWrapping;
             label.numberOfLines = 0;
             label.highlighted = YES;
             label.text = [NSString stringWithFormat:@"Congratulations!!\nYou already got all the Set(s)!!\nTime to start again!!"];
             label.highlightedTextColor = [UIColor redColor];
             [self.view addSubview:label];
             self.gameCompleteLabel = label;
         }];
        return;
    }
    self.score.text = [NSString stringWithFormat:@"%ld Set(s) Found",(long)self.game.score];
    if (self.game.currentStatus == 0) {
        self.whatHappens.text = @"";
    }
    if (self.game.currentStatus == 1) {
        self.whatHappens.text = [NSString stringWithFormat:@"Opps! Not a Set !!"];
        [self animateNotMatch];
        self.setCardsNeedToAnimate = nil;
    }
    if (self.game.currentStatus == 2) {
        self.whatHappens.text = [NSString stringWithFormat:@"You already got this one!"];
        [self animateNotMatch];
        self.setCardsNeedToAnimate = nil;
    }
    if (self.game.currentStatus == 3) {
        self.whatHappens.text = [NSString stringWithFormat:@"Whoa! You got a new Set!!"];
        [self animateMatch];
        self.setCardsNeedToAnimate = nil;
    }
}

- (void)animateMatch {
    for (SetCardView *view in self.setCardsNeedToAnimate) {
        view.alpha = 0.1;
    }
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        for (SetCardView *view in self.setCardsNeedToAnimate) {
            [UIView setAnimationRepeatCount:4];
            view.alpha = 1;
        }
    } completion: nil
    ];
}

- (void)animateNotMatch {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        for (SetCardView *view in self.setCardsNeedToAnimate) {
            [UIView setAnimationRepeatCount:3];
            CGPoint newCenter;
            newCenter.x = view.center.x;
            newCenter.y = 1.01 * view.center.y;
            view.center = newCenter;
        }
    } completion:nil
    ];
    
}


- (SetDeck *)deck {
    if (!_deck) {
        _deck = [[SetDeck alloc] init];
    }
    return _deck;
}

- (SetGame *)game {
    if (!_game) {
        _game = [[SetGame alloc] initWithCardCount:[self.setCardsViews count] usingDeck:self.deck];
    }
    return _game;
}

- (void)setUp {
    for (SetCardView *view in self.setCardsViews) {
        NSUInteger index = [self.setCardsViews indexOfObject:view];
        SetCard *card = [self.game.gameDeck objectAtIndex:index];
        view.chosen = NO;
        view.marked = NO;
        [self drawSetCard:card toView:view];
        view.alpha = 0;
        for (UIGestureRecognizer *gesture in view.gestureRecognizers) {
            gesture.enabled = YES;
        }
    }
    answerIndex = 0;
    self.score.text = @"0 Set(s) Found";
    self.totalSets.text = [NSString stringWithFormat:@"%lu Set(s) Total",(unsigned long)self.game.numOfSets];
    self.whatHappens.text = @"";
    self.showAnswerButton.enabled = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger giveup = [userDefaults integerForKey:TOTAL_GAMES_GIVEUP];
    [userDefaults setInteger:++giveup forKey:TOTAL_GAMES_GIVEUP];
    [self startGameAnimation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self setUp];
}

- (void)startGameAnimation {
    [UIView animateWithDuration:1 animations:^{
        for (SetCardView *view in self.setCardsViews) {
            view.alpha = 1;
        }
    }];
}

- (void)drawSetCard: (SetCard *)card
             toView: (SetCardView *)view{
    view.symbol = card.symbol;
    view.color = card.color;
    view.shading = card.shading;
    view.number = card.number;
    for (int i = 1; i <= 3; i++) {
        SymbolView *symbolView = [view viewWithTag:i];
        symbolView.symbol = view.symbol;
        symbolView.color = view.color;
        symbolView.shading = view.shading;
        symbolView.number = view.number;
        
    }
    if (view.number == 1) {
        [view viewWithTag:2].hidden = YES;
        [view viewWithTag:3].hidden = YES;
    }
    if (view.number == 2) {
        [view viewWithTag:3].hidden = YES;
    }
}





@end
