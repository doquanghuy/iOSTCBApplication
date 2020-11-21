//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef BBSchemeName_h
#define BBSchemeName_h

#import <Foundation/NSString.h>

/// This describes the type of the account identifier. ID will mean it refers to an account known within DBS.
typedef NSString *BBSchemeName NS_TYPED_ENUM;

extern BBSchemeName const kBBSchemeNameIBAN;
extern BBSchemeName const kBBSchemeNameBBAN;
extern BBSchemeName const kBBSchemeNameID;
extern BBSchemeName const kBBSchemeNameExternalID;

#endif
