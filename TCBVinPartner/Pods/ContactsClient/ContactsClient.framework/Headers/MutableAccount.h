//
//  Created by Backbase R&D B.V. on 16/03/2018.
//

#ifndef MutableAccount_h
#define MutableAccount_h

#import "Account.h"

@interface MutableAccount : Account <NSCopying>

/// The name of an account.
@property (strong, nonatomic, nullable) NSString *name;

/// Name will be displayed if alias field is not filled.
@property (strong, nonatomic, nullable) NSString *alias;

/// Either of Account Number or IBAN is mandatory.
@property (strong, nonatomic, nullable) NSString *accountNumber;

/// Either of Account Number or IBAN is mandatory.
@property (strong, nonatomic, nullable) NSString *IBAN;

/// BIC.
@property (strong, nonatomic, nullable) NSString *BIC;

/// The name of a bank.
@property (strong, nonatomic, nullable) NSString *bankName;

/// The code of a bank.
@property (strong, nonatomic, nullable) NSString *bankCode;

/// Bank address line 1.
@property (strong, nonatomic, nullable) NSString *bankAddressLine1;

/// Bank address line 2.
@property (strong, nonatomic, nullable) NSString *bankAddressLine2;

/// Bank street name.
@property (strong, nonatomic, nullable) NSString *bankStreetName;

/// Bank city or town.
@property (strong, nonatomic, nullable) NSString *bankTown;

/// Bank address post code.
@property (strong, nonatomic, nullable) NSString *bankPostCode;

/// Bank country region or state.
@property (strong, nonatomic, nullable) NSString *bankCountrySubDivision;

/// ISO Country Code.
@property (strong, nonatomic, nullable) NSString *bankCountry;

/// Account address line 1.
@property (strong, nonatomic, nullable) NSString *accountHolderAddressLine1;

/// Account address line 2.
@property (strong, nonatomic, nullable) NSString *accountHolderAddressLine2;

/// Account holder street name
@property (strong, nonatomic, nullable) NSString *accountHolderStreetName;

/// Account holder city or town
@property (strong, nonatomic, nullable) NSString *accountHolderTown;

/// Account holder address post code
@property (strong, nonatomic, nullable) NSString *accountHolderPostCode;

/// Account holder country region or state"
@property (strong, nonatomic, nullable) NSString *accountHolderCountrySubDivision;

/// ISO Country Code.
@property (strong, nonatomic, nullable) NSString *accountHolderCountry;

@end

#endif /* MutableAccount_h */
