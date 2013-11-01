//
//  HomeViewController.h
//  RCHBackboard
//
//  Created by Robin Hayward on 01/11/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import "RCHViewController.h"

@interface HomeViewController : RCHViewController

@property (strong, nonatomic) RCHBackBoard *topBackboard;
@property (strong, nonatomic) RCHBackBoard *leftBackboard;
@property (strong, nonatomic) RCHBackBoard *rightBackboard;
@property (strong, nonatomic) RCHBackBoard *bottomBackboard;

@property (strong, nonatomic) IBOutlet UIButton *button;

- (IBAction)topButtonAction:(id)sender;
- (IBAction)leftButtonAction:(id)sender;
- (IBAction)rightButtonAction:(id)sender;
- (IBAction)bottomButtonAction:(id)sender;

@end
