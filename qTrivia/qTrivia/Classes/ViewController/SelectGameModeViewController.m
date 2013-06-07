//
//  SelectGameModeViewController.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/30/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "SelectGameModeViewController.h"
#import "TriviaViewController.h"

@interface SelectGameModeViewController ()

@end

@implementation SelectGameModeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)gameModeButtonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    switch (button.tag) {
        case 100:
            gameModePicked = 0;
            break;
        case 101:
            gameModePicked = 1;
            break;
            
        case 102:
            gameModePicked = 2;
            break;
        default:
            break;
    }
    
    [self performSegueWithIdentifier:@"goToTrivaVC" sender:self];
}
- (IBAction)didPressedBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TriviaViewController *controller = segue.destinationViewController;
    controller.gameMode = gameModePicked;
    controller.categoryDictionary = self.dictionary;
}

@end
