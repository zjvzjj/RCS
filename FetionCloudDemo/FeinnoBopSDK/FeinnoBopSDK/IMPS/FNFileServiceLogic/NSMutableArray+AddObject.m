//
//  NSMutableArray+AddObject.m
//  FeinnoBopSDK
//
//  Created by yiqingping on 15/11/8.
//  Copyright © 2015年 Feinno. All rights reserved.
//

#import "NSMutableArray+AddObject.h"

@implementation NSMutableArray (AddObject)

- (void)addObjectExceptSame:(id)anObject
{
   if(![self containsObject:anObject])
   {
       [self addObject:anObject];
   }
}
@end
