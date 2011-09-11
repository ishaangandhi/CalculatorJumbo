//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Ishaan Gandhi on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
//#import "FBConnect.h"

static NSInteger imageNumber;

@implementation CalculatorViewController
@synthesize orientation;
//@synthesize facebook = _facebook;

- (void)dealloc {
    [errorField release];
    [waitingOperation release];
    [backgroundImage release];
    [super dealloc];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.view = port;
    }
    if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.view = land;
    }
    return YES;
}


-(void)changeImage:(NSInteger)image {
    imageNumber = image;
}

-(IBAction)AC {
    operand = 0;
    waitingOperand = 0;
    waitingOperation = nil;
    userIsInTheMiddleOfTypingANumber = NO;
    [screen setText:@"0"];
    [errorField setText:@""];
    [landScreen setText:@"0"];
    [landErrorField setText:@""];
}

-(IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [[sender titleLabel] text];
    [errorField setText:@""];
    [landErrorField setText:@""];
    if([[screen text] length] > 14) {
        [errorField setText:@"Maximum digits on screen"];
        [landErrorField setText:@"Maximum digits on screen"];
    }
    else {
        if (userIsInTheMiddleOfTypingANumber && [screen text] != @"0") {
            [screen setText:[[screen text] stringByAppendingString:digit]];
            [landScreen setText:[[landScreen text] stringByAppendingString:digit]];        
        }
        else {        
            if ([digit isEqualToString:@"00"])
                return;
            NSLog(@"%@", digit);
            
            [screen setText:digit];
            [landScreen setText:digit];
            userIsInTheMiddleOfTypingANumber = YES;
            
        }
    }
}

-(IBAction)plusOrMinusPressed:(UIButton *)sender {
    NSString *firstDigit = [screen.text substringWithRange:NSMakeRange(0, 1)];
    if([firstDigit isEqualToString:@"-"]){
        [screen setText:[screen.text substringFromIndex:1]];
    }
    else {
        [screen setText:[@"-" stringByAppendingString:screen.text]];
    }
        
}

-(IBAction)operationPressed:(UIButton *)sender {
    [errorField setText:@""];
    [landErrorField setText:@""];
    if (userIsInTheMiddleOfTypingANumber) {
        operand = [[screen text] doubleValue];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    
    NSString *operation = [[sender titleLabel] text];
   
    if([waitingOperation isEqual:@"+"]) {
        operand = waitingOperand + operand;
    }
    if([waitingOperation isEqual:@"-"]) {
        operand = waitingOperand - operand;
    }
    if([waitingOperation isEqual:@"*"]) {
        operand = waitingOperand * operand;
    }
    if([waitingOperation isEqual:@"/"]) {
        if (operand) {
            operand = waitingOperand / operand;
        } else {
            [errorField setText:@"Error: Cannot divide by 0"];
            [landErrorField setText:@"Error: Cannot divide by 0"];
        }
    }
    waitingOperation = operation;
    waitingOperand = operand;
    
    NSNumber* result = [NSNumber numberWithDouble:operand];
    
    NSNumberFormatter *fmtr = [[NSNumberFormatter alloc] init];
    [fmtr setNumberStyle:NSNumberFormatterDecimalStyle];
    [fmtr setMaximumFractionDigits:20];
    [fmtr setMaximumIntegerDigits:20];
    [fmtr setUsesGroupingSeparator:NO];
    
    [screen setText:[fmtr stringFromNumber:result]];
    [landScreen setText:[fmtr stringFromNumber:result]];
    [fmtr release];
}

-(IBAction)pointPressed {
    if(userIsInTheMiddleOfTypingANumber) {
        NSString *screenText = [screen text];
        BOOL points = NO;
        for (int i = 0; i < [screenText length]; i++) {
            if ([screenText characterAtIndex:i] == '.') {
                points = YES;
            }
        }
        if (points) {
            [errorField setText:@"Error: Decimal point already in operand"];
            [landErrorField setText:@"Error: Decimal point already in operand"];
        }
        else {
            [screen setText:[screenText stringByAppendingString:@"."]];
            [landScreen setText:[screenText stringByAppendingString:@"."]];
        }
    }
    else {
        [screen setText:@"0."];
        [landScreen setText:@"0."];
        userIsInTheMiddleOfTypingANumber = YES;
    }
}


@end