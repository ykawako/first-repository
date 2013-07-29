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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

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
    
    



    //////////天気予報//////////

    
    //ヤフー天気予報のソースコードを変数に入れる(鳥取東部）
    NSString* address = @"http://weather.yahoo.co.jp/weather/jp/31/6910.html";
    NSURL* url = [NSURL URLWithString:address];
    NSURLRequest* request = [NSURLRequest
                            requestWithURL:url];
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection
                    sendSynchronousRequest:request
                    returningResponse:&response
                    error:&error];
    NSString* result = [[NSString alloc]
                        initWithData:data
                        encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",result);
    
    //落としたソースコードから文字列を検索
    
    //今日まで飛ぶ
    NSString *str = result;
    NSRange resultRange = [str rangeOfString:@"class=\"yjw_table\">"];
    int tenkiVal1 = resultRange.location+resultRange.length;
    if (resultRange.location == NSNotFound) {
        printf("見つかりません");
    } 

    //天気１    
    NSString *kyo = [result substringFromIndex:tenkiVal1];
    NSRange kyoRange = [kyo rangeOfString:@"alt=\""];
    int tenkiVal2 = kyoRange.location + kyoRange.length;
    if(kyoRange.location == NSNotFound){
        printf("見つかりません");
    }else{

        NSString *kyotenki = [kyo substringWithRange: NSMakeRange(tenkiVal2, 4)];
        NSString *kyotenki2 = kyotenki;
        NSString* replace1 = [kyotenki2 stringByReplacingOccurrencesOfString:
                        @"\"" withString:@"" ];
        NSString* tenki1 = [replace1 stringByReplacingOccurrencesOfString:
                              @">" withString:@"" ];

        _weather1.text = tenki1;
        
        

    }


    //明日まで飛ぶ
    NSString *asu = [result substringFromIndex:tenkiVal1 + tenkiVal2];
    NSRange asuRange = [asu rangeOfString:@"<h2 class=\"yjMt\">明日の天気"];
    int tenkiVal3 = asuRange.location + asuRange.length;
    if(asuRange.location == NSNotFound){
        printf("見つかりません");
    }
    
    //天気２    
    NSString *asita = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3];
    NSRange asitaRange = [asita rangeOfString:@"alt=\""];
    int tenkiVal4 = asitaRange.location + asitaRange.length;
    if(asitaRange.location == NSNotFound){
        printf("見つかりません");
    }else{

             NSString *asitatenki = [asita substringWithRange: NSMakeRange(tenkiVal4, 4)];
        NSString *asitatenki2 = asitatenki;
        NSString* replace2 = [asitatenki2 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* asitanotenki = [replace2 stringByReplacingOccurrencesOfString:
                            @">" withString:@"" ];
        _weather2.text = asitanotenki;
    }


    //週間の所まで飛ぶ
    NSString *syukan = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4];
    NSRange syukanRange = [syukan rangeOfString:@"<small>天気"];
    int tenkiVal5 = syukanRange.location + syukanRange.length;
    if(syukanRange.location == NSNotFound){
        printf("見つかりません");
    }else{

        NSString *kyuke = [syukan substringWithRange: NSMakeRange(tenkiVal5, 4)];
    
    }
    
        //天気３
    NSString *syukan3 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5];
    NSRange syukan3Range = [syukan3 rangeOfString:@"alt=\""];
    int tenkiVal6 = syukan3Range.location + syukan3Range.length;
    if(syukan3Range.location == NSNotFound){
        printf("見つかりません");
    }else{
        
        NSString *tenki3 = [syukan3 substringWithRange: NSMakeRange(tenkiVal6, 4)];
        NSString *otenki3 = tenki3;
        NSString* replace3 = [otenki3 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* tenkino3 = [replace3 stringByReplacingOccurrencesOfString:
                                  @">" withString:@"" ];
        _weather3.text = tenkino3;
        
    }
    
    
    //天気４
    NSString *syukan4 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 +tenkiVal6];
    NSRange syukan4Range = [syukan4 rangeOfString:@"alt=\""];
    int tenkiVal7 = syukan4Range.location + syukan4Range.length;
    if(syukan4Range.location == NSNotFound){
        printf("見つかりません");
    }else{
        
        NSString *tenki4 = [syukan4 substringWithRange: NSMakeRange(tenkiVal7, 4)];
        
        NSString *otenki4 = tenki4;
        NSString* replace4 = [otenki4 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* tenkino4 = [replace4 stringByReplacingOccurrencesOfString:
                              @">" withString:@"" ];
        _weather4.text = tenkino4;
    }
   
    //天気５
    NSString *syukan5 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 + tenkiVal6 + tenkiVal7];
    NSRange syukan5Range = [syukan5 rangeOfString:@"alt=\""];
    int tenkiVal8 = syukan5Range.location + syukan5Range.length;
    if(syukan5Range.location == NSNotFound){
        printf("見つかりません");
    }else{
        
        NSString *tenki5 = [syukan5 substringWithRange: NSMakeRange(tenkiVal8, 4)];
        
        NSString *otenki5 = tenki5;
        NSString* replace5 = [otenki5 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* tenkino5 = [replace5 stringByReplacingOccurrencesOfString:
                              @">" withString:@"" ];
        _weather5.text = tenkino5;
    }
    
    
    //天気６
    NSString *syukan6 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 + tenkiVal6 + tenkiVal7 + tenkiVal8];
    NSRange syukan6Range = [syukan6 rangeOfString:@"alt=\""];
    int tenkiVal9 = syukan6Range.location + syukan6Range.length;
    if(syukan6Range.location == NSNotFound){
        printf("見つかりません");
    }else{

        NSString *tenki6 = [syukan6 substringWithRange: NSMakeRange(tenkiVal9, 4)];
        
        NSString *otenki6 = tenki6;
        NSString* replace6 = [otenki6 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* tenkino6 = [replace6 stringByReplacingOccurrencesOfString:
                              @">" withString:@"" ];
        _weather6.text = tenkino6;
        
    }

    //天気７
    NSString *syukan7 = [result substringFromIndex:tenkiVal1 + tenkiVal2 + tenkiVal3 + tenkiVal4 + tenkiVal5 + tenkiVal6 + tenkiVal7 + tenkiVal8 + tenkiVal9];
    NSRange syukan7Range = [syukan7 rangeOfString:@"alt=\""];
    int tenkiVal10 = syukan7Range.location + syukan7Range.length;
    if(syukan7Range.location == NSNotFound){
        printf("見つかりません");
    }else{
    

        NSString *tenki7 = [syukan7 substringWithRange: NSMakeRange(tenkiVal10, 4)];
         
        NSString *otenki7 = tenki7;
        NSString* replace7 = [otenki7 stringByReplacingOccurrencesOfString:
                              @"\"" withString:@"" ];
        NSString* tenkino7 = [replace7 stringByReplacingOccurrencesOfString:
                              @">" withString:@"" ];
        _weather7.text = tenkino7;
        
    }
    
    
}


@end