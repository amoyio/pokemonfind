//
//  SpriteManager.m
//  WhoAmI
//
//  Created by 凌空 on 2016/11/8.
//  Copyright © 2016年 amoyio. All rights reserved.
//

#import "SpriteManager.h"
@interface SpriteManager()

@end
@implementation SpriteManager
+(instancetype)shareManager{
    static SpriteManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SpriteManager alloc]init];
    });
    return instance;
}

-(NSDictionary *)spriteDict{
    if(!_spriteDict){
        
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"all_pokemon" ofType:@"json"];
            NSData *fileData = [NSData dataWithContentsOfFile:filePath];
            _spriteDict = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:nil];
        
    }
    
    return _spriteDict;
}

- (NSArray *)generateListInCount:(NSUInteger)count{
    NSMutableSet *spriteSet = [NSMutableSet set];
    do {
        NSString *randomIndex = [NSString stringWithFormat:@"%d",arc4random() % 150 + 1];
        
        [spriteSet addObject:@[randomIndex,self.spriteDict[randomIndex]]];
    } while (spriteSet.count < count);
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    for(id item in spriteSet){
        [result addObject:item];
    }
    return result;
}



@end
