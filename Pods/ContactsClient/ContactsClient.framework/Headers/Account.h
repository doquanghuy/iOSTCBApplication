//
//  Created by Backbase R&D B.V. on 09/02/2018.
//

#import <Foundation/Foundation.h>
#import <CommonUtils/CommonUtils.h>

#ifndef Account_h
#define Account_h

@interface Account : Additions <NSMutableCopying>

/// The name of an account.
@property (strong, nonatomic, nullable, readonly) NSString *name;

/// Name will be displayed if alias field is not filled.
@property (strong, nonatomic, nullable, readonly) NSString *alias;

/// Either of Account Number or IBAN is mandatory.
@property (strong, nonatomic, nullable, readonly) NSString *accountNumber;

/// Either of Account Number or IBAN is mandatory.
@property (strong, nonatomic, nullable, readonly) NSString *IBAN;

/// BIC.
@property (strong, nonatomic, nullable, readonly) NSString *BIC;

/// The name of a bank.
@property (strong, nonatomic, nullable, readonly) NSString *bankName;

/// The code of a bank.
@property (strong, nonatomic, nullable, readonly) NSString *bankCode;

/// Bank address line 1.
@property (strong, nonatomic, nullable, readonly) NSString *bankAddressLine1;

/// Bank address line 2.
@property (strong, nonatomic, nullable, readonly) NSString *bankAddressLine2;

/// Bank street name.
@property (strong, nonatomic, nullable, readonly) NSString *bankStreetName;

/// Bank city or town.
@property (strong, nonatomic, nullable, readonly) NSString *bankTown;

/// Bank address post code.
@property (strong, nonatomic, nullable, readonly) NSString *bankPostCode;

/// Bank country region or state.
@property (strong, nonatomic, nullable, readonly) NSString *bankCountrySubDivision;

/// ISO Country Code.
@property (strong, nonatomic, nullable, readonly) NSString *bankCountry;

/// Account address line 1.
@property (strong, nonatomic, nullable, readonly) NSString *accountHolderAddressLine1;

/// Account address line 2.
@property (strong, nonatomic, nullable, readonly) NSString *accountHolderAddressLine2;

/// Account holder street name
@property (strong, nonatomic, nullable, readonly) NSString *accountHolderStreetName;

/// Account holder city or town
@property (strong, nonatomic, nullable, readonly) NSString *accountHolderTown;

/// Account holder address post code
@property (strong, nonatomic, nullable, readonly) NSString *accountHolderPostCode;

/// Account holder country region or state"
@property (strong, nonatomic, nullable, readonly) NSString *accountHolderCountrySubDivision;

/// ISO Country Code.
@property (strong, nonatomic, nullable, readonly) NSString *accountHolderCountry;

- (BOOL)isEqualToAccount:(Account * _Nullable)account;

@end

#endif /* Account_h */
