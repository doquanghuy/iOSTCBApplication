//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef BBApprovalStatus_h
#define BBApprovalStatus_h

#import <Foundation/NSString.h>

/// The options for approval.
typedef NSString *BBApprovalStatus NS_TYPED_ENUM;

extern BBApprovalStatus const kBBApprovalStatusDraft;
extern BBApprovalStatus const kBBApprovalStatusEntered;
extern BBApprovalStatus const kBBApprovalStatusReady;
extern BBApprovalStatus const kBBApprovalStatusAccepted;
extern BBApprovalStatus const kBBApprovalStatusProcessed;
extern BBApprovalStatus const kBBApprovalStatusRejected;
extern BBApprovalStatus const kBBApprovalStatusCancelled;
extern BBApprovalStatus const kBBApprovalStatusCancellationPending;

#endif
