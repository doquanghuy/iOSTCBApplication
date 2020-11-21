//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBDebitCard_h
#define ProductsClient_BBDebitCard_h

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/BBBaseProduct.h>

NS_ASSUME_NONNULL_BEGIN

/// Debit card product.
@interface BBDebitCard : BBBaseProduct

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

/// A list of related debit cards.
@property (strong, nonatomic, readonly, nullable) NSArray<BBDebitCardItem *> *debitCardsItems;

/// Card start date.
@property (strong, nonatomic, readonly, nullable) NSString *startDate;

/**
 * Convenience method that converts startDate property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the startDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for startDate.
 */
-(nullable NSDate*)startDate:(nullable NSString*)dateFormat;

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

#endif /* ProductsClient_BBDebitCard_h */
