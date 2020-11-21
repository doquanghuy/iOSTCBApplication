// 
//  BBIdentityChallengeResolver.h
//  Backbase
//
//  Created by Backbase B.V. on 27/02/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Backbase/Backbase.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef BBIDENTITYCHALLENGERESOLVER_CLASS
#define BBIDENTITYCHALLENGERESOLVER_CLASS

/// Error response resolver that can handle WWW-authenticate challenges
@interface BBIdentityChallengeResolver : NSObject <ErrorResponseResolver>

/**
 * Initializes the error response resolver to handle predefined challenges provided by Identity. For example,
 * device-key, device-signature, otp-choice, otp-verify, uaf-reg.
 * @discussion This error response resolver will check the response and data, if the response does not contain a
 * WWW-authenticate header with a challenge, it will forward the implementation to the super class
 * (BBOAuth2InvalidAccessTokenResolver) to check if the 401 is due to an access token being expired and requiring to be
 * refreshed.
 * In case of contain a WWW-Authenticate header with a challenge, this resolver will attempt to locate the appropriated
 * handler for such challenge (see list above), and delegate the handling to that handler.
 * If you need to extend the functionality of this class; either to add extra checks without losing the challenge
 * handling, your implementation should override the <pre>handle</pre> method, check for the condition you need to
 * handle, and if not met delegate to the super implementation (a.k.a. this class).
 * @param authClient OAuth2 Auth client compatible reference
 * @param headers Additional headers that need to be passed whenever the access token needs to be refreshed
 * @param scope Scope to be added to the refresh access token request.
 */
- (instancetype)initWithAuthClient:(NSObject<OAuth2AuthClient>*)authClient
                      extraHeaders:(NSDictionary<NSString*, NSString*>* _Nullable)headers
                             scope:(NSString* _Nullable)scope;
@end

#endif
NS_ASSUME_NONNULL_END
