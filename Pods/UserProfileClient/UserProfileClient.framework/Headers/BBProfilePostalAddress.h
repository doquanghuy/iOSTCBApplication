//
//  Created by Backbase R&D B.V. on 16/05/2019.
//
#ifndef UserProfileClient_BBProfilePostalAddress_h
#define UserProfileClient_BBProfilePostalAddress_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Postal Address information of the profile owner.
@interface BBProfilePostalAddress : Additions

/// Unique key identifying the object.
@property (strong, nonatomic, nonnull, readonly) NSString *key;

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

@end

NS_ASSUME_NONNULL_END

#endif
