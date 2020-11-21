//
//  Created by Backbase R&D B.V. on 08/05/2019.
//

#ifndef ProductsClient_BBArrangementsWithBalanceHistory_h
#define ProductsClient_BBArrangementsWithBalanceHistory_h

#import <CommonUtils/CommonUtils.h>
#import "BBArrangementWithBalanceHistory.h"

NS_ASSUME_NONNULL_BEGIN

/// This class is a response class for list of balance history items.
@interface BBArrangementsWithBalanceHistory : Additions

///Array of BalanceHistoryResponse items
@property (strong, nonatomic, nonnull, readonly) NSArray<__kindof BBArrangementWithBalanceHistory*>* items;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBArrangementsWithBalanceHistory_h */
