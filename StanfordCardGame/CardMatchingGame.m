//
//  CardMatchingGame.m
//  StanfordCardGame
//
//  Created by Bilal Ahmad on 10/15/14.
//  Copyright (c) 2014 Bilal Ahmad. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of cards
@property (nonatomic, readwrite) BOOL nasirsVariable;
@property (nonatomic, readwrite) BOOL threeCardsChosen;
@property (nonatomic, readwrite) BOOL threeCardsMatched;
@end


@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) {_cards = [[NSMutableArray alloc] init];}
    return _cards;
    
}


- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck
{
    self = [super init];
    if(self) {
        for(int i=0; i<count;i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
        
    }
    self.nasirsVariable = FALSE;
    self.threeCardsChosen = FALSE;
    return self;
}

- (int) chosenCardsCount {
    int chosenCards = 0;
    for (Card *otherCard in self.cards) {
        if(otherCard.chosen && !otherCard.matched) {
            chosenCards++;
        }
    }
    return chosenCards;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count] ? self.cards[index] : nil);
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

static const int MATCH_BONUS_3_CARDS = 3;


- (void) chooseCardAtIndexThreeCards:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (card.isMatched) {
        return;
    }
    
    if(card.isChosen) {
        //card was already chosen, flipping it back (back side up)
        card.chosen = NO;
    } else {
        int matchScore = 0;
        //match against other chosen cards
        for (Card *otherCard in self.cards) {
            if(otherCard.isChosen && !otherCard.isMatched) {
                matchScore = [card match:@[otherCard]];
                if (matchScore) {
                    NSLog(@"match score granted");
                    self.score += matchScore * MATCH_BONUS;
                    self.threeCardsMatched = TRUE;
                } else {
                    self.score -= MISMATCH_PENALTY;
                }
            }
            
        }
        card.chosen = YES;
        self.score -= COST_TO_CHOOSE;
        if([self chosenCardsCount] > 2) {//with match'em or flip 'em
            NSLog(@"3 cards chosen");
            
            if(self.threeCardsMatched) {
                NSLog(@"3 cards matched");
                self.threeCardsMatched = FALSE;
                for (Card *otherCard in self.cards) {
                    if(otherCard.isChosen && !otherCard.isMatched) {
                        otherCard.matched = YES;
                    }
                }
            } else {
                NSLog(@"3 cards did not match");
                for (Card *otherCard in self.cards) {
                    if(otherCard.isChosen && !otherCard.isMatched) {
                        otherCard.chosen = NO;
                    }
                }
            }
        }
        
    }
}

- (void) chooseCardAtIndex:(NSUInteger)index gameType:(int)game
{
    if (game == 2) {
        [self chooseCardAtIndexTwoCards:index];
    }else if (game == 3) {
        [self chooseCardAtIndexThreeCards:index];
    }

}



- (void) chooseCardAtIndexTwoCards:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched) {
        if(card.isChosen) {
            //card was already chosen, flipping it back (back side up)
            card.chosen = NO;
        } else {
            if(self.nasirsVariable) {
                for (Card *otherCard in self.cards) {
                    if(!otherCard.matched) {
                        otherCard.chosen = NO;}
                }
                self.nasirsVariable = FALSE;
            }
            
            
            int flipThisCard = 0;
            int matchScore = 0;
            //match against other chosen cards
            for (Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched) {
                    
                    
                    matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        //otherCard.chosen = NO;
                    }
                    if(matchScore == 0) {// cards did not match
                        flipThisCard = 1;
                        self.nasirsVariable = TRUE;
                        //otherCard.chosen = NO;
                    }
                    break;//can only choose two cards for now
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            
        }
    }
}

@end
