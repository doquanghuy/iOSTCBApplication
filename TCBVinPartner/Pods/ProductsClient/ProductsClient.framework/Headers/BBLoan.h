//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBLoan_h
#define ProductsClient_BBLoan_h

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/BBBaseProduct.h>

NS_ASSUME_NONNULL_BEGIN

/// Loan product.
@interface BBLoan : BBBaseProduct

/// Product number, applicable to invesments, loans and term deposits.
@property (strong, nonatomic, readonly, nullable) NSString *productNumber;

/// This is the value date balance of the arrangement.
@property (strong, nonatomic, readonly, nullable) NSNumber *outstandingPrincipalAmount;

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

/// A fixed payment amount paid by a borrower to the bank at a specified date each calendar month.
@property (strong, nonatomic, readonly, nullable) NSNumber *monthlyInstalmentAmount;

/// The part of a debt that is overdue after missing one or more required payments.
/// The amount of the arrears is the amount accrued from the date on which the first missed payment was due.
@property (strong, nonatomic, readonly, nullable) NSNumber *amountInArrear;

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

/// Specifying the IBAN of the account.
@property (strong, nonatomic, readonly, nullable) NSString *IBAN;

/// Specifying the BBAN of the account.
@property (strong, nonatomic, readonly, nullable) NSString *BBAN;

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

#endif /* ProductsClient_BBLoan_h */
