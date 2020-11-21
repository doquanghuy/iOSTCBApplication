//
//  Created by Backbase R&D B.V. on 19/02/2020.
//

#ifndef BBExternalAccountGETResponse_h
#define BBExternalAccountGETResponse_h

#import <Foundation/Foundation.h>
#import <CommonUtils/Additions.h>

@class BBDetailedExternalAccount;

///Server response DTO with a list of BBDetailedExternalAccount instances
@interface BBExternalAccountGETResponse : Additions

/// The collection of external accounts
@property(nonatomic, strong, readonly, nonnull) NSArray<BBDetailedExternalAccount *> *accounts;

@end

#endif
