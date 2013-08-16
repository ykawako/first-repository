//
//  ViewController.m
//  Weather
//
//  Created by ykawako on 2013/07/10.
//  Copyright (c) 2013年 ykawako. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize weatherUrl;
@synthesize weatherString;
@synthesize weatherIcon;
@synthesize result;
@synthesize http;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.


    //上へスワイプ
    UISwipeGestureRecognizer* swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpGesture:)];
    swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpGesture];

    // 左へスワイプ
    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeftGesture:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
//    [swipeLeftGesture release];
    // 右へスワイプ
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightGesture:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
//    [swipeRightGesture release];
    
    ///////日付を設定する////////
    // NsDate => NSString変換
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]]; // Localeの指定
    [df setDateFormat:@"MM/dd"];

    NSDate *now = [NSDate date];
    NSString *day1 = [df stringFromDate:now];
 
    // 日付を求める
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *comps1 = [[NSDateComponents alloc]init];
    comps1.day = 1;
    NSDate *result1 = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    NSString *day2 = [df stringFromDate:result1];
    comps1.day = 2;
    NSDate *result2 = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    NSString *day3 = [df stringFromDate:result2];
    comps1.day = 3;
    NSDate *result3 = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    NSString *day4 = [df stringFromDate:result3];
    comps1.day = 4;
    NSDate *result4 = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    NSString *day5 = [df stringFromDate:result4];
    comps1.day = 5;
    NSDate *result5 = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    NSString *day6 = [df stringFromDate:result5];
    comps1.day = 6;
    NSDate *result6 = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    NSString *day7 = [df stringFromDate:result6];

    //日付をラベルに出力
    _label1.text = day1;
    _label2.text = day2;
    _label3.text = day3;
    _label4.text = day4;
    _label5.text = day5;
    _label6.text = day6;
    _label7.text = day7;
    

     
/////////////////////日付設定ここまで////////////////////////



weatherString = [[NSArray alloc] initWithObjects:@"晴れ\">", @"雨\"><", @"曇り\">",@"弱雨\">", @"晴後雨\"", @"晴後曇\"",@"雨後晴\"", @"雨後曇\"", @"曇後晴\"",@"曇後雨\"", @"晴時々雨", @"晴時々曇",@"雨時々晴", @"雨時々曇", @"曇時々晴",@"曇時々雨", nil];
    
weatherIcon = [[NSArray alloc] initWithObjects:@"hare.png", @"ame.png", @"kumori.png",@"niwakaame.png", @"harenotiame.png", @"harenotikumori.png",@"amenotihare.png", @"amenotikumori.png", @"kumorinotihare.png",@"kumorinotiame.png", @"haretokiame.png", @"haretokikumori.png",@"ametokihare.png", @"ametokikumori.png", @"kumoritokihare.png",@"kumoritokiame", nil];
}


-(void)tottori{
    
    _whererLabel.text = @"鳥取";
    
    //ヤフー天気予報のソースコードを変数に入れる(鳥取東部）
    weatherUrl = @"http://weather.yahoo.co.jp/weather/jp/31/6910.html";
    
}

-(void)kurayoshi{
    _whererLabel.text = @"倉吉";
        //ヤフー天気予報のソースコードを変数に入れる(倉吉）
    weatherUrl = @"http://weather.yahoo.co.jp/weather/jp/31/6920/31203.html";


}

-(void)yonago{
    
    _whererLabel.text = @"米子";
    
    //ヤフー天気予報のソースコードを変数に入れる(米子）

    weatherUrl = @"http://weather.yahoo.co.jp/weather/jp/31/6920.html";
    
}



