//
//  Created by Backbase R&D B.V. on 08/04/2019.
//

#import <Foundation/Foundation.h>
#import <UserProfileClient/TypeDefinitions.h>

/// Protocol that enables to access all public client methods.
@protocol UserProfileClientProtocol <NSObject>

/**
 * Gets a user profile for the current user.
 * @param completionHandler A handler to be notified after the profile is retrieved from the client..
 */
- (void)retrieveProfileWithCompletionHandler:(void (^_Nullable)(BBUserProfile * _Nullable, NSError * _Nullable))completionHandler;

#pragma mark - Electronic Addresses

/**
 * Create a new electronic address for the current user.
 * @param electronicAddressRequest The electronic address to be created.
 * @param completionHandler A handler to be notified after a electronic address is created.
 */
- (void)createElectronicAddressWithElectronicAddressRequest:(nonnull BBElectronicAddressRequest*)electronicAddressRequest
                                          completionHandler:(void (^_Nullable)(NSError * _Nullable))completionHandler;


/**
 * Create a new electronic address for the current user.
 * @param electronicAddressKey the electronic address' unique identifier.
 * @param electronicAddressRequest The electronic address to be updated.
 * @param completionHandler A handler to be notified after a electronic address is updated.
 */
- (void)updateElectronicAddressWithElectronicAddressKey:(nonnull NSString*)electronicAddressKey
                               electronicAddressRequest:(nonnull BBElectronicAddressRequest*)electronicAddressRequest
                                      completionHandler:(void (^_Nullable)(NSError * _Nullable))completionHandler;

/**
 * Delete the current user's specified electronic address.
 * @param electronicAddressKey the electronic address' unique identifier.
 * @param completionHandler A handler to be notified after a electronic address is deleted.
 */
- (void)deleteElectronicAddressWithElectronicAddressKey:(nonnull NSString*)electronicAddressKey
                                      completionHandler:(void (^_Nullable)(NSError * _Nullable))completionHandler;

#pragma mark - Phone Addresses

/**
 * Create a new phone address for the current user.
 * @param phoneAddressRequest The phone address to be created.
 * @param completionHandler A handler to be notified after a phone address is created.
 */
- (void)createPhoneAddressWithPhoneAddressRequest:(nonnull BBPhoneAddressRequest*)phoneAddressRequest
                                completionHandler:(void (^_Nullable)(NSError * _Nullable))completionHandler;

/**
 * Create a new phone address for the current user.
 * @param phoneAddressKey the phone address' unique identifier.
 * @param phoneAddressRequest The phone address to be updated.
 * @param completionHandler A handler to be notified after a phone address is updated.
 */
- (void)updatePhoneAddressWithPhoneAddressKey:(nonnull NSString*)phoneAddressKey
                          phoneAddressRequest:(nonnull BBPhoneAddressRequest*)phoneAddressRequest
                            completionHandler:(void (^_Nullable)(NSError * _Nullable))completionHandler;

/**
 * Delete the current user's specified phone address.
 * @param phoneAddressKey the phone address' unique identifier.
 * @param completionHandler A handler to be notified after a phone address is deleted.
 */
- (void)deletePhoneAddressWithPhoneAddressKey:(nonnull NSString*)phoneAddressKey
                            completionHandler:(void (^_Nullable)(NSError * _Nullable))completionHandler;

#pragma mark - Postal Addresses

/**
 * Create a new postal address for the current user.
 * @param postalAddressRequest The postal address to be created.
 * @param completionHandler A handler to be notified after a postal address is created.
 */
- (void)createPostalAddressWithPostalAddressRequest:(nonnull BBProfilePostalAddressRequest*)postalAddressRequest
                                  completionHandler:(void (^_Nullable)(NSError * _Nullable))completionHandler;

/**
 * Update the current user's specified postal address.
 * @param postalAddressKey The user identifier.
 * @param postalAddressRequest The updated postal address.
 * @param completionHandler A handler to be notified after a postal address is updated.
 */
- (void)updatePostalAddressWithPostalAddressKey:(nonnull NSString*)postalAddressKey
                           postalAddressRequest:(nonnull BBProfilePostalAddressRequest*)postalAddressRequest
                              completionHandler:(void (^_Nullable)(NSError * _Nullable))completionHandler;

/**
 * Delete the current user's specified postal address.
 * @param postalAddressKey the postal address' unique identifier.
 * @param completionHandler A handler to be notified after a postal address is deleted.
 */
- (void)deletePostalAddressWithPostalAddressKey:(nonnull NSString*)postalAddressKey
                              completionHandler:(void (^_Nullable)(NSError * _Nullable))completionHandler;

@end
