//
//  FNMessageCollectionViewLoadMoreDelegate.h
//  FetionCloudDemo
//
//  Created by feinno on 15/12/28.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FNLoadMoreState)
{
    FNLoadMoreStatePull,
    FNLoadMoreStateRelease,
    FNLoadMoreStateLoading,
    FNLoadMoreStateFinish,
};

@class FNMessagesCollectionView;
@class FNMessagesCollectionViewFlowLayout;
@class FNMessagesCollectionViewCell;
@class FNMessagesLoadEarlierHeaderView;


@protocol FNMessageCollectionViewLoadMoreDelegate <NSObject>

- (void) collectionView:(FNMessagesCollectionView *)collectionView state:(FNRefreshState)state;

@end