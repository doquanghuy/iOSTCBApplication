//
//  Created by Backbase R&D B.V. on 08/05/2019.
//

#ifndef ProductsClient_BBArrangementWithBalanceHistory_h
#define ProductsClient_BBArrangementWithBalanceHistory_h

#import <CommonUtils/CommonUtils.h>
#import "BBBalanceHistoryItem.h"

NS_ASSUME_NONNULL_BEGIN

/// This class is a response class for a balance history details.
@interface BBArrangementWithBalanceHistory : Additions

/// A unique identifier for the Arrangement object that the Balance History belongs to.
@property (strong, nonatomic, nonnull, readonly) NSString* arrangementId;

@property (strong, nonatomic, nonnull, readonly) NSArray<BBBalanceHistoryItem*>* balanceHistory;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBArrangementWithBalanceHistory_h */
