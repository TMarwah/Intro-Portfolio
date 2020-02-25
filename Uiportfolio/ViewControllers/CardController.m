//
//  CardController.m
//  Uiportfolio
//
//  Created by John Mortensen on 2/9/20.
//  Copyright © 2020 JM. All rights reserved.
//

#import "CardController.h"
//#define CARDLOGGING      // enable for NSLog

@implementation CardController

@synthesize firstPoint, lastPoint;
@synthesize computerDeck, computerWarPlay, computerWins1, computerWins2, computerDeckCnt, computerDeckWinsCnt;
@synthesize playerDeck, playerWarPlay, playerWins1, playerWins2, playerDeckCnt, playerDeckWinsCnt;
@synthesize gameMarquee, gameOver;

// Game State Message correspond to GAME_STATE enums
static NSString *gameStateMsgs[]=
    {@"...... Tap on screen to start your own game of war ......",
     @"...... Tap on screen to play your card in War zone ......",
     @".... Tap on screen to play computer card in War zone ....",
     @"...... Tap on screen to evaluate cards in War zone ......",
     @".............. Tap on screen to play again ..............."
    };

// Game State modes,main actions of game
typedef enum {START, PLAYER, COMPUTER, EVAL, END} GAME_STATE;
static GAME_STATE gameState;

// Game Play modes
typedef enum {AUTONOMOUS, MANUAL}  GAME_MODE;
static GAME_MODE gameMode;

/**
* Prepare for the game, start a fun demo screen
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // game starts in DEMO mode
    gameMode = AUTONOMOUS;
    gameState = START;
    //[self buildHands];
    
    // autonomous game timer (preview)
    self.autonomousTimer = [NSTimer scheduledTimerWithTimeInterval:.50 target:self selector:@selector(gameControl) userInfo:nil repeats:YES];
    // marquee message
     self.marqueeTimer = [NSTimer scheduledTimerWithTimeInterval:.10 target:self selector:@selector(marqueeMessage) userInfo:nil repeats:YES];
}

/**
* Finite state automonen, game is in progress,  user is controlling play, state machine helps with transitons
*/
-(void)gameControl {

    switch (gameState) {
            
        case START:
        case END:       // End is a replay with different prompt
            // Start Play mode
            gameOver.alpha = 0;
            //if(player deck is larger than computer deck then print
            if (playerDeckWinsCnt.text.integerValue > computerDeckWinsCnt.text.integerValue) {
                gameOver.text = [NSString stringWithFormat:@"Congrats! You Win!"];
            }
            else {
                gameOver.text = [NSString stringWithFormat:@"Gameover, You Lost!"];
            }
            [self buildHands];          // build deck, computer and player hands
            [self setupTable];
            gameState = PLAYER;
            break;
            
        case PLAYER:
            [self playerCard];
            gameState = COMPUTER;
            break;
            
        case COMPUTER:
            [self computerCard];
            gameState = EVAL;
            break;
            
        case EVAL:
            // Eval Cards returns true if game reaches END state
            if ( [self evalCards] ) {
                gameState = END;
                gameOver.alpha = 1;
            } else {
                gameState = PLAYER;
            }
            break;
    }
    // Every MANUAL state changes message
    // [self gameStateMsg];
}

/**
* The method touchesBegan initiates GAME_STATE transitions
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
#ifdef CARDLOGGING
    NSLog(@"touchesBegan state: %d", gameState);
#endif
    
    // turn user interaction off as swipe begins
    [self.view setUserInteractionEnabled:NO];

    // Play Game manually
    if (gameMode  == AUTONOMOUS)
    {
        [self.autonomousTimer invalidate];
        [self.marqueeTimer invalidate];
        gameMode = MANUAL;
        gameState = START;
    }
    // Play click through gameControl
    [self gameControl];
    gameMarquee.hidden = TRUE;
 }

/**
* Only used to reenable user interaction.
*/
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
#ifdef CARDLOGGING
    NSLog(@"touchesEnded state: %d", gameState);
#endif
    
    [self.view setUserInteractionEnabled:YES];
}

/**
* Scrolling message provides instruction how to transition from Demo to Playing game
*/
-(void)gameStateMsg {
 
    if (gameMode == MANUAL)
    {
        // Message set for Manual only
        self.gameMarquee.textAlignment = NSTextAlignmentCenter;
        gameMarquee.text =  gameStateMsgs[gameState];
    }
    
}

