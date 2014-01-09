//
//  CardNameViewController.m
//  Matchismo
//
//  Created by Tom Carter on 1/6/14.
//  Copyright (c) 2014 Louglu. All rights reserved.
//

#import "CardNameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardNameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong)CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet UILabel *turnDescription;
@end

@implementation CardNameViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:self.deck];
    }
    
    return _game;
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *button = [alert buttonTitleAtIndex:buttonIndex];
    if ([button isEqual: @"Deal"]) {
        [self startNewGame];
    } else {
        return;
    }
}

- (IBAction)deal:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deal cards?" message:@"Are you sure you want to deal? This will start a new game." delegate:self cancelButtonTitle:@"Don't deal" otherButtonTitles:@"Deal", nil];
    
    [alert show];
}

- (IBAction)TouchCardButton:(UIButton *)sender {
    self.modeSelector.enabled = NO;
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (IBAction)changeModeSelector:(UISegmentedControl *)sender {
    self.game.cardsInAMatch = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
}

- (Deck *)deck {
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    
    return _deck;
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle: [self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    NSString *description = @"";
    
    if (self.game) {
        if ([self.game.lastChosenCards count]) {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards) {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        
        if (self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Matched %@ for %d points", description, self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            description = [NSString stringWithFormat:@"%@ don't match! %d point penalty", description, -self.game.lastScore];
        }
    }
    
    self.turnDescription.text = description;
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"stanford"];
}

- (void)startNewGame {
    self.modeSelector.enabled = YES;
    self.game = nil;
    self.deck = nil;
    [self updateUI];
}

@end
