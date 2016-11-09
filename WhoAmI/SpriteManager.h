//
//  SpriteManager.h
//  WhoAmI
//
//  Created by 凌空 on 2016/11/8.
//  Copyright © 2016年 amoyio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpriteManager : NSObject
@property(nonatomic,copy) NSDictionary *spriteDict;
+(instancetype)shareManager;
- (NSArray *)generateListInCount:(NSUInteger)count;
@end
