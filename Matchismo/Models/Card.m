//
//  Card.m
//  Matchismo
//
//  Created by Tom Carter on 1/6/14.
//  Copyright (c) 2014 Louglu. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
