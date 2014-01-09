//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Tom Carter on 1/7/14.
//  Copyright (c) 2014 Louglu. All rights reserved.
//

@import Foundation;
#import "Deck.h"

@interface CardMatchingGame : NSObject
- (instancetype) init;
// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger cardsInAMatch;
@property (nonatomic, readonly) NSArray *lastChosenCards;
@property (nonatomic, readonly) NSInteger lastScore;
@end
