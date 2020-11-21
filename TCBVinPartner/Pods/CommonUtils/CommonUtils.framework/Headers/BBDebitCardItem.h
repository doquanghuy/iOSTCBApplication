//
//  Created by Backbase R&D B.V. on 19/04/2019.
//

#ifndef BBDebitCardItem_h
#define BBDebitCardItem_h

#import <CommonUtils/CommonUtils.h>

/// Debit card item for an arrangement.
@interface BBDebitCardItem : Additions

/// First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked.
/// Be aware that using card number differently is potential PCI risk
@property (strong, nonatomic, readonly, nullable) NSString *number;

/// Expiration date of a credit card, after which is no longer valid
/// Converts to the date object by using `yyyy-MM-dd` date-time format
@property (strong, nonatomic, readonly, nullable) NSDate *expiryDate;

/// External ID of the card
@property (strong, nonatomic, readonly, nullable) NSString *cardId;

/// First Name and Last Name of card holder.
@property (strong, nonatomic, readonly, nullable) NSString *cardholderName;

/// Card type to change card image based on it, ex. Maestro Gold
@property (strong, nonatomic, readonly, nullable) NSString *cardType;

/// Status of the card ex. Active, Expired etc
@property (strong, nonatomic, readonly, nullable) NSString *cardStatus;


/**
 * Convenience method that returns expiryDate property with the given date-time format.
 * This method is added to prevent misalignment between DBS and this class.
 * In case DBS returns different format than the expected format by the client,
 * then expiryDate will be nil, then use this conveince method to get the correctly parsed date.
 * @param dateFormat date-time format
 * @return parsed date object for expiryDate.
 */
-(nullable NSDate*)expiryDate:(nonnull NSString*)dateFormat;

@end

#endif
