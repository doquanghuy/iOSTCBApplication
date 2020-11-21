//
//  Created by Backbase R&D B.V. on 09/02/2018.
//

#import <UIKit/UIKit.h>
#import <Backbase/Backbase.h>

//! Project version number for ContactsClient.
FOUNDATION_EXPORT double ContactsClientVersionNumber;

//! Project version string for ContactsClient.
FOUNDATION_EXPORT const unsigned char ContactsClientVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ContactsClient/PublicHeader.h>
#import <ContactsClient/TypeDefinitions.h>

@protocol ContactsClientProtocol <NSObject>

/**
 * Retrieve all contacts.
 * @discussion: the parameters can be one of the following keys:
 * saId     String (optional)   The service agreement id that the user is acting in.
 * leId     String (optional)   The legal entity id that the user is acting in.
 * cursor   String (optional)   Record UUID
 * from     Number (optional)   Page Number
 * size     Number (optional)   Limit the number of elements on the response. Default is 10.
 * query    String (optional)   The search term used to search for contacts by their name.
 * @param parameters A dictionary containing AT LEAST a key saId with its respective value.
 * @param completionHandler A handler to be notified after the contacts is retrieved from the client.
 */
- (void)retrieveContacts:(NSDictionary<NSString *, NSString *> *_Nonnull)parameters
    completionHandler:(void (^_Nullable)(NSArray<ContactItem *> *_Nullable contacts,
                                         NSError *_Nullable error))completionHandler;

/**
 * Retrieve contact by identifier.
 * @param contactId The contact identifier
 * @param completionHandler A handler to be notified after the contacts is retrieved from the client.
 */
- (void)retrieveContactById:(NSString *_Nonnull)contactId
          completionHandler:(void (^_Nullable)(ContactItem *_Nullable contact,
                                               NSError *_Nullable error))completionHandler;

/**
 * Create a contact
 * @param contact The contact to create
 * @param completionHandler A handler to be notified after a contact is created.
 */
- (void)createContact:(ContactItem *_Nonnull)contact
    completionHandler:(void (^_Nullable)(NSString *_Nullable, NSError *_Nullable))completionHandler
__deprecated_msg("This method is deprecated and will be removed on next major release, \
                 instead use createContact:withCompletionHandler: method");

/**
 * Create a contact
 * @param contact The contact to create
 * @param completionHandler A handler to be notified after a contact is created.
 */
- (void)createWithContact:(BBContact *_Nonnull)contact
       completionHandler:(void (^_Nullable)(NSString *_Nullable, NSError *_Nullable))completionHandler;

/**
 * Update a contact
 * @param contact The contact to update
 * @param completionHandler A handler to be notified after a contact is updated.
 */
- (void)updateContact:(ContactItem *_Nonnull)contact
    completionHandler:(void (^_Nullable)(BOOL, NSError *_Nullable))completionHandler;

/**
 * Delete a contact
 * @param contactId The contact identifier
 * @param completionHandler A handler to be notified after a contact is deleted.
 */
- (void)deleteContactById:(NSString *_Nonnull)contactId
        completionHandler:(void (^_Nullable)(BOOL, NSError *_Nullable))completionHandler;

@end

@interface ContactsClient: BBBaseClient <DBSClient, ContactsClientProtocol, RecipientContract>
@end
