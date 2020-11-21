//
//  Created by Backbase R&D B.V. on 08/11/2017.
//

#import <Foundation/Foundation.h>

#ifndef IBANFormatter_h
#define IBANFormatter_h

/// Convenience class for IBAN formatting.
@interface IBANFormatter : NSObject

/**
 Format an IBAN string, will add a space every 4 characters.

 @return The formatted IBAN string.
*/
+ (NSString * _Nullable)formatIBAN:(NSString * _Nullable)iban;

@end

#endif /* IBANFormatter_h */
