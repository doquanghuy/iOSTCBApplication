//
//  Created by Backbase R&D B.V. on 08/05/2019.
//

#ifndef ProductsClient_BBBalanceValue_h
#define ProductsClient_BBBalanceValue_h

#import <CommonUtils/CommonUtils.h>

/// This class is a response/request class for a balance history item monetary value.
@interface BBBalanceValue : Additions

/// Currency
@property (strong, nonatomic, nonnull, readonly) NSString* currency;

/// Balance, nullable due to weak property, nonnull by the private getter.
@property (weak, nonatomic, nullable, readonly) NSDecimalNumber* balance;

/**
 * Initializes a new BBBalanceValue object
 * @param balance Balance.
 * @param currency CurrencyCode.
 * @return The initialized BBBalanceValue object.
 */
- (instancetype _Nonnull)initWithBalance:(nonnull NSDecimalNumber *)balance
                                currency:(nonnull NSString *)currency;

@end

#endif /* ProductsClient_BBBalanceValue_h */
