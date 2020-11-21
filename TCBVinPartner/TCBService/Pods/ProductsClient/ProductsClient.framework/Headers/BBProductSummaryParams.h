//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef BBProductSummaryParams_h
#define BBProductSummaryParams_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Request params class to be used when retrieving product summary.
@interface BBProductSummaryParams : Additions

/// Boolean. Whether the type of account is Debit account
@property (strong, nonatomic, readwrite, nullable) NSNumber *debitAccount;

/// Boolean. Whether the type of account is Credit account
@property (strong, nonatomic, readwrite, nullable) NSNumber *creditAccount;

/// Boolean. Masked/Unmasked card number
@property (strong, nonatomic, readwrite, nullable) NSNumber *maskIndicator;

/**
 * Creates a BBProductSummaryParams.
 * @param debitAccount Boolean. Whether the type of account is Debit account
 * @param creditAccount Boolean. Whether the type of account is Credit account
 * @param maskIndicator Boolean. Masked/Unmasked card number
 * @return The initialized BBProductSummaryParams object.
 */
- (nullable instancetype)initWithDebitAccount:(nullable NSNumber *)debitAccount
                                creditAccount:(nullable NSNumber *)creditAccount
                                maskIndicator:(nullable NSNumber *)maskIndicator;

@end

NS_ASSUME_NONNULL_END

#endif /* BBProductSummaryParams_h */
