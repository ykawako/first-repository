//
//  ViewController.h
//  Weather
//
//  Created by ykawako on 2013/07/10.
//  Copyright (c) 2013年 ykawako. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIApplicationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage1;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage2;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage3;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage4;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage5;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage6;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage7;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;

@property (weak, nonatomic) IBOutlet UILabel *weather1;
@property (weak, nonatomic) IBOutlet UILabel *weather2;
@property (weak, nonatomic) IBOutlet UILabel *weather3;
@property (weak, nonatomic) IBOutlet UILabel *weather4;
@property (weak, nonatomic) IBOutlet UILabel *weather5;
@property (weak, nonatomic) IBOutlet UILabel *weather6;
@property (weak, nonatomic) IBOutlet UILabel *weather7;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;
- (IBAction)rightBtn:(id)sender;
- (IBAction)leftBtn:(id)sender;
- (IBAction)upBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *whererLabel;
@property (nonatomic) NSString *weatherUrl;
@property (nonatomic) NSArray *weatherString;
@property (nonatomic) NSArray *weatherIcon;
@property (nonatomic) NSString* result;
@property (nonatomic) int http ;

@end
