//
//  PlayingCard.h
//  Matchismo
//
//  Created by Tom Carter on 1/6/14.
//  Copyright (c) 2014 Louglu. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
