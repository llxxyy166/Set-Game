//
//  SetGame.m
//  CardGame
//
//  Created by xinye lei on 15/12/15.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import "SetGame.h"

@interface SetGame ()
@property (strong, nonatomic) NSMutableArray *compareCards;
@property (strong, nonatomic) NSMutableArray *existedSets;
@property (strong, nonatomic) NSMutableArray *setFound;
@end
@implementation SetGame

- (NSMutableArray *)setFound {
    if (!_setFound) {
        _setFound = [[NSMutableArray alloc] init];
    }
    return _setFound;
}

- (NSMutableArray *)gameDeck {
    if (!_gameDeck) {
        _gameDeck = [[NSMutableArray alloc] init];
    }
    return _gameDeck;
}

- (NSMutableArray *)compareCards {
    if (!_compareCards) {
        _compareCards = [[NSMutableArray alloc] init];
    }
    return _compareCards;
}

- (NSMutableArray *)existedSets {
    if (!_existedSets) {
        _existedSets = [[NSMutableArray alloc] init];
    }
    return _existedSets;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(SetDeck *)deck {
    self = [super init];
    if (self) {
        self.score = 0;
        self.currentStatus = 0;
        do {
            self.existedSets = nil;
            self.gameDeck = nil;
            self.setFound = nil;
            for (int i = 0; i < count; i++) {
                Card *card = [deck drawRandomCard];
                if (card) {
                    [self.gameDeck addObject:card];
                }
                else {
                    return nil;
                }
                
            }
        }while(!(self.numOfSets = [self numberOfSets]));
    }
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    SetCard *card = [self.gameDeck objectAtIndex:index];
    if (card.chosen) {
        card.chosen = NO;
        self.currentStatus = 0;
        [self.compareCards removeLastObject];
    }
    else {
        if ([self.compareCards count] < 2) {
            [self.compareCards addObject:card];
            card.chosen = YES;
            self.currentStatus = 0;
        }
        else {
            for (SetCard *card in self.compareCards) {
                card.chosen = NO;
            }
            int match = [card match:self.compareCards];
            if (match) {
                for (NSSet *set in self.setFound) {
                    if ([set isEqualToSet:[NSSet setWithObjects:card, self.compareCards[0],self.compareCards[1], nil]]) {
                        match = 0;
                        self.currentStatus = 2;
                        break;
                    }
                }
            }
            else {
                self.currentStatus = 1;
            }
            if (match) {
                [self.setFound addObject:[NSSet setWithObjects:card, self.compareCards[0],self.compareCards[1], nil]];
                self.currentStatus = 3;
            }
            self.score += match;
            self.compareCards = nil;
        }
    }
}

- (SetCard *)cardAtIndex:(NSUInteger)index {
    SetCard *card = nil;
    if (index < [self.gameDeck count]) {
        card = [self.gameDeck objectAtIndex:index];
    }
    return card;
}

- (int)numberOfSets {
    int num = 0;
    for (int i = 0; i < [self.gameDeck count]; i++) {
        for (int j = i + 1; j < [self.gameDeck count]; j++) {
            for (int k = j + 1; k < [self.gameDeck count]; k++) {
                int match = [[self.gameDeck objectAtIndex:k] match:@[[self.gameDeck objectAtIndex:i],[self.gameDeck objectAtIndex:j]]];
                if (match) {
                    NSSet *set = [NSSet setWithObjects:[self.gameDeck objectAtIndex:i], [self.gameDeck objectAtIndex:j],[self.gameDeck objectAtIndex:k], nil];
                    [self.existedSets addObject:set];
                }
                num += match;
            }
        }
    }
    return num;
}

- (NSArray *)setsExiseted {
    return [NSArray arrayWithArray:self.existedSets];
}


@end
