//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBCurrentAccount_h
#define ProductsClient_BBCurrentAccount_h

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/BBBaseProduct.h>

NS_ASSUME_NONNULL_BEGIN

/// Current account product.
@interface BBCurrentAccount : BBBaseProduct

/// Specifying the IBAN of the account.
@property (strong, nonatomic, readonly, nullable) NSString *IBAN;

/// Specifying the BBAN of the account.
@property (strong, nonatomic, readonly, nullable) NSString *BBAN;

/// Bank Identifier Code - international bank code that identifies particular banks worldwide.
@property (strong, nonatomic, readonly, nullable) NSString *BIC;

/// This is to accommodate additional country specific fields like Sort Code in UK.
@property (strong, nonatomic, readonly, nullable) NSString *bankBranchCode;

/// Address of the Payer/Payee - Alternate address line for the account.
@property (strong, nonatomic, readonly, nullable) NSString *accountHolderAddressLine1;

/// Address of the Payer/Payee - Alternate address line for the account.
@property (strong, nonatomic, readonly, nullable) NSString *accountHolderAddressLine2;

/// Street name of the Payer/Payee - Alternate street name for the account.
@property (strong, nonatomic, readonly, nullable) NSString *accountHolderStreetName;

/// ISO Country code 2 chars.
@property (strong, nonatomic, readonly, nullable) NSString *accountHolderCountry;

/// Town of the Payer/Payee - Alternate town for the account.
@property (strong, nonatomic, readonly, nullable) NSString *town;

/// Post code of the Payer/Payee.
@property (strong, nonatomic, readonly, nullable) NSString *postCode;

/// Country Sub Division of the Payer/Payee.
@property (strong, nonatomic, readonly, nullable) NSString *countrySubDivision;

/// Start date of the account.
@property (strong, nonatomic, readonly, nullable) NSString *startDate;

/// Minimum amount that a customer must have in an account in order to receive some sort of service,
/// such as keeping the account open or receive interest.
@property (strong, nonatomic, readonly, nullable) NSNumber *minimumRequiredBalance;

/// Available balance of the account.
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *availableBalance;

/// Credit limit, applicable to credit cards and current accounts.
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *creditLimit;

/// Monetary amount of the used overdraft.
@property (strong, nonatomic, readonly, nullable) NSNumber *creditLimitUsage;

/// Overdraft Interest is an interest applied to the account for any time throughout the month when the account is overdrawn.
@property (strong, nonatomic, readonly, nullable) NSNumber *creditLimitInterestRate;

/// The date after which overdraft will no longer be available to the account (renewed automatically or cancelled).
@property (strong, nonatomic, readonly, nullable) NSString *creditLimitExpiryDate;

/// A list of related debit cards.
@property (strong, nonatomic, readonly, nullable) NSArray<BBDebitCardItem *> *debitCardsItems;

/// Booked balance, applicable to credit cards, loans, current and saving accounts.
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *bookedBalance;

/// Currency code.
@property (strong, nonatomic, readonly, nullable) NSString *currency;

/// Whether this product allows urgent transfers. Type: Boolean
@property (assign, nonatomic, readonly) BOOL urgentTransferAllowed;

/// Indicator whether or not the arrangement can be used in payment orders as credit account. Type: Boolean
@property (strong, nonatomic, readonly, nullable) NSNumber *creditAccount;

/// Indicator whether or not the arrangement can be used in payment orders as debit account. Type: Boolean
@property (strong, nonatomic, readonly, nullable) NSNumber *debitAccount;

/// The annualized cost of credit or debt-capital computed as the percentage ratio of interest to the principal.
@property (strong, nonatomic, readonly, nullable) NSNumber *accountInterestRate;

/// The balance of the account on a specific date that needs to be used for the calculation of interest.
/// If no date is specified (like for the book date balance) the current date can be assumed.
@property (strong, nonatomic, readonly, nullable) NSNumber *valueDateBalance;

/// Accrued interest, applicable to saving accounts and term deposits.
@property (strong, nonatomic, readonly, nullable) NSNumber *accruedInterest;

/// Name of the account holder.
@property (strong, nonatomic, readonly, nullable) NSString *accountHolderNames;

/**
 * Convenience method that converts creditLimitExpiryDate property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the creditLimitExpiryDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for creditLimitExpiryDate.
 */
-(nullable NSDate*)creditLimitExpiryDate:(nullable NSString*)dateFormat;

/**
 * Convenience method that converts startDate property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the startDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for startDate.
 */
-(nullable NSDate*)startDate:(nullable NSString*)dateFormat;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBCurrentAccount_h */
