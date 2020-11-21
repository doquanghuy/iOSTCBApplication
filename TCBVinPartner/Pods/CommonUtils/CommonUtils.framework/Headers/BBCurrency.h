//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef BBCurrency_h
#define BBCurrency_h

#import <CommonUtils/Additions.h>

NS_ASSUME_NONNULL_BEGIN

/// Currency class that is used in clients to indicate monetary amount details.
@interface BBCurrency : Additions

/// The amount in the specified currency.
@property (nonatomic, weak, readonly) NSDecimalNumber *amount;

/// The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount.
@property (nonatomic, strong, readonly) NSString *currencyCode;


/**
 * Creates a BBCurrency.
 * @param amount The amount in the specified currency.
 * @param currencyCode The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount.
 * @return The initialized BBCurrency object.
 */
- (instancetype)initWithAmount:(NSDecimalNumber *)amount currencyCode:(NSString *)currencyCode;

@end

NS_ASSUME_NONNULL_END

#endif
