//
//  Created by Backbase R&D B.V. on 12/09/2017.
//

#ifndef TransactionItem_h
#define TransactionItem_h

#import <CommonUtils/CommonUtils.h>
#import <Foundation/Foundation.h>
#import <TransactionsClient/BBTransactionTypeGroup.h>
#import <TransactionsClient/BBTransactionLocation.h>
#import <TransactionsClient/BBTransactionMerchant.h>
#import <TransactionsClient/BBTransactionCheckImageAvailability.h>

@interface TransactionItem : Additions

/// Internally used unique identification of the transaction
@property (strong, nonatomic, nonnull, readonly) NSString *identifier;

/// Reference to the product to which the transaction belongs
@property (strong, nonatomic, nonnull, readonly) NSString *arrangementId;

/// A tag/label issued by the initiator of the transaction in order to be able to refer to the respective transaction
@property (strong, nonatomic, nullable, readonly) NSString *reference;

/// Description of the transaction
@property (strong, nonatomic, nonnull, readonly) NSString *desc;

/// One of "Payment", "Withdrawal", "Loans", "Fees"
@property (strong, nonatomic, nonnull, readonly) NSString *typeGroup;

/// Bank specific code to be mapped to generic type in integration
@property (strong, nonatomic, nonnull, readonly) NSString *type;

/// Transaction category
@property (strong, nonatomic, nullable, readonly) NSString *category;

/// The date the amount is posted to the balance of an account from a book
/// keeping perspective.
@property (strong, nonatomic, nonnull, readonly) NSString *bookingDate;

/// The date on which an amount posted to an account becomes interest bearing
@property (strong, nonatomic, nullable, readonly) NSString *valueDate;

/// One of "CRDT", "DBIT"
@property (strong, nonatomic, nonnull, readonly) NSString *creditDebitIndicator;

/// The amount of the transaction
@property (strong, nonatomic, nullable, readonly) BBCurrency *transactionAmountCurrency;

/// Only present if the transaction currency does not match the account currency.
@property (strong, nonatomic, nullable, readonly) BBCurrency *instructedAmountCurrency;

/// The exchange rate (between both account and transaction currency) that was
/// used for the conversion. To be used if those currencies are not the same.
@property (strong, nonatomic, nullable, readonly) NSNumber *currencyExchangeRate;

/// The name of the counterparty.
@property (strong, nonatomic, nullable, readonly) NSString *counterPartyName;

/// The International Bank Account Number of the counterparty.
@property (strong, nonatomic, nullable, readonly) NSString *counterPartyAccountNumber;

/// The BIC of the counterparty.
@property (strong, nonatomic, nullable, readonly) NSString *counterPartyBIC;

/// ISO Country code.
@property (strong, nonatomic, nullable, readonly) NSString *counterPartyCountry;

/// The bank name of the counterparty.
@property (strong, nonatomic, nullable, readonly) NSString *counterPartyBankName;

/// Id of the creditor (Only for SEPA DD).
@property (strong, nonatomic, nullable, readonly) NSString *creditorId;

/// Mandate Reference (Only for SEPA DD).
@property (strong, nonatomic, nullable, readonly) NSString *mandateReference;

/// Billing status of the transaction
@property (strong, nonatomic, nullable, readonly) NSString *billingStatus;

/// Serial number of the check. Each check has a different number for identification purposes.
@property (strong, nonatomic, nullable, readonly) NSNumber *checkSerialNumber;

/// If notes of the transaction are present
@property (strong, nonatomic, nullable, readonly) NSString *notes;

/// Indicates the balance of the account at that moment when the transaction was executed
@property (strong, nonatomic, nullable, readonly) NSNumber *runningBalance;

/// Reference to the product to which the transaction belongs
@property (strong, nonatomic, nonnull, readonly) NSString *productId;

/// Geographical coordinates of the transaction
@property (strong, nonatomic, nullable, readonly) BBTransactionLocation *location;

/// Merchant information for the transaction
@property (strong, nonatomic, nullable, readonly) BBTransactionMerchant *merchant;

/// Whether this transaction has check images available.
@property (strong, nonatomic, nullable, readonly) BBTransactionCheckImageAvailability checkImageAvailability;

@end

#endif
