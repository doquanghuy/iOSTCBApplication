//
//  Created by Backbase R&D B.V. on 23/07/2018.
//

#import <CommonUtils/CommonUtils.h>

#ifndef CategoryTotalsItem_h
#define CategoryTotalsItem_h

@interface CategoryTotalsItem : Additions

/// Transactions category
@property (nonatomic, strong, nonnull, readonly) NSString *category;

/// The total amount of the aggregated transactions by category
@property (nonatomic, strong, nonnull, readonly) BBCurrency *totalAmount;

/// Percentage value of the trend
@property (nonatomic, strong, nonnull, readonly) NSNumber *trend;

/// What percentage of the total amount for a given period is this amount
@property (nonatomic, strong, nonnull, readonly) NSNumber *portion;

@end

#endif
