//
//  PlayingCard.m
//  Matchismo
//
//  Created by Tom Carter on 1/6/14.
//  Copyright (c) 2014 Louglu. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()
+ (NSArray *)rankStrings;
@end

@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    int numOtherCards = [otherCards count];

    if (numOtherCards) {
        for (Card * card in otherCards) {
            if ([card isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherCard = (PlayingCard *)card;
                if ([self.suit isEqualToString:otherCard.suit]) {
                    score += 1;
                } else if (self.rank == otherCard.rank) {
                    score += 4;
                }
            }
        }
    }
    
    if (numOtherCards > 1) {
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numOtherCards - 1)]];
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count]-1;
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
