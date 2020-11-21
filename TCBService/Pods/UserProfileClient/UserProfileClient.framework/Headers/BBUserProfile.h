//
//  Created by Backbase R&D B.V. on 16/05/2019.
//
#ifndef UserProfileClient_BBUserProfile_h
#define UserProfileClient_BBUserProfile_h

#import <CommonUtils/CommonUtils.h>
#import <UserProfileClient/BBPhoneAddress.h>
#import <UserProfileClient/BBElectronicAddress.h>
#import <UserProfileClient/BBProfilePostalAddress.h>

NS_ASSUME_NONNULL_BEGIN

/// Contact addresses of a user
@interface BBUserProfile : Additions

///Full name of the user.
@property (strong, nonatomic, nullable, readonly) NSString *fullName;

///The phone numbers the user can be reached by.
@property (strong, nonatomic, nullable, readonly) NSArray<__kindof BBPhoneAddress*> *phoneAddresses;

///The electronic addresses the user can be reached by.
@property (strong, nonatomic, nullable, readonly) NSArray<__kindof BBElectronicAddress*> *electronicAddresses;

/// The postal addresses the user can be reached by.
@property (strong, nonatomic, nullable, readonly) NSArray<__kindof BBProfilePostalAddress*> *postalAddresses;

@end

NS_ASSUME_NONNULL_END

#endif
