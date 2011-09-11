//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Ishaan Gandhi on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalculatorViewController : UIViewController 
{
    BOOL orientation;
    
    //Calculator Values
    BOOL userIsInTheMiddleOfTypingANumber;    
    double operand;
    double waitingOperand;
    NSString *waitingOperation;
    
    //Interface
    IBOutlet UILabel *screen;
    IBOutlet UILabel *landScreen;
    
    IBOutlet UIImageView *screenImage;
    IBOutlet UIImageView *landScreenImage;
    
    IBOutlet UILabel *errorField;
    IBOutlet UILabel *landErrorField;
    
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIImageView *landBackgroundImage;
     
    IBOutlet UIView *port;
    IBOutlet UIView *land;
}

@property BOOL orientation;

-(IBAction)AC;
-(IBAction)digitPressed:(UIButton *)sender;
-(IBAction)operationPressed:(UIButton *)sender;
-(IBAction)plusOrMinusPressed:(UIButton *)sender;
-(IBAction)pointPressed;

@end