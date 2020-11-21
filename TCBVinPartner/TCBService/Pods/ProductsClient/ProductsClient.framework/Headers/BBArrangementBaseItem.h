//
//  Created by Backbase R&D B.V. on 08/05/2019.
//

#ifndef ProductsClient_BBArrangementBaseItem_h
#define ProductsClient_BBArrangementBaseItem_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// This class is a base class for arrangement item.
@interface BBArrangementBaseItem : Additions

#pragma mark - Properties

/// A unique external identifier for the arrangement.
/// Max Length: 50
@property (strong, nonatomic, nonnull, readonly) NSString* externalArrangementId;

/// The alfa-3 code (complying with ISO 4217) of the currency that qualifies the amount.
@property (strong, nonatomic, nonnull, readonly) NSString* currency;

/// The name that can be assigned by the bank to label a arrangement.
/// Max Length: 50
@property (strong, nonatomic, nullable, readonly) NSString* name;

/// Amount of money available before any adjustments have been made for deposits in transit,
/// checks that have not yet been cleared, reserve requirements and interest received
@property (strong, nonatomic, nullable, readonly) NSNumber* bookedBalance;

/// The amount that is available for transactions
@property (strong, nonatomic, nullable, readonly) NSNumber* availableBalance;

/// The maximum amount of credit that the financial institution will extend to the account holder for this arrangement
@property (strong, nonatomic, nullable, readonly) NSNumber* creditLimit;

/// Specifying the IBAN of the account.
/// Pattern: ^(AF|AX|AL|DZ).*
/// Max Length: 34
@property (strong, nonatomic, nullable, readonly) NSString* IBAN;

/// Specifying the BBAN of the account.
/// Max Length: 50
@property (strong, nonatomic, nullable, readonly) NSString* BBAN;

/// Defines if transfer to another party is allowed. Type: Boolean.
@property (strong, nonatomic, nullable, readonly) NSNumber *externalTransferAllowed;

/// Defines if urgent transfer is allowed. Type: Boolean.
@property (strong, nonatomic, nullable, readonly) NSNumber* urgentTransferAllowed;

/// The interest that is earned (credit interest) or due (debit interest) but not settled yet.
@property (strong, nonatomic, nullable, readonly) NSNumber* accruedInterest;

/// Last 4 digits of a Payment card.
/// Max Length: 36
@property (strong, nonatomic, nullable, readonly) NSString* number;

/// The amount that was (originally) contracted for the respective product.
/// This is mainly used in the context of loans and deposits.
@property (strong, nonatomic, nullable, readonly) NSNumber* principalAmount;

/// The total current value of all the securities kept in the account.
/// Minimum: 0
@property (strong, nonatomic, nullable, readonly) NSNumber* currentInvestmentValue;

/// The number identifying the contract.
/// Max Length: 36
@property (strong, nonatomic, nullable, readonly) NSString* productNumber;

/// Bank Identifier Code - international bank code that identifies particular banks worldwide.
/// Max Length: 11
@property (strong, nonatomic, nullable, readonly) NSString* BIC;

/// This is to accomodate additional country specific fields like Sort Code in UK.
/// Max Length: 20
@property (strong, nonatomic, nullable, readonly) NSString* bankBranchCode;

/// The date of activation of the account in the bank's system.
@property (strong, nonatomic, nullable, readonly) NSString* accountOpeningDate;

/// The annualized cost of credit or debt-capital computed as the percentage ratio of interest to the principal.
@property (strong, nonatomic, nullable, readonly) NSNumber* accountInterestRate;

/// The balance of the account on a specific date that needs to be used for the calculation of interest.
/// NB! If no date is specified (like for the book date balance) the current date can be assumed.
@property (strong, nonatomic, nullable, readonly) NSNumber* valueDateBalance;

/// Monetary amount of the used overdraft.
@property (strong, nonatomic, nullable, readonly) NSNumber* creditLimitUsage;

/// Overdraft Interest is an interest applied to the account for any time throughout the month when the account is overdrawn
@property (strong, nonatomic, nullable, readonly) NSNumber* creditLimitInterestRate;

/// The date after which overdraft will no longer be available to the account (renewed automatically or cancelled).
@property (strong, nonatomic, nullable, readonly) NSString* creditLimitExpiryDate;

/// Start Date
@property (strong, nonatomic, nullable, readonly) NSString* startDate;

/// The period of time and/or the interest rate arranged between Bank and customer.
/// which may be: "D", "W", "M", "Y".
@property (strong, nonatomic, nullable, readonly) BBTimeUnit termUnit;

/// The number of times interest rate is paid on the settlement account.
@property (strong, nonatomic, nullable, readonly) NSNumber* termNumber;

/// The period of time and/or the interest rate arranged between Bank and customer.
/// which may be: "D", "W", "M", "Y".
@property (strong, nonatomic, nullable, readonly) BBTimeUnit interestPaymentFrequencyUnit;

/// The frequency number of interest payment.
@property (strong, nonatomic, nullable, readonly) NSNumber* interestPaymentFrequencyNumber;

/// End term of a holding period.
@property (strong, nonatomic, nullable, readonly) NSString* maturityDate;

/// Amount payable at the end of a holding period of a product (maturity date).
/// For deposit all of the interest is usualy paid at maturity date (IF the term is shorter then one year).
@property (strong, nonatomic, nullable, readonly) NSNumber* maturityAmount;

/// Indicates whether or not an arrangement is to be continued after maturity automatically.
/// Usually the product is renewed using the same principal and term unless renegotiation has taken place prior to expiration.
/// Type: Boolean.
@property (strong, nonatomic, nullable, readonly) NSNumber* autoRenewalIndicator;