/**
* Scrolling message provides instruction how to transition from Demo to Playing game
*/
-(void)marqueeMessage {
    static NSInteger start = 0;
    static NSInteger len = 0;
    static NSInteger len2;
        
    NSString *marqueeMsg = gameStateMsgs[START];
    if (len < marqueeMsg.length) {
        self.gameMarquee.textAlignment = NSTextAlignmentRight;
        gameMarquee.text =  [marqueeMsg substringWithRange:NSMakeRange(start, len++)];
        len2 = len;
    } else if (start < marqueeMsg.length){
        self.gameMarquee.textAlignment = NSTextAlignmentLeft;
        gameMarquee.text =  [marqueeMsg substringWithRange:NSMakeRange(++start, --len2)];
    } else {
        start = 0; len = 0;
    }
}

/**
* create hands and deal from master deck
*/
-(void)buildHands {
    // Setup unique hands for player nad computer
    freedeck(cards);            // free demo deck
    cards = createdeck();       // start new deck
    shuffledeck(cards);         // shuffle
    
    [self createHands];
    
    for (int cardIndex = 0, pIndex = 0, cIndex = 0; cardIndex < DECK_CNT; cardIndex++)
    {
        if ((cardIndex % 2)==0) {
            // pIndex is player hand index, cardIndex is dealer deck index
            card2handcp(&player[pIndex], cards[cardIndex]);  // give/copy card to player hand
            pIndex++;
        }
        else {
            // cIndex is computer hand index, cardIndex is dealer deck index
            card2handcp(&computer[cIndex], cards[cardIndex]);   // give/copy card to computer hand
            cIndex++;
        }
    }

#ifdef CARDLOGGING
    // Console validation code, only activitated by defining DARDLOGGING
    for (int i = 0; i < DECK_CNT; i++)
    {
        if (player[i].cID != -1)
            NSLog(@"player: %d %s, %d", player[i].cID, player[i].cImage, i);
    }
    
    NSLog(@"----");
    
    for (int i = 0; i < DECK_CNT; i++)
    {
        if (computer[i].cID != -1)
            NSLog(@"computer: %d %s, %d", computer[i].cID, computer[i].cImage, i);
    }
#endif
    
}

/**
* player pops card off deck
*/
-(void)playerCard {
    // static is initialized once, logic to assist
    static int counterPlayDeck = DECK_CNT/2;
    static GAME_MODE playState = AUTONOMOUS;
    if ( (gameMode != playState) || (counterPlayDeck <= 0) ) {
        playState = gameMode;
        counterPlayDeck = DECK_CNT/2;
    }
    
    --counterPlayDeck;
    // play player card in war zone
    NSString *pId = [NSString stringWithFormat:@"%s.png" , player[counterPlayDeck].cImage] ;
    [playerWarPlay setImage:[UIImage imageNamed:pId]];
    
    // move card to war zone
    card2handcp(&warZone[0], player[counterPlayDeck]);
    
    // remove card from player deck
    player[counterPlayDeck].cID = -1;
    
    // decrement player card counter
    playerDeckCnt.text = [NSString stringWithFormat:@"%d" , counterPlayDeck];
    
    if (counterPlayDeck == 0) {
        [playerDeck setImage:[UIImage imageNamed:@"empty.png"]];
    }
}

/**
* player pops card off deck
*/
-(void)computerCard {
    // static is initialized once, logic to assist
    static int counterPlayDeck = DECK_CNT/2;
    static GAME_MODE playState = AUTONOMOUS;
    if ( (gameMode != playState) || (counterPlayDeck <= 0) ) {
        playState = gameMode;
        counterPlayDeck = DECK_CNT/2;
    }
    
    --counterPlayDeck;
    // play player card in war zone
    NSString *pId = [NSString stringWithFormat:@"%s.png" , computer[counterPlayDeck].cImage] ;
    [computerWarPlay setImage:[UIImage imageNamed:pId]];
    
    // move card to war zone
    card2handcp(&warZone[1], computer[counterPlayDeck]);
    
    // remove card from player deck
    computer[counterPlayDeck].cID = -1;
    
    // decrement player card counter
    computerDeckCnt.text = [NSString stringWithFormat:@"%d" , counterPlayDeck];
    
    if (counterPlayDeck == 0) {
        [computerDeck setImage:[UIImage imageNamed:@"empty.png"]];
    }
}

/**
*  evaluate cards in War Zone
*/
-(Boolean)evalCards {
    static int playerCNT = 0;
    static int computerCNT = 0;
    static GAME_MODE playState = AUTONOMOUS;
    if ( (gameMode != playState) || ((playerCNT + computerCNT) >= DECK_CNT) ) {
        playState = gameMode;
        playerCNT = 0; computerCNT = 0;
    }
    
    // Test card values in war zone, increase value of Ace
    int playerValue = (warZone[0].symbol == Ace) ? SYMBOL_CNT : warZone[0].value;
    int computerValue = (warZone[1].symbol == Ace) ? SYMBOL_CNT : warZone[1].value;
    if ( playerValue >= computerValue )
    {
        // Player wins
        // Transfer update card 1
        card2handcp( &playerWins[playerCNT], warZone[0] );
        NSString *image1 = [NSString stringWithFormat:@"%s.png" , playerWins[playerCNT++].cImage] ;
        // Transfer update card 2
        card2handcp( &playerWins[playerCNT], warZone[1] );
        NSString *image2 = [NSString stringWithFormat:@"%s.png" , playerWins[playerCNT++].cImage] ;
        // Paint counter and cards to screen
        playerDeckWinsCnt.text = [NSString stringWithFormat:@"%d" , playerCNT];
        [playerWins1 setImage:[UIImage imageNamed:image1]];          // computer winnings
        [playerWins2 setImage:[UIImage imageNamed:image2]];
        
    } else {
        // Computer winns
        // Transfer update card 1
        card2handcp( &computerWins[computerCNT], warZone[0] );
        NSString *image1 = [NSString stringWithFormat:@"%s.png" , computerWins[computerCNT++].cImage] ;
        // Transfer update card 2
        card2handcp( &computerWins[computerCNT], warZone[1] );
        NSString *image2 = [NSString stringWithFormat:@"%s.png" , computerWins[computerCNT++].cImage] ;
        // Paint counter and cards to screen
        computerDeckWinsCnt.text = [NSString stringWithFormat:@"%d" , computerCNT];
        [computerWins1 setImage:[UIImage imageNamed:image1]];          // computer winnings
        [computerWins2 setImage:[UIImage imageNamed:image2]];

    }
    // Clear War Zone
    [playerWarPlay setImage:[UIImage imageNamed:@"empty.png"]];
    [computerWarPlay setImage:[UIImage imageNamed:@"empty.png"]];
    
    // Check for Game over
    return ((playerCNT + computerCNT) >= DECK_CNT);
}

/**
* free player and computer hands
*/
-(void)createHands {
    [self freeHands];
    player = createhand(DECK_CNT);
    playerWins = createhand(DECK_CNT);
    computer = createhand(DECK_CNT);
    computerWins = createhand(DECK_CNT);
    warZone = createhand(2);
}
/**
* free player and computer hands
*/
-(void)freeHands {
    freedeck(player);
    freedeck(playerWins);
    freedeck(computer);
    freedeck(computerWins);
    freedeck(warZone);
}

/**
* arrage table for new game
*/
-(void)setupTable {
    playerDeckCnt.text = [NSString stringWithFormat:@"%d" , DECK_CNT/2];
    playerDeckWinsCnt.text = [NSString stringWithFormat:@"%d", 0];
    computerDeckCnt.text = [NSString stringWithFormat:@"%d" , DECK_CNT/2];
    computerDeckWinsCnt.text = [NSString stringWithFormat:@"%d", 0];

    [computerDeck setImage:[UIImage imageNamed:@"cardback.png"]];
    [computerWarPlay setImage:[UIImage imageNamed:@"empty.png"]];
    [computerWins1 setImage:[UIImage imageNamed:@"empty.png"]];
    [computerWins2 setImage:[UIImage imageNamed:@"empty.png"]];

    [playerDeck setImage:[UIImage imageNamed:@"cardback.png"]];
    [playerWarPlay setImage:[UIImage imageNamed:@"empty.png"]];
    [playerWins1 setImage:[UIImage imageNamed:@"empty.png"]];
    [playerWins2 setImage:[UIImage imageNamed:@"empty.png"]];
}

@end
