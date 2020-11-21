//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBSavingsAccount_h
#define ProductsClient_BBSavingsAccount_h

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/BBBaseProduct.h>

NS_ASSUME_NONNULL_BEGIN

/// Savings account product.
@interface BBSavingsAccount : BBBaseProduct

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

/// Amount payable at the end of a holding period of a product (maturity date). For deposit all
/// of the interest is usually paid at maturity date (IF the term is shorter then one year).
@property (strong, nonatomic, readonly, nullable) NSNumber *maturityAmount;

/// Indicates whether or not an arrangement is to be continued after maturity automatically.
/// Usually the product is renewed using the same principal and term unless renegotiation has taken place prior to expiration. Type: Boolean
@property (strong, nonatomic, readonly, nullable) NSNumber *autoRenewalIndicator;

/// Number of times per year when the accumulated interest is settled to the account on a regular basis.
/// The frequency could be yearly, half-yearly, quarterly, monthly, weekly, daily (or not at all, until maturity).
@property (strong, nonatomic, readonly, nullable) BBTimeUnit interestPaymentFrequencyUnit;

/// The number of times interest rate is paid on the settlement account
@property (strong, nonatomic, readonly, nullable) NSNumber *interestPaymentFrequencyNumber;

/// The period of time and/or the interest rate arranged between Bank and customer.
@property (strong, nonatomic, readonly, nullable) BBTimeUnit termUnit;

/// The number of times interest rate is paid on the settlement account.
@property (strong, nonatomic, readonly, nullable) NSNumber *termNumber;

/// End term of a holding period.
@property (strong, nonatomic, readonly, nullable) NSString *maturityDate;

/// Principal amount, applicable to term deposits and loans
@property (strong, nonatomic, readonly, nullable) NSNumber *principalAmount;

/// Account that provides quick access to accumulated cash to facilitate daily settlements with other businesses.
@property (strong, nonatomic, readonly, nullable) NSString *interestSettlementAccount;

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
 * Convenience method that converts startDate property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the startDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for startDate.
 */
-(nullable NSDate*)startDate:(nullable NSString*)dateFormat;

/**
 * Convenience method that converts maturityDate property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the maturityDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for maturityDate.
 */
-(nullable NSDate*)maturityDate:(nullable NSString*)dateFormat;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBSavingsAccount_h */
