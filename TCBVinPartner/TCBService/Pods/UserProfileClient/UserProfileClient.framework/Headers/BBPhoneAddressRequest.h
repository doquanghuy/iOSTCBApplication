//
//  Created by Backbase R&D B.V. on 05/09/2019.
//

#ifndef UserProfileClient_BBPhoneAddressRequest_h
#define UserProfileClient_BBPhoneAddressRequest_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Request class for creating and updating the user's phone address.
@interface BBPhoneAddressRequest : Additions

/// Key identifying the type of object.
@property (strong, nonatomic, nonnull, readonly) NSString *type;

/// Phone number.
@property (strong, nonatomic, nonnull, readonly) NSString *number;

/// Flag denoting whether this is the main object.
@property (strong, nonatomic, nullable, readonly) NSNumber* primary;

/**
 * Initializes a BBPhoneAddressRequest object.
 * @param type Key identifying the type of phone number, e.g. mobile or land line.
 * @param number Phone number.
 * @return The initialized BBPhoneAddressRequest object.
 */
- (instancetype _Nonnull)initWithType:(nonnull NSString *)type
                               number:(nonnull NSString *)number;

/**
 * Initializes a BBPhoneAddressRequest object.
 * @param type Key identifying the type of phone number, e.g. mobile or land line.
 * @param primary Flag denoting whether this is the main phone number.
 * @param number Phone number.
 * @return The initialized BBPhoneAddressRequest object.
 */
- (instancetype _Nonnull)initWithType:(nonnull NSString *)type
                               number:(nonnull NSString *)number
                              primary:(nullable NSNumber *)primary;

@end

NS_ASSUME_NONNULL_END

#endif
