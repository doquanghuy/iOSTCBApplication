//
//  Created by Backbase R&D B.V. on 16/05/2019.
//

#ifndef AccessControlClient_BBServiceAgreementParticipantItem_h
#define AccessControlClient_BBServiceAgreementParticipantItem_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Legal Entity that is participant in Service Agreement.
@interface BBServiceAgreementParticipantItem : Additions

/// Legal Entity Id
@property (strong, nonatomic, nonnull, readonly) NSString *identifier;

/// External id of the Legal Entity
@property (strong, nonatomic, nonnull, readonly) NSString *externalId;

/// Name of the Legal Entity
@property (strong, nonatomic, nonnull, readonly) NSString *name;

/// Defines if the Legal Entity shares Users in the Service Agreement
@property (readonly) BOOL sharingUsers;

/// Defines if the Legal Entity shares Accounts in the Service Agreement
@property (readonly) BOOL sharingAccounts;

@end

NS_ASSUME_NONNULL_END

#endif