/// Account that provides quick access to accumulated cash to facilitate daily settlements with other businesses.
/// Max Length: 32
@property (strong, nonatomic, nullable, readonly) NSString* interestSettlementAccount;

/// This IS the value date balance of the arrangement.
@property (strong, nonatomic, nullable, readonly) NSNumber* outstandingPrincipalAmount;

/// A fixed payment amount paid by a borrower to the bank at a specified date each calendar month.
@property (strong, nonatomic, nullable, readonly) NSNumber* monthlyInstalmentAmount;

/// The part of a debt that is overdue after missing one or more required payments.
/// The amount of the arrears is the amount accrued from the date on which the first missed payment was due.
@property (strong, nonatomic, nullable, readonly) NSNumber* amountInArrear;

/// Minimum amount that a customer must have in an account in order to receive some sort of service,
/// such as keeping the account open or receive interest
@property (strong, nonatomic, nullable, readonly) NSNumber* minimumRequiredBalance;

/// The number of the account the credit card transactions settle on.
/// Max length: 32
@property (strong, nonatomic, nullable, readonly) NSString* creditCardAccountNumber;

/// Expiration date of a credit card, after which is no longer valid.
@property (strong, nonatomic, nullable, readonly) NSString* validThru;

/// The interest rate or rates which would be used for a particular arrangement.
@property (strong, nonatomic, nullable, readonly) NSNumber* applicableInterestRate;

/// Remaining Credit.
@property (strong, nonatomic, nullable, readonly) NSNumber* remainingCredit;

/// Outstanding Payment.
@property (strong, nonatomic, nullable, readonly) NSNumber* outstandingPayment;

/// The minimum payment set a percentage of balance, or a fixed cash amount.
@property (strong, nonatomic, nullable, readonly) NSNumber* minimumPayment;

/// Minimum Payment Due Date shown on your monthly statement to remain in good standing.
@property (strong, nonatomic, nullable, readonly) NSString* minimumPaymentDueDate;

/// Total Investment Value
@property (strong, nonatomic, nullable, readonly) NSNumber* totalInvestmentValue;

/// Debit cards
@property (strong, nonatomic, nullable, readonly) NSArray<__kindof BBDebitCardItem*>* debitCards;

/// Address of the Payer/Payee - Alternate address line for the account
/// Max Length: 70
@property (strong, nonatomic, nullable, readonly) NSString* accountHolderAddressLine1;

/// Address of the Payer/Payee - Alternate address line for the account
/// Max Length: 70
@property (strong, nonatomic, nullable, readonly) NSString* accountHolderAddressLine2;

/// Street name of the Payer/Payee - Alternate street name for the account
/// Max Length: 70
@property (strong, nonatomic, nullable, readonly) NSString* accountHolderStreetName;

/// Town of the Payer/Payee - Alternate town for the account.
/// Max Length: 35
@property (strong, nonatomic, nullable, readonly) NSString* town;

/// Address Post Code of the account holder.
/// Max Length: 16
@property (strong, nonatomic, nullable, readonly) NSString* postCode;

/// Country Sub Division.
/// Max Length: 35
@property (strong, nonatomic, nullable, readonly) NSString* countrySubDivision;

/// The name that can be assigned by the bank holder of a given arrangement.
/// Max Length: 64
@property (strong, nonatomic, nullable, readonly) NSString* accountHolderNames;

/// Account Holder's country code.
/// Example: NL
@property (strong, nonatomic, nullable, readonly) NSString* accountHolderCountry;

/// Indicator wether or not the arrangement can be used in payment orders as credit account.
@property (strong, nonatomic, nullable, readonly) NSNumber* creditAccount;

/// Indicator wether or not the arrangement can be used in payment orders as debit account.
@property (strong, nonatomic, nullable, readonly) NSNumber* debitAccount;

/// Last date of parametar update for the arrangement.
@property (strong, nonatomic, nullable, readonly) NSString* lastUpdateDate;

/// The name that can be assigned by the customer to label the arrangement.
/// Max Length: 50
@property (strong, nonatomic, nullable, readonly) NSString* bankAlias;

/// Indicate if the account is regular or external.
@property (strong, nonatomic, nullable, readonly) NSString* sourceId;

/// External reference to the arrangement state.
@property (strong, nonatomic, nullable, readonly) NSString* externalStateId;

/// Indicate if the account has parent child relationship with another account.
@property (strong, nonatomic, nullable, readonly) NSString* externalParentId;

#pragma mark - Methods

/**
 * Create an BBArrangementBaseItem object for a PUT request.
 * @param externalArrangementId A unique external identifier for the arrangement. Max Length: 50.
 * @param currency The alfa-3 code (complying with ISO 4217) of the currency that qualifies the amount.
 * @return The initialized BBArrangementBaseItem object.
 */
- (instancetype _Nonnull)initWithExternalArrangementId:(nonnull NSString *)externalArrangementId
                                              currency:(nonnull NSString *)currency;

/**
 * Convenience method that converts accountOpeningDate property into the given or default date-time format.
 * @param dateFormat date-time format to parse the accountOpeningDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for accountOpeningDate.
 */
-(nullable NSDate*)accountOpeningDate:(nullable NSString*)dateFormat;

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
 * Convenience method that converts lastUpdateDate property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the lastUpdateDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for lastUpdateDate.
 */
-(nullable NSDate*)lastUpdateDate:(nullable NSString*)dateFormat;

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

#endif /* ProductsClient_BBArrangementBaseItem_h */
