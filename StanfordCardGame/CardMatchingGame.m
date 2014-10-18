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
@property (nonatomic, readwrite) NSInteger chosenCardsCount;
@property (nonatomic, readwrite) BOOL nasirsVariable;
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
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count] ? self.cards[index] : nil);
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;




- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched) {
        if(card.isChosen) {
            //card was already chosen, flipping it back (back side up)
            card.chosen = NO;
            self.chosenCardsCount--;
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
                        self.chosenCardsCount--;
                        self.chosenCardsCount--;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        //otherCard.chosen = NO;
                        self.chosenCardsCount++;
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
            self.chosenCardsCount++;
            NSLog([NSString stringWithFormat:@"chosen cards count: %d", self.chosenCardsCount]);
            
        }
    }
}

@end
