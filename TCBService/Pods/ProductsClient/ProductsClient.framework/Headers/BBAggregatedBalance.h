//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBAggregatedBalance_h
#define ProductsClient_BBAggregatedBalance_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Defines a balance for groups of products.
@interface BBAggregatedBalance : Additions

/// The amount in the specified currency.
@property (nonatomic, weak, readonly, nullable) NSDecimalNumber *value;

/// The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount.
@property (nonatomic, strong, readonly, nullable) NSString *currency;

/**
 * Creates a BBAggregatedBalance.
 * @param value The amount in the specified currency.
 * @param currency The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount.
 * @return The initialized BBAggregatedBalance object.
 */
- (instancetype)initWithValue:(nullable NSDecimalNumber *)value currency:(nullable NSString *)currency;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBAggregatedBalance_h */
