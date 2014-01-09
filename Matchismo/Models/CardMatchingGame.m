//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Tom Carter on 1/7/14.
//  Copyright (c) 2014 Louglu. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSArray *lastChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger) cardsInAMatch {
    if (!_cardsInAMatch) _cardsInAMatch = 2;
    return _cardsInAMatch;
}

- (instancetype)init {
    return nil;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
    } else {
        NSLog(@"CardMatchingGame failed to initialize");
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *matches = [[NSMutableArray alloc] init];
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [matches addObject:otherCard];
                }
            }
            
            self.lastScore = 0;
            self.lastChosenCards = [matches arrayByAddingObject:card];
            
                
            if ([matches count] + 1 == self.cardsInAMatch) {
                int matchScore = [card match:matches];
                if (matchScore) {
                    self.lastScore = matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *match in matches) {
                        match.matched = YES;
                    }
                } else {
                    self.lastScore -= MISMATCH_PENALTY;
                    for (Card *match in matches) {
                        match.chosen = NO;
                    }
                }
            }
            self.score += self.lastScore - COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
