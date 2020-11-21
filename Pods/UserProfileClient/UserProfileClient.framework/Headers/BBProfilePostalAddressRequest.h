//
//  Created by Backbase R&D B.V. on 04/09/2019.
//

#ifndef UserProfileClient_BBProfilePostalAddressRequest_h
#define UserProfileClient_BBProfilePostalAddressRequest_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Request class for creating and updating the user's postal address.
@interface BBProfilePostalAddressRequest : Additions

/// Key identifying the type of object.
@property (strong, nonatomic, nonnull, readonly) NSString *type;

/// Flag denoting whether this is the main object.
@property (strong, nonatomic, nullable, readonly) NSNumber* primary;

/// Department.
@property (strong, nonatomic, nullable, readonly) NSString *department;

/// Sub Department.
@property (strong, nonatomic, nullable, readonly) NSString *subDepartment;

/// Address Line.
@property (strong, nonatomic, nullable, readonly) NSString *addressLine;

/// Building number.
@property (strong, nonatomic, nullable, readonly) NSString *buildingNumber;

/// Street.
@property (strong, nonatomic, nullable, readonly) NSString *streetName;

/// Town.
@property (strong, nonatomic, nullable, readonly) NSString *townName;

/// Postcode.
@property (strong, nonatomic, nullable, readonly) NSString *postalCode;

/// Country sub-division.
@property (strong, nonatomic, nullable, readonly) NSString *countrySubDivision;

/// Country code - ISO 3166.
@property (strong, nonatomic, nullable, readonly) NSString *country;

/**
 * Initializes a BBProfilePostalAddressRequest object.
 * @param type Key identifying the type of electronic address, e.g. work or personal.
 * @return The initialized BBProfilePostalAddressRequest object.
 */
- (instancetype _Nonnull)initWithType:(nonnull NSString *)type;

/**
 * Initializes a BBProfilePostalAddressRequest object.
 * @param type Key identifying the type of postal address, e.g. residential, business, po-box, mail-to, delivery-to.
 * @param primary Flag denoting whether this is the main postal address.
 * @param department Department.
 * @param subDepartment Sub Department.
 * @param addressLine Address Line.
 * @param buildingNumber Building number.
 * @param streetName Street.
 * @param townName Town.
 * @param postalCode Postcode.
 * @param countrySubDivision Country sub-division.
 * @param country Country code - ISO 3166.
 * @return The initialized BBProfilePostalAddressRequest object.
 */
- (instancetype _Nonnull)initWithType:(nonnull NSString *)type
                             primary:(nullable NSNumber *)primary
                          department:(nullable NSString *)department
                       subDepartment:(nullable NSString *)subDepartment
                         addressLine:(nullable NSString *)addressLine
                      buildingNumber:(nullable NSString *)buildingNumber
                          streetName:(nullable NSString *)streetName
                            townName:(nullable NSString *)townName
                          postalCode:(nullable NSString *)postalCode
                  countrySubDivision:(nullable NSString *)countrySubDivision
                             country:(nullable NSString *)country;

@end

NS_ASSUME_NONNULL_END

#endif
