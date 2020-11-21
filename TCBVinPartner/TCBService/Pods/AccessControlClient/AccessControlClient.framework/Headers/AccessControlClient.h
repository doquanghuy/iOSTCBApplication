//
//  Created by Backbase R&D B.V. on 04/07/2018.
//

#import <UIKit/UIKit.h>
#import <Backbase/Backbase.h>

//! Project version number for AccessControlClient.
FOUNDATION_EXPORT double AccessControlClientVersionNumber;

//! Project version string for AccessControlClient.
FOUNDATION_EXPORT const unsigned char AccessControlClientVersionString[];

#import <AccessControlClient/TypeDefinitions.h>

#pragma mark - AccessControl Client Contract

@protocol AccessControlClientProtocol <NSObject>

/**
 Convenience method for retrieving a list of service agreements for the current user with the default query params.
 @param completionHandler A callback method that either returns an array of ServiceAgreementPartialItem objects, or an NSError.
 @see -retrieveServiceAgreementsWithParams:completionHandler:
 */
- (void)retrieveServiceAgreements:(nullable void (^)(NSArray<ServiceAgreementPartialItem *> * _Nullable serviceAgreements,
                                                     NSError * _Nullable error))completionHandler;

/**
 Method for retrieving a list of service agreements for the current user.
 
 Params could be
 query (string)  - The search term used to search.
 from (integer)  - Page Number. Skip over pages of elements by specifying a start value for the query. (default: 0)
 cursor (string) - Record UUID. As an alternative for specifying 'from' this allows to point to the record to start the selection from.
 size (integer)  - Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative
 number to indicate requesting records upwards from the starting point indicated by the cursor. (default: 10)
 
 @param params A dictionary containing key - value pairs of query items.
 @param completionHandler A callback method that either returns an array of ServiceAgreementPartialItem objects, or an NSError.
 */
- (void)retrieveServiceAgreementsWithParams:(nullable NSDictionary *)params
                          completionHandler:(nullable void (^)(NSArray<ServiceAgreementPartialItem *> * _Nullable serviceAgreements,
                                                               NSError * _Nullable error))completionHandler;

/**
 Convenience method for retrieving Legal Entities that are participants in Service Agreement.
 @param serviceAgreementId The identifier of the service agreement for which the list of legal entities should be returned.
 @param completionHandler A callback method that either returns an array of BBServiceAgreementParticipantItem objects, or an NSError.
 */
- (void)retrieveParticipantsForServiceAgreementWithId:(nonnull NSString *)serviceAgreementId
                                    completionHandler:(nullable void (^)(NSArray<BBServiceAgreementParticipantItem *>
                                                                         * _Nullable participants,
                                                                         NSError * _Nullable error))completionHandler;

/**
 Method for creating a user context for the current user, with the provided service agreement and legal entity.
 
 @param serviceAgreementId The identifier of the service agreement.
 @param legalEntityId The identifier of the legal entity object.
 @param completionHandler A callback method that either returns a dictionary of 'Set-Cookie' headers that contain the user context,
 or an NSError.
 */
- (void)createUserContextWithServiceAgreementId:(nonnull NSString *)serviceAgreementId
                                  legalEntityId:(nullable NSString *)legalEntityId
                              completionHandler:(nullable void (^)(NSDictionary<NSString*, NSString*> * _Nullable cookies,
                                                                   NSError * _Nullable error))completionHandler;

/**
 Convenience method for generating a user context for the current user. This method calls -retrieveServiceAgreements:completionHandler:
 and takes the first service agreement available. With the retrieved service agreement it calls
 the -createUserContextWithServiceAgreementId:legalEntityId:completionHandler: method.
 
 @param completionHandler A callback method that either returns a dictionary of 'Set-Cookie' headers that contain the user context,
 or an NSError.
 */
- (void)generateUserContext:(nullable void (^)(NSDictionary<NSString*, NSString*> * _Nullable cookies,
                                               NSError * _Nullable error))completionHandler;

@end

#pragma mark - AccessControl Client declaration

@interface AccessControlClient: BBBaseClient <DBSClient, AccessControlClientProtocol>

@end
