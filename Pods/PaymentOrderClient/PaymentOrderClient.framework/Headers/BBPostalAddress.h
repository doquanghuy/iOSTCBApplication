//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef PaymentOrderClient_BBPostalAddress_h
#define PaymentOrderClient_BBPostalAddress_h

#import <CommonUtils/Additions.h>

/// Class representing a postal address
@interface BBPostalAddress : Additions

/// First address line
@property (nonatomic, strong, readonly, nullable) NSString *addressLine1;

/// Second address line
@property (nonatomic, strong, readonly, nullable) NSString *addressLine2;

/// Street name
@property (nonatomic, strong, readonly, nullable) NSString *streetName;

/// Post code
@property (nonatomic, strong, readonly, nullable) NSString *postCode;

/// Town
@property (nonatomic, strong, readonly, nullable) NSString *town;

/// Country subdivision
@property (nonatomic, strong, readonly, nullable) NSString *countrySubDivision;

/// Country
@property (nonatomic, strong, readonly, nullable) NSString *country;

- (nonnull instancetype)initWithAddressLine1:(nullable NSString *)addressLine1
                                addressLine1:(nullable NSString *)addressLine2
                                  streetName:(nullable NSString *)streetName
                                    postCode:(nullable NSString *)postCode
                                        town:(nullable NSString *)town
                          countrySubDivision:(nullable NSString *)countrySubDivision
                                     country:(nullable NSString *)country
__deprecated_msg("This method deprecated in favor of initWithAddressLine1:addressLine2 method");

- (nonnull instancetype)initWithAddressLine1:(nullable NSString *)addressLine1
                                addressLine2:(nullable NSString *)addressLine2
                                  streetName:(nullable NSString *)streetName
                                    postCode:(nullable NSString *)postCode
                                        town:(nullable NSString *)town
                          countrySubDivision:(nullable NSString *)countrySubDivision
                                     country:(nullable NSString *)country;

@end

#endif
