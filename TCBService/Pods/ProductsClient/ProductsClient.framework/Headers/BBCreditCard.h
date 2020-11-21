//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBCreditCard_h
#define ProductsClient_BBCreditCard_h

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/BBBaseProduct.h>

NS_ASSUME_NONNULL_BEGIN

/// Credit card product.
@interface BBCreditCard : BBBaseProduct

/// Booked balance, applicable to credit cards, loans, current and saving accounts.
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *bookedBalance;

/// Currency code.
@property (strong, nonatomic, readonly, nullable) NSString *currency;

/// Accrued interest, applicable to saving accounts and term deposits.
@property (strong, nonatomic, readonly, nullable) NSNumber *accruedInterest;

/// Available balance of the account.
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *availableBalance;

/// Credit limit, applicable to credit cards and current accounts.
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *creditLimit;

/// The number of the account the credit card transactions settle on (so actually the reference to the settlement account of the card).
@property (strong, nonatomic, readonly, nullable) NSString *creditCardAccountNumber;

/// The interest rate or rates which would be used for a particular arrangement.
@property (strong, nonatomic, readonly, nullable) NSNumber *applicableInterestRate;

/// Remaining credit.
@property (strong, nonatomic, readonly, nullable) NSNumber *remainingCredit;

/// Outstanding payment.
@property (strong, nonatomic, readonly, nullable) NSNumber *outstandingPayment;

/// The minimum payment set a percentage of balance, or a fixed cash amount.
@property (strong, nonatomic, readonly, nullable) NSNumber *minimumPayment;

/// Minimum Payment Due Date shown on your monthly statement to remain in good standing.
@property (strong, nonatomic, readonly, nullable) NSString *minimumPaymentDueDate;

/// Monetary amount of the used overdraft.
@property (strong, nonatomic, readonly, nullable) NSNumber *creditLimitUsage;

/// Overdraft Interest is an interest applied to the account for any time throughout the month when the account is overdrawn.
@property (strong, nonatomic, readonly, nullable) NSNumber *creditLimitInterestRate;

/// Whether this product allows urgent transfers. Type: Boolean
@property (assign, nonatomic, readonly) BOOL urgentTransferAllowed;

/// The annualized cost of credit or debt-capital computed as the percentage ratio of interest to the principal.
@property (strong, nonatomic, readonly, nullable) NSNumber *accountInterestRate;

/// Name of the account holder.
@property (strong, nonatomic, readonly, nullable) NSString *accountHolderNames;

/// First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked.
/// Be aware that using card number differently is potential PCI risk.
@property (strong, nonatomic, readonly, nullable) NSString *number;

/// Credit card number.
@property (strong, nonatomic, readonly, nullable) NSNumber *cardNumber;

/// Expiration date of a credit card, after which is no longer valid.
@property (strong, nonatomic, readonly, nullable) NSString *validThru;

/**
 * Convenience method that converts validThru property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the validThru object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for validThru.
 */
-(nullable NSDate*)validThru:(nullable NSString*)dateFormat;

/**
 * Convenience method that converts minimumPaymentDueDate property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the minimumPaymentDueDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for minimumPaymentDueDate.
 */
-(nullable NSDate*)minimumPaymentDueDate:(nullable NSString*)dateFormat;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBCreditCard_h */
