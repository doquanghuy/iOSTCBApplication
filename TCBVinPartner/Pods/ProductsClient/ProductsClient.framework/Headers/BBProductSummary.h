//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBProductSummary_h
#define ProductsClient_BBProductSummary_h

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/BBAggregatedBalance.h>
#import <ProductsClient/BBCurrentAccounts.h>
#import <ProductsClient/BBSavingsAccounts.h>
#import <ProductsClient/BBTermDeposits.h>
#import <ProductsClient/BBLoans.h>
#import <ProductsClient/BBCreditCards.h>
#import <ProductsClient/BBDebitCards.h>
#import <ProductsClient/BBInvestmentAccounts.h>
#import <ProductsClient/BBProductConverter.h>
#import <ProductsClient/BBProductKind.h>
#import <ProductsClient/BBCustomProductKind.h>
#import <ProductsClient/BBProductConverterFactory.h>

NS_ASSUME_NONNULL_BEGIN

/// Response class for all product details.
@interface BBProductSummary : Additions

/// Defines a balance for groups of products.
@property (strong, nonatomic, readonly, nullable) BBAggregatedBalance *aggregatedBalance;

/// Current accounts product kind
@property (strong, nonatomic, readonly, nullable) BBCurrentAccounts *currentAccounts;

/// Savings accounts product kind
@property (strong, nonatomic, readonly, nullable) BBSavingsAccounts *savingsAccounts;

/// Term deposits product kind
@property (strong, nonatomic, readonly, nullable) BBTermDeposits *termDeposits;

/// Loans product kind
@property (strong, nonatomic, readonly, nullable) BBLoans *loans;

/// Credit cards product kind
@property (strong, nonatomic, readonly, nullable) BBCreditCards *creditCards;

/// Debit cards product kind
@property (strong, nonatomic, readonly, nullable) BBDebitCards *debitCards;

/// Investment accounts product kind
@property (strong, nonatomic, readonly, nullable) BBInvestmentAccounts *investmentAccounts;

/// An array of custom product kinds.
@property (strong, nonatomic, readonly, nullable) NSArray<BBCustomProductKind*>* customProductKinds;

/**
 * Returns a list of all product kinds.
 * Returns an empty array if all product kinds are nil.
 */
- (nonnull NSArray<Additions<BBProductKind>*> *)productKinds;

/**
 * This method converts all product summary items into an array of recipient model.
 * @param factory Product converter factory instance
 * @param typeIdentifier Identifies the type of the recipient.
 * @return A list of recipients.
 */
- (NSArray<RecipientModel *> *)convertToRecipientModelListWithFactory:(BBProductConverterFactory *)factory
                                                    forTypeIdentifier:(NSString *)typeIdentifier;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBProductSummary_h */
