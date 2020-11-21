//
//  Created by Backbase R&D B.V. on 09/02/2018.
//

#import <Foundation/Foundation.h>
#import <CommonUtils/CommonUtils.h>
#import <ContactsClient/BBBaseContact.h>

#ifndef ContactItem_h
#define ContactItem_h

@interface ContactItem : BBBaseContact

/// Internally used unique identification of the contact.
@property (strong, nonatomic, nonnull, readonly) NSString *identifier;

- (BOOL)isEqualToContactItem:(ContactItem * _Nullable)contactItem
 __deprecated_msg("This method is deprecated and will be removed on next major release, instead use isEqualTo: method");

@end

#endif /* ContactItem_h */
