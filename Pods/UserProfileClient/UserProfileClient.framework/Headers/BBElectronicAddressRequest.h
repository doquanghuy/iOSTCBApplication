//
//  Created by Backbase R&D B.V. on 06/09/2019.
//

#ifndef UserProfileClient_BBElectronicAddressRequest_h
#define UserProfileClient_BBElectronicAddressRequest_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Request class for creating and updating the user's electronic address.
@interface BBElectronicAddressRequest : Additions

/// Key identifying the type of object.
@property (strong, nonatomic, nonnull, readonly) NSString *type;

/// Address.
@property (strong, nonatomic, nonnull, readonly) NSString *address;

/// Flag denoting whether this is the main object.
@property (strong, nonatomic, nullable, readonly) NSNumber* primary;

/**
 * Initializes a BBElectronicAddressRequest object.
 * @param type Key identifying the type of electronic address, e.g. work or personal.
 * @param address Address.
 * @return The initialized BBElectronicAddressRequest object.
 */
- (instancetype _Nonnull)initWithType:(nonnull NSString *)type
                              address:(nonnull NSString *)address;

/**
 * Initializes a BBElectronicAddressRequest object.
 * @param type Key identifying the type of electronic address, e.g. work or personal.
 * @param address Address.
 * @param primary Flag denoting whether this is the main electronic address.
 * @return The initialized BBElectronicAddressRequest object.
 */
- (instancetype _Nonnull)initWithType:(nonnull NSString *)type
                              address:(nonnull NSString *)address
                              primary:(nullable NSNumber *)primary;

@end

NS_ASSUME_NONNULL_END

#endif
