//
//  Created by Backbase R&D B.V. on 16/03/2018.
//

#ifndef MutableContactItem_h
#define MutableContactItem_h

#import "ContactItem.h"

@interface MutableContactItem : ContactItem <NSCopying>

/// Internally used unique identification of the contact.
@property (strong, nonatomic, nonnull) NSString *identifier;

/// The name of a contact.
@property (strong, nonatomic, nonnull) NSString *name;

/// Name will be displayed if alias field is not filled.
@property (strong, nonatomic, nullable) NSString *alias;

/// Category to which the contact belongs to like employee, supplier.
@property (strong, nonatomic, nullable) NSString *category;

/// Contact person of the contact.
@property (strong, nonatomic, nullable) NSString *contactPerson;

/// Contact phone number of the contact.
@property (strong, nonatomic, nullable) NSString *phoneNumber;

/// Email-id of the contact.
@property (strong, nonatomic, nullable) NSString *emailId;

/// Address line 1.
@property (strong, nonatomic, nullable) NSString *addressLine1;

/// Address line 2.
@property (strong, nonatomic, nullable) NSString *addressLine2;

/// Street name.
@property (strong, nonatomic, nullable) NSString *streetName;

/// City or town.
@property (strong, nonatomic, nullable) NSString *town;

/// Address post code.
@property (strong, nonatomic, nullable) NSString *postCode;

/// Country region or state
@property (strong, nonatomic, nullable) NSString *countrySubDivision;

/// ISO Country Code
@property (strong, nonatomic, nullable) NSString *country;

/// The context in which this is stored, either ServiceAgreement (SA), LegalEntity (LE) or User (USER)
@property (strong, nonatomic, nullable) NSString *accessContextScope;

/// List of accounts.
@property (strong, nonatomic, nonnull) NSArray<__kindof Account *> *accounts;

// The status of an active contact.
// When approvals is not enabled ACTIVE is the only value possible. Otherwise following values mean: ACTIVE (fully approved),
// PENDING_APPROVAL to denote the active contact has a pending change waiting to be approved.
@property (strong, nonatomic, nullable) BBActiveStatusType activeStatus;

@end

#endif /* MutableContactItem_h */
