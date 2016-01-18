//
//  SetGame.h
//  CardGame
//
//  Created by xinye lei on 15/12/15.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import "SetCard.h"
#import "SetDeck.h"

@interface SetGame : NSObject
@property (nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *gameDeck;
@property (nonatomic) NSUInteger numOfSets;
@property (nonatomic) NSUInteger currentStatus;
- (void) chooseCardAtIndex:(NSUInteger)index;
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(SetDeck *)deck;
- (SetCard *)cardAtIndex:(NSUInteger)index;
- (NSArray *)setsExiseted ;
@end
