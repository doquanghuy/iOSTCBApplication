//
//  Created by Backbase R&D B.V. on 09/02/2018.
//

#import <Foundation/Foundation.h>
#import <CommonUtils/CommonUtils.h>
#import <ContactsClient/BBActiveStatusType.h>

#ifndef BBBaseContact_h
#define BBBaseContact_h

@class Account;

@interface BBBaseContact : Additions <NSMutableCopying>

/// The name of a contact.
@property (strong, nonatomic, nonnull, readonly) NSString *name;

/// Name will be displayed if alias field is not filled.
@property (strong, nonatomic, nullable, readonly) NSString *alias;

/// Category to which the contact belongs to like employee, supplier.
@property (strong, nonatomic, nullable, readonly) NSString *category;

/// Contact person of the contact.
@property (strong, nonatomic, nullable, readonly) NSString *contactPerson;

/// Contact phone number of the contact.
@property (strong, nonatomic, nullable, readonly) NSString *phoneNumber;

/// Email-id of the contact.
@property (strong, nonatomic, nullable, readonly) NSString *emailId;

/// Address line 1.
@property (strong, nonatomic, nullable, readonly) NSString *addressLine1;

/// Address line 2.
@property (strong, nonatomic, nullable, readonly) NSString *addressLine2;

/// Street name.
@property (strong, nonatomic, nullable, readonly) NSString *streetName;

/// City or town.
@property (strong, nonatomic, nullable, readonly) NSString *town;

/// Address post code.
@property (strong, nonatomic, nullable, readonly) NSString *postCode;

/// Country region or state
@property (strong, nonatomic, nullable, readonly) NSString *countrySubDivision;

/// ISO Country Code
@property (strong, nonatomic, nullable, readonly) NSString *country;

/// The context in which this is stored, either ServiceAgreement (SA), LegalEntity (LE) or User (USER)
@property (strong, nonatomic, nullable, readonly) NSString *accessContextScope
__deprecated_msg("Deprecated and to be removed in next major release.");

/// List of accounts.
@property (strong, nonatomic, readonly, nonnull) NSArray<__kindof Account *> *accounts;

// The status of an active contact.
// When approvals is not enabled ACTIVE is the only value possible. Otherwise following values mean: ACTIVE (fully approved),
// PENDING_APPROVAL to denote the active contact has a pending change waiting to be approved.
@property (strong, nonatomic, nullable, readonly) BBActiveStatusType activeStatus;

- (BOOL)isEqualTo:(BBBaseContact * _Nullable)contactItem;

@end

#endif /* BBBaseContact_h */
