//
//  Created by Backbase R&D B.V. on 27/03/2018.
//

#import <Foundation/Foundation.h>

#ifndef RecipientModel_h
#define RecipientModel_h

/// The class that allows similar classes to be parsed into one single class type.
@interface RecipientModel : NSObject <NSCopying>

/// Identifier of the object.
@property (strong, nonatomic) NSString *objectId;

/// Account name.
@property (strong, nonatomic) NSString *accountName;

/// Account number when there is a single account number.
@property (strong, nonatomic) NSString *accountNumber;

/// Type of the object. (Class name).
@property (strong, nonatomic) NSString *objectType;

/// JSON string of the object that this class represents.
@property (strong, nonatomic) NSString *rawString;

/// Balance of the object
@property (strong, nonatomic) NSString *balance;

/// The type identifier for the object, to send right event when selected
@property (strong, nonatomic) NSString *typeIdentifier;

/// Currency code of the object.
@property (strong, nonatomic) NSString *currency;

@end

#endif /* RecipientModel_h */

