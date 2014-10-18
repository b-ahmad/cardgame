//
//  CardGameViewController.m
//  StanfordCardGame
//
//  Created by Bilal Ahmad on 5/3/14.
//  Copyright (c) 2014 Bilal Ahmad. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong)CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISwitch *gameTypeSwitch;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic, strong)Deck *deck;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeSegControl;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusMsgLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentationControlM;
@property (readwrite, nonatomic) int gameType;
@end

@implementation CardGameViewController

- (IBAction)changeGameType:(id)sender {
    if (self.segmentationControlM.selectedSegmentIndex == 0) {
        self.gameType = 2;
    }else if (self.segmentationControlM.selectedSegmentIndex == 1)
    {
        self.gameType = 3;
    }
}


- (Deck *)createDeck
{
    self.gameType = 2;
    return [[PlayingCardDeck alloc] init];
}
- (IBAction)dealButton:(id)sender {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", 0];
    _game = nil;
    self.gameTypeSegControl.enabled = YES;
    [self updateUI];
}

- (Deck *)deck
{
    if(!_deck) {
        _deck = [self createDeck];
    }
    return _deck;
}

- (CardMatchingGame *)game
{
    if(!_game) {_game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];}
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    NSLog(@"game type : %d", self.gameType);
   
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex gameType:self.gameType];
    self.gameTypeSegControl.enabled = FALSE;
    [self updateUI];
    
}
-(NSString *)titleForCard:(Card *) card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"stanfor_blank" : @"stanford_back"];
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.statusMsgLabel.text = [NSString stringWithFormat:@"%@",self.game.statusMessage];
    }
}



@end
