//
//  Created by Backbase R&D B.V. on 17/02/2020.
//

#import <Foundation/Foundation.h>

@class BBDetailedExternalAccount;

typedef void(^ExternalAccountsHandler)(NSArray<BBDetailedExternalAccount *> * _Nullable, NSError * _Nullable);

/// An interface of an object that is capable of interacting withe the external accounts service
@protocol ExternalAccountsContract <NSObject>

@required

/// This method is used to retrieve the external accounts of the user
///
/// @param completionHandler a block invoked upon completion of the external accounts API call.
- (void)retrieveExternalAccountsWithCompletionHandler:(nonnull ExternalAccountsHandler)completionHandler;

@end
