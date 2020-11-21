//
//  Created by Backbase R&D B.V. on 05/03/2018.
//

#ifndef ContactsClientErrors_h
#define ContactsClientErrors_h

FOUNDATION_EXPORT NSErrorDomain const ContactsClientErrorDomain;

NS_ERROR_ENUM(ContactsClientErrorDomain) {
    ContactsClientErrorFailedToCreateContact = -1000, // The AuthClient does not conform the PasswordAuthClient protocol.
};

#endif /* ContactsClientError_h */
