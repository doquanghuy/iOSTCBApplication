//
//  Created by Backbase R&D B.V. on 13/04/2018.
//

#import <Foundation/Foundation.h>

#ifndef PasswordAuthenticator_h
#define PasswordAuthenticator_h

@class PasswordAuthenticator;

/// Delegate for the PasswordAuthenticator.
@protocol PasswordAuthenticatorDelegate <NSObject>

/**
 Checks whether authentication should be performed.
 
 @return Boolean whether authentication should be performed.
 */
- (BOOL)passwordAuthenticatorShouldAuthenticate:(PasswordAuthenticator * _Nonnull)authenticator;

@end

/// A simple authenticator that can be used when the app makes use of the PasswordAuthClient.
/// The auth client makes use of the delegate to check whether authentication should occur.
/// This makes it easy to disable the authentication for certain use cases, for example when
/// making use of a local data source instead of real services.
@interface PasswordAuthenticator : NSObject

/**
 * Perform authentication if required (see PasswordAuthenticatorDelegate). If authentication was not
 * required, will still indicate authentication was performed successfully in the completion block.
 *
 * @param userId The user id to authenticate
 * @param credentials Credentials (password) to use for authentication
 * @param tokenNames A list of header names that are considered tokens and should be kept
 * @param completionBlock A completion block that is called when authentication is completed
 */
- (void)authenticateIfNeededWithUserId:(nonnull NSString *)userId
                           credentials:(nonnull NSString *)credentials
                            tokenNames:(nonnull NSArray <NSString *> *)tokenNames
                            completion:(nonnull void(^)(BOOL, NSError * _Nullable))completionBlock;

/**
 * Perform authentication if required (see PasswordAuthenticatorDelegate). If authentication was not
 * required, will still indicate authentication was performed successfully in the completion block.
 *
 * @param userId The user id to authenticate
 * @param credentials Credentials (password) to use for authentication
 * @param tokenNames A list of header names that are considered tokens and should be kept
 * @param additionalBodyParameters A dictionary with additional parameters to use when authenticating
 * @param completionBlock A completion block that is called when authentication is completed
 */
- (void)authenticateIfNeededWithUserId:(nonnull NSString *)userId
                           credentials:(nonnull NSString *)credentials
                            tokenNames:(nonnull NSArray <NSString *> *)tokenNames
              additionalBodyParameters:(nullable NSDictionary<NSString *, NSString *> *)additionalBodyParameters
                            completion:(nonnull void(^)(BOOL, NSError * _Nullable))completionBlock;

@property (nonatomic, weak, nullable) id <PasswordAuthenticatorDelegate> delegate;

@end

#endif /* PasswordAuthenticator_h */
