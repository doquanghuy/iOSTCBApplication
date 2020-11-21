//
//  Created by Backbase R&D B.V. on 24/09/2019.
//

#ifndef ProductsClient_BBGeneralAccount_h
#define ProductsClient_BBGeneralAccount_h

#import <ProductsClient/BBBaseProduct.h>

NS_ASSUME_NONNULL_BEGIN

/// This class is a response class as a product part of custom product kinds
@interface BBGeneralAccount : BBBaseProduct

/// Booked balance, applicable to credit cards, loans, current and saving accounts.
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *bookedBalance;

/// Booked balance, applicable to credit cards, loans, current and saving accounts.
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *availableBalance;

/// Booked balance, applicable to credit cards, loans, current and saving accounts.
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *creditLimit;

/// Specifying the IBAN of the account.
@property (strong, nonatomic, readonly, nullable) NSString *IBAN;

/// Specifying the IBAN of the account.
@property (strong, nonatomic, readonly, nullable) NSString *BBAN;

/// Currency code.
@property (strong, nonatomic, readonly, nullable) NSString *currency;

/// Whether this product allows urgent transfers. Type: Boolean
@property (assign, nonatomic, readonly) BOOL urgentTransferAllowed;

/// Bank Identifier Code - international bank code that identifies particular banks worldwide.
@property (strong, nonatomic, readonly, nullable) NSString *BIC;

/// This is to accommodate additional country specific fields like Sort Code in UK.
@property (strong, nonatomic, readonly, nullable) NSString *bankBranchCode;

/// The annualized cost of credit or debt-capital computed as the percentage ratio of interest to the principal.
@property (strong, nonatomic, readonly, nullable) NSNumber *accountInterestRate;

/// The balance of the account on a specific date that needs to be used for the calculation of interest.
/// If no date is specified (like for the book date balance) the current date can be assumed.
@property (strong, nonatomic, readonly, nullable) NSNumber *valueDateBalance;

/// Monetary amount of the used overdraft.
@property (strong, nonatomic, readonly, nullable) NSNumber *creditLimitUsage;

/// Overdraft Interest is an interest applied to the account for any time throughout the month when the account is overdrawn.
@property (strong, nonatomic, readonly, nullable) NSNumber *creditLimitInterestRate;

/// The date after which overdraft will no longer be available to the account (renewed automatically or cancelled).
@property (strong, nonatomic, readonly, nullable) NSString *creditLimitExpiryDate;

/// Accrued interest, applicable to saving accounts and term deposits.
@property (strong, nonatomic, readonly, nullable) NSNumber *accruedInterest;

/// A list of related debit cards.
@property (strong, nonatomic, readonly, nullable) NSArray<BBDebitCardItem *> *debitCardsItems;

/// Start date of the account.
@property (strong, nonatomic, readonly, nullable) NSString *startDate;

/// Minimum amount that a customer must have in an account in order to receive some sort of service,
/// such as keeping the account open or receive interest.
@property (strong, nonatomic, readonly, nullable) NSNumber *minimumRequiredBalance;

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

/// Name of the account holder.
@property (strong, nonatomic, readonly, nullable) NSString *accountHolderNames;

/// First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked.
/// Be aware that using card number differently is potential PCI risk.
@property (strong, nonatomic, readonly, nullable) NSString *number;

/// Credit card number.
@property (strong, nonatomic, readonly, nullable) NSNumber *cardNumber;

/// The number of the account the credit card transactions settle on (so actually the reference to the settlement account of the card).
@property (strong, nonatomic, readonly, nullable) NSString *creditCardAccountNumber;

/// Expiration date of a credit card, after which is no longer valid.
@property (strong, nonatomic, readonly, nullable) NSString *validThru;

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

/// Current investment value, applicable to investments
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *currentInvestmentValue;

/// The number identifying the contract.
@property (strong, nonatomic, readonly, nullable) NSString *productNumber;

/// Principal amount, applicable to term deposits and loans
@property (strong, nonatomic, readonly, nullable) NSNumber *principalAmount;

/// The period of time and/or the interest rate arranged between Bank and customer.
@property (strong, nonatomic, readonly, nullable) BBTimeUnit termUnit;

/// The number of times interest rate is paid on the settlement account.
@property (strong, nonatomic, readonly, nullable) NSNumber *termNumber;

/// This is the value date balance of the arrangement.
@property (strong, nonatomic, readonly, nullable) NSNumber *outstandingPrincipalAmount;

/// A fixed payment amount paid by a borrower to the bank at a specified date each calendar month.
@property (strong, nonatomic, readonly, nullable) NSNumber *monthlyInstalmentAmount;

/// The part of a debt that is overdue after missing one or more required payments.
/// The amount of the arrears is the amount accrued from the date on which the first missed payment was due.
@property (strong, nonatomic, readonly, nullable) NSNumber *amountInArrear;

/// Account that provides quick access to accumulated cash to facilitate daily settlements with other businesses.
@property (strong, nonatomic, readonly, nullable) NSString *interestSettlementAccount;

/// End term of a holding period.
@property (strong, nonatomic, readonly, nullable) NSString *maturityDate;

/// Amount payable at the end of a holding period of a product (maturity date). For deposit all
/// of the interest is usually paid at maturity date (IF the term is shorter then one year).
@property (strong, nonatomic, readonly, nullable) NSNumber *maturityAmount;

/// Indicates whether or not an arrangement is to be continued after maturity automatically.
/// Usually the product is renewed using the same principal and term unless renegotiation has taken place prior to expiration.
/// Type: Boolean
@property (strong, nonatomic, readonly, nullable) NSNumber *autoRenewalIndicator;

/// Number of times per year when the accumulated interest is settled to the account on a regular basis.
/// The frequency could be yearly, half-yearly, quarterly, monthly, weekly, daily (or not at all, until maturity).
@property (strong, nonatomic, readonly, nullable) BBTimeUnit interestPaymentFrequencyUnit;

/// The number of times interest rate is paid on the settlement account
@property (strong, nonatomic, readonly, nullable) NSNumber *interestPaymentFrequencyNumber;

/// Indicator whether or not the arrangement can be used in payment orders as credit account. Type: Boolean
@property (strong, nonatomic, readonly, nullable) NSNumber *creditAccount;

/// Indicator whether or not the arrangement can be used in payment orders as debit account. Type: Boolean
@property (strong, nonatomic, readonly, nullable) NSNumber *debitAccount;

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

/**
 * Convenience method that converts maturityDate property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the maturityDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for maturityDate.
 */
-(nullable NSDate*)maturityDate:(nullable NSString*)dateFormat;

/**
 * Convenience method that converts minimumPaymentDueDate property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the minimumPaymentDueDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for minimumPaymentDueDate.
 */
-(nullable NSDate*)minimumPaymentDueDate:(nullable NSString*)dateFormat;

/**
 * Convenience method that converts validThru property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the validThru object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for validThru.
 */
-(nullable NSDate*)validThru:(nullable NSString*)dateFormat;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBGeneralAccount_h */
