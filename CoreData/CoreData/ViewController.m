//
//  ViewController.m
//  CoreData
//
//  Created by R_flava_Man on 16/2/15.
//  Copyright © 2016年 R_style_Man. All rights reserved.
//

#import "ViewController.h"
#import "JSONKit.h"
#import "AppDelegate.h"
#import "Answer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSManagedObjectContext *context = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    //创建请求对象，用于获取实体Book所对应的全部数据，可以通过给NSFetchRequest设置predicate和sortDescriptors对结果进行筛选和排序。
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Answer"];
    NSArray *result = [context executeFetchRequest:fetchRequest error:nil];
    
    if (result.count == 0) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"answer" ofType:@"txt"];
        
        NSError *error = nil;
        
        NSString *dataString = [[NSString alloc] initWithContentsOfFile:path usedEncoding:nil error:&error];
        
        NSString *noWhiteSpaceString = [dataString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSMutableArray *itemArr = [NSMutableArray arrayWithArray:[noWhiteSpaceString componentsSeparatedByString:@"},"]];
        
        NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:itemArr.count];
        
        for (NSString *obj in itemArr) {
            NSString *temStr = [(NSString *)obj stringByReplacingOccurrencesOfString:@"{" withString:@""];
            temStr = [temStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            temStr = [temStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            temStr = [temStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            NSArray *tempArr = [temStr componentsSeparatedByString:@","];
            if (tempArr.count==2) {
                NSDictionary *temDict = @{@"m4a":tempArr[0],@"name":tempArr[1]};
                [dataArr addObject:temDict];
                
                //获取实体的描述
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"Answer" inManagedObjectContext:context];
                
                Answer *answer = (Answer *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
                answer.name = tempArr[1];
                answer.m4a = tempArr[0];
                answer.index = [itemArr indexOfObject:obj];
                
                [context save:&error];
            }
        }
        result = [context executeFetchRequest:fetchRequest error:nil];
    }
    
    NSMutableArray *characterArray = [NSMutableArray array];
    
    for (Answer *answer in result) {
        NSRange range;
        for(int i=0; i<answer.name.length; i+=range.length){
            range = [answer.name rangeOfComposedCharacterSequenceAtIndex:i];
            NSString *temps = [answer.name substringWithRange:range];
            if (![characterArray containsObject:temps]) {
                [characterArray addObject:temps];
            }
        }
        NSLog(@"%@ %zd %zd %@",answer.name, answer.unlock, answer.index, answer.m4a);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
