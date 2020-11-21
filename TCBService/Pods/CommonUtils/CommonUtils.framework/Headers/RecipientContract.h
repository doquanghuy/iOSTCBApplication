//
//  Created by Backbase R&D B.V. on 27/03/2018.
//

#import <Foundation/Foundation.h>
#import <CommonUtils/RecipientListener.h>

#ifndef RecipientContract_h
#define RecipientContract_h

/// Contract to be used when a list of given objects needs to be converted to list of RecipientModel.
@protocol RecipientContract <NSObject>
/**
 * Method that gets a list of recipient to be displayed in the product selector.
 *
 * @param params map that contain server parameters.
 * @param typeIdentifier string that would identify the type of recipient
 * @param recipientListener notify the confirming object if the list retrieval fail or succeeded.
 */
- (void)getRecipients:(NSDictionary<NSString*, NSString*> *)params
       withIdentifier:(NSString*)typeIdentifier
 andRecipientListener:(id<RecipientListener>)recipientListener;

/**
 * Check if the pagination is supported by the client.
 * @return if the pagination is supported.
 */
- (BOOL)isPaginationSupported;

@end

#endif /* RecipientContract_h */
