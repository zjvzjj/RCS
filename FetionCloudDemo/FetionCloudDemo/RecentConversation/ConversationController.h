//
//  ConversationController.h
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMessages.h"
#import "ConversationFacilitiesView.h"
#import "ConversationDataModel.h"

@interface ConversationController : FNMessagesViewController<KeyboardObserving>
{
    ConversationFacilitiesView *_facilitiesView;
}

@property (nonatomic, copy) NSString *toDisplayName;

@property (nonatomic, copy) NSString *toUserid;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, strong) ConversationDataModel *msgDataModel;

@property (nonatomic, assign) BOOL isCreated;

@property (nonatomic,copy) NSString* localNum;



@end
