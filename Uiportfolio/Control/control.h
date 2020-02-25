//
//  Header.h
//  Projects
//
//  Created by John Mortensen on 9/21/19.
//  Copyright © 2019 Vo, Anthony. All rights reserved.
//


#ifndef portfolio_h
#define portfolio_h
// Classic C style defines for Operator control
#define BUFFER_SIZE 80
#define FILE_BUFFER_SIZE 1024
#define LINE_BUFFER_SIZE 256
//define new buffer for words to line
#define WORDS_TO_LINE_SIZE 64
// Math operations
#define PLUS 0
#define MINUS 1
#define MULTIPLY 2
#define DIVIDE 3
#define MODULO 4
#define SQRT 5
// Here is the structure that goes with it
// Tokenizing Helper Structure
typedef struct words {
  char word[BUFFER_SIZE];
  char reversed[BUFFER_SIZE];
  //char pigged[BUFFER_SIZE];
  //char shorted[BUFFER_SIZE];
} WORDS;
typedef struct phrases {
    char original[LINE_BUFFER_SIZE];
    char reversed[LINE_BUFFER_SIZE];
    WORDS words[WORDS_TO_LINE_SIZE];
    //char piglatin[LINE_BUFFER_SIZE];
    //char shorthand[LINE_BUFFER_SIZE];
    long wordcount;
} PHRASE;
// C Function Name and Line number
typedef struct candidatesFuncs {
    char name[LINE_BUFFER_SIZE];
    unsigned int functionStartLine;
} CANDIDATE_FUNCS;
CANDIDATE_FUNCS* fileParse(char *fn);

// Programming Languages Data Definition
typedef enum {JIT, JVM, ByteCode, Native} EXE_TYPE;
typedef enum {OOP, MP, Iterative} LANG_TYPE;
typedef struct type {
    char name[20];
    char yob[10];
    char creator[80];
    EXE_TYPE exetype;
    LANG_TYPE langtype;
} LANGUAGES;
LANGUAGES* progLanguages(void);
LANGUAGES* searchLanguages(char *searchTerm);

// Classic C style prototype for portfolio
int jumpers(char *message);
int histogram(char *message);
int zeroTest(double value);
double calculateIt(double arg1, int mathOp, double arg2);
double pyth (double side1, double side2);


char *reverse1(char* input, long length);
char *reverse2(char* input, long length);
char *reverse3(char* input);
char *reverse4(char* input, long length);

//void tokentest(void);
void cleancopy(char *dest, const char *source, long buffsize);
void tokentest(char *cInput);
char *reverser(char* cInput);

// cards
#define SUIT_CNT 4
#define SYMBOL_CNT 13
#define DECK_CNT 52
static char *colorStrings[] = {"Red", "Black"};
static char *suitStrings[] = {"Clubs", "Diamonds", "Hearts", "Spades"};
static char *symbolStrings[] = {"Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"};
typedef enum {Red, Black} COLOR_TYPE;
typedef enum {Clubs, Diamonds, Hearts, Spades} SUIT_TYPE;
typedef enum {Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King} SYMBOL_TYPE;
typedef struct card {
    int cID;                        // unique ID of card (1 to 52 on conventional deck)
    int value;                      // 1, 2, ... 13, used to determine rank in games
    COLOR_TYPE color;               // Red or Black
    SUIT_TYPE suit;                 // Clubs, Diamonds, Hearts, Spaces
    SYMBOL_TYPE symbol;             // Ace, Two, ... King
    char cImage[10];
} CARD;
CARD * createdeck(void);
void shuffledeck(CARD *c);
void dealdeck(CARD *c);
void freedeck(CARD *c);
CARD * createhand(int size);
void card2handcp(CARD *h, CARD c);
#endif /* portfolio_h */