-(void)tenki{
    
    @try {

    NSString* address = weatherUrl;
    NSURL* url = [NSURL URLWithString:address];
    NSURLRequest* request = [NSURLRequest
                             requestWithURL:url];
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection
                    sendSynchronousRequest:request
                    returningResponse:&response
                    error:&error];
    result = [[NSString alloc]
                        initWithData:data
                        encoding:NSUTF8StringEncoding];


    //落としたソースコードから文字列を検索
    
    //今日まで飛ぶ
    NSString *str = result;
    NSRange resultRange = [str rangeOfString:@"今日明日の天気"];
    int tenkiVal1 = resultRange.location+resultRange.length;
    
    //天気１
    http++;
    NSLog(@"%@ %d", result,http);
    NSString *kyo = [result substringFromIndex:tenkiVal1];
    NSRange kyoRange = [kyo rangeOfString:@"alt=\""];
    int tenkiVal2 = kyoRange.location + kyoRange.length;
        
        NSString *kyotenki = [kyo substringWithRange: NSMakeRange(tenkiVal2, 4)];
        NSString *kyotenki2 = kyotenki;
        NSString* replace1 = [kyotenki2 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace1_1 = [replace1 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenki1 = [replace1_1 stringByReplacingOccurrencesOfString:
                            @"<" withString:@"" ];
        
        _weather1.text = tenki1;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([kyotenki isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage1.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
    
    
    //明日まで飛ぶ
    NSString *asu = [result substringFromIndex:tenkiVal1 + tenkiVal2];
    NSRange asuRange = [asu rangeOfString:@"\"date\">"];
    int tenkiVal3 = asuRange.location + asuRange.length;
    
    //天気２
    NSString *asita = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3];
    NSRange asitaRange = [asita rangeOfString:@"alt=\""];
    int tenkiVal4 = asitaRange.location + asitaRange.length;
        
        NSString *asitatenki = [asita substringWithRange: NSMakeRange(tenkiVal4, 4)];
        NSString *asitatenki2 = asitatenki;
        NSString* replace2 = [asitatenki2 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace2_2 = [replace2 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* asitanotenki = [replace2_2 stringByReplacingOccurrencesOfString:
                                  @"<" withString:@"" ];
        _weather2.text = asitanotenki;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([asitatenki isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage2.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
    
    
    //週間の所まで飛ぶ
    NSString *syukan = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4];
    NSRange syukanRange = [syukan rangeOfString:@"<small>天気"];
    int tenkiVal5 = syukanRange.location + syukanRange.length;
    
    //天気３
    NSString *syukan3 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5];
    NSRange syukan3Range = [syukan3 rangeOfString:@"alt=\""];
    int tenkiVal6 = syukan3Range.location + syukan3Range.length;
        
        NSString *tenki3 = [syukan3 substringWithRange: NSMakeRange(tenkiVal6, 4)];
        NSString *otenki3 = tenki3;
        NSString* replace3 = [otenki3 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace3_2 = [replace3 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenkino3 = [replace3_2 stringByReplacingOccurrencesOfString:
                              @"<" withString:@"" ];
        _weather3.text = tenkino3;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([tenki3 isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage3.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
    
    
    //天気４
    NSString *syukan4 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 +tenkiVal6];
    NSRange syukan4Range = [syukan4 rangeOfString:@"alt=\""];
    int tenkiVal7 = syukan4Range.location + syukan4Range.length;
        
        NSString *tenki4 = [syukan4 substringWithRange: NSMakeRange(tenkiVal7, 4)];
        
        NSString *otenki4 = tenki4;
        NSString* replace4 = [otenki4 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace4_2 = [replace4 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenkino4 = [replace4_2 stringByReplacingOccurrencesOfString:
                              @"<" withString:@"" ];
        _weather4.text = tenkino4;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([tenki4 isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage4.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
    
    //天気５
    NSString *syukan5 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 + tenkiVal6 + tenkiVal7];
    NSRange syukan5Range = [syukan5 rangeOfString:@"alt=\""];
    int tenkiVal8 = syukan5Range.location + syukan5Range.length;
        
        NSString *tenki5 = [syukan5 substringWithRange: NSMakeRange(tenkiVal8, 4)];
        
        NSString *otenki5 = tenki5;
        NSString* replace5 = [otenki5 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace5_2 = [replace5 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenkino5 = [replace5_2 stringByReplacingOccurrencesOfString:
                              @"<" withString:@"" ];
        _weather5.text = tenkino5;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([tenki5 isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage5.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
    
    
    //天気６
    NSString *syukan6 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 + tenkiVal6 + tenkiVal7 + tenkiVal8];
    NSRange syukan6Range = [syukan6 rangeOfString:@"alt=\""];
    int tenkiVal9 = syukan6Range.location + syukan6Range.length;
        
        NSString *tenki6 = [syukan6 substringWithRange: NSMakeRange(tenkiVal9, 4)];
        
        NSString *otenki6 = tenki6;
        NSString* replace6 = [otenki6 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace6_2 = [replace6 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenkino6 = [replace6_2 stringByReplacingOccurrencesOfString:
                              @"<" withString:@"" ];
        _weather6.text = tenkino6;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([tenki6 isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage6.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
        
    
    //天気７
    NSString *syukan7 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 + tenkiVal6 + tenkiVal7 + tenkiVal8 + tenkiVal9];
    NSRange syukan7Range = [syukan7 rangeOfString:@"alt=\""];
    int tenkiVal10 = syukan7Range.location + syukan7Range.length;
        
        NSString *tenki7 = [syukan7 substringWithRange: NSMakeRange(tenkiVal10, 4)];
        
        NSString *otenki7 = tenki7;
        NSString* replace7 = [otenki7 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace7_2 = [replace7 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenkino7 = [replace7_2 stringByReplacingOccurrencesOfString:
                              @"<" withString:@"" ];
        _weather7.text = tenkino7;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([tenki7 isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage7.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
        
    }
    @catch  (NSException *exception) {
        NSLog(@"例外名：%@", exception.name);
        NSLog(@"理由：%@", exception.reason);
    }
    
}



    -(void)tenki2{
        
        @try {

    NSString* address = weatherUrl;
    NSURL* url = [NSURL URLWithString:address];
    NSURLRequest* request = [NSURLRequest
                             requestWithURL:url];
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection
                    sendSynchronousRequest:request
                    returningResponse:&response
                    error:&error];
    result = [[NSString alloc]
                        initWithData:data
                        encoding:NSUTF8StringEncoding];
            
    //落としたソースコードから文字列を検索
    
    //今日まで飛ぶ
    NSString *str = result;
    NSRange resultRange = [str rangeOfString:@"<small>21時</small></td>"];
    int tenkiVal1 = resultRange.location+resultRange.length;
    
    //天気１
    
    NSString *kyo = [result substringFromIndex:tenkiVal1];
    NSRange kyoRange = [kyo rangeOfString:@"alt=\""];
    int tenkiVal2 = kyoRange.location + kyoRange.length;

        NSString *kyotenki = [kyo substringWithRange: NSMakeRange(tenkiVal2, 4)];
        NSString *kyotenki2 = kyotenki;
        NSString* replace1 = [kyotenki2 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace1_1 = [replace1 stringByReplacingOccurrencesOfString:
                            @">" withString:@"" ];
        NSString* tenki1 = [replace1_1 stringByReplacingOccurrencesOfString:
                            @"<" withString:@"" ];
        
        _weather1.text = tenki1;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([kyotenki isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage1.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
    
    
    //明日まで飛ぶ
    NSString *asu = [result substringFromIndex:tenkiVal1 + tenkiVal2];
    NSRange asuRange = [asu rangeOfString:@"<h3>明日の天気"];
    int tenkiVal3 = asuRange.location + asuRange.length;
    
    //天気２
    NSString *asita = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3];
    NSRange asitaRange = [asita rangeOfString:@"alt=\""];
    int tenkiVal4 = asitaRange.location + asitaRange.length;
        
        NSString *asitatenki = [asita substringWithRange: NSMakeRange(tenkiVal4, 4)];
        NSString *asitatenki2 = asitatenki;
        NSString* replace2 = [asitatenki2 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace2_2 = [replace2 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* asitanotenki = [replace2_2 stringByReplacingOccurrencesOfString:
                                  @"<" withString:@"" ];
        _weather2.text = asitanotenki;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([asitatenki isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage2.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
    
    
    //週間の所まで飛ぶ
    NSString *syukan = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4];
    NSRange syukanRange = [syukan rangeOfString:@"<small>天気"];
    int tenkiVal5 = syukanRange.location + syukanRange.length;
    
    //天気３
    NSString *syukan3 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5];
    NSRange syukan3Range = [syukan3 rangeOfString:@"alt=\""];
    int tenkiVal6 = syukan3Range.location + syukan3Range.length;
        
        NSString *tenki3 = [syukan3 substringWithRange: NSMakeRange(tenkiVal6, 4)];
        NSString *otenki3 = tenki3;
        NSString* replace3 = [otenki3 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace3_2 = [replace3 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenkino3 = [replace3_2 stringByReplacingOccurrencesOfString:
                              @"<" withString:@"" ];
        _weather3.text = tenkino3;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([tenki3 isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage3.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
    
    
    //天気４
    NSString *syukan4 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 +tenkiVal6];
    NSRange syukan4Range = [syukan4 rangeOfString:@"alt=\""];
    int tenkiVal7 = syukan4Range.location + syukan4Range.length;
        
        NSString *tenki4 = [syukan4 substringWithRange: NSMakeRange(tenkiVal7, 4)];
        
        NSString *otenki4 = tenki4;
        NSString* replace4 = [otenki4 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace4_2 = [replace4 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenkino4 = [replace4_2 stringByReplacingOccurrencesOfString:
                              @"<" withString:@"" ];
        _weather4.text = tenkino4;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([tenki4 isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage4.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
    
    //天気５
    NSString *syukan5 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 + tenkiVal6 + tenkiVal7];
    NSRange syukan5Range = [syukan5 rangeOfString:@"alt=\""];
    int tenkiVal8 = syukan5Range.location + syukan5Range.length;
        
        NSString *tenki5 = [syukan5 substringWithRange: NSMakeRange(tenkiVal8, 4)];
        
        NSString *otenki5 = tenki5;
        NSString* replace5 = [otenki5 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace5_2 = [replace5 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenkino5 = [replace5_2 stringByReplacingOccurrencesOfString:
                              @"<" withString:@"" ];
        _weather5.text = tenkino5;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([tenki5 isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage5.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
    
    
    //天気６
    NSString *syukan6 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 + tenkiVal6 + tenkiVal7 + tenkiVal8];
    NSRange syukan6Range = [syukan6 rangeOfString:@"alt=\""];
    int tenkiVal9 = syukan6Range.location + syukan6Range.length;
        
        NSString *tenki6 = [syukan6 substringWithRange: NSMakeRange(tenkiVal9, 4)];
        
        NSString *otenki6 = tenki6;
        NSString* replace6 = [otenki6 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace6_2 = [replace6 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenkino6 = [replace6_2 stringByReplacingOccurrencesOfString:
                              @"<" withString:@"" ];
        _weather6.text = tenkino6;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([tenki6 isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage6.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
        
    
    //天気７
    NSString *syukan7 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 + tenkiVal6 + tenkiVal7 + tenkiVal8 + tenkiVal9];
    NSRange syukan7Range = [syukan7 rangeOfString:@"alt=\""];
    int tenkiVal10 = syukan7Range.location + syukan7Range.length;
        
        NSString *tenki7 = [syukan7 substringWithRange: NSMakeRange(tenkiVal10, 4)];
        
        NSString *otenki7 = tenki7;
        NSString* replace7 = [otenki7 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* replace7_2 = [replace7 stringByReplacingOccurrencesOfString:
                                @">" withString:@"" ];
        NSString* tenkino7 = [replace7_2 stringByReplacingOccurrencesOfString:
                              @"<" withString:@"" ];
        _weather7.text = tenkino7;
        for(int i = 0; i <= [weatherString count]-1; i++){
            if([tenki7 isEqualToString:weatherString[i]]){
                NSString *iconImage = weatherIcon[i];
                _weatherImage7.image = [UIImage imageNamed:iconImage];
                break;
            }
        }
        
        }
        @catch  (NSException *exception) {
            NSLog(@"例外名：%@", exception.name);
            NSLog(@"理由：%@", exception.reason);
        }

}

- (void) handleSwipeLeftGesture:(UISwipeGestureRecognizer *)sender {
    [self tottori];
    [self tenki];
}
- (void) handleSwipeUpGesture:(UISwipeGestureRecognizer *)sender {
    [self kurayoshi];
    [self tenki2];
    
}
- (void) handleSwipeRightGesture:(UISwipeGestureRecognizer *)sender {
    [self yonago];
    [self tenki];
}



- (IBAction)leftBtn:(id)sender {
    [self yonago];
    [self tenki];
}

- (IBAction)upBtn:(id)sender {
    [self kurayoshi];
    [self tenki2];
}

- (IBAction)rightBtn:(id)sender {
    [self tottori];
    [self tenki];
}


@end