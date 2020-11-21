//
//  Created by Backbase R&D B.V. on 08/04/2019.
//


#import <UserProfileClient/UserProfileClientProtocol.h>

//! Project version number for UserProfileClient.
FOUNDATION_EXPORT double UserProfileClientVersionNumber;

//! Project version string for UserProfileClient.
FOUNDATION_EXPORT const unsigned char UserProfileClientVersionString[];

/// The client to manage user's profile.
@interface UserProfileClient: BBBaseClient <DBSClient, UserProfileClientProtocol>

@end
