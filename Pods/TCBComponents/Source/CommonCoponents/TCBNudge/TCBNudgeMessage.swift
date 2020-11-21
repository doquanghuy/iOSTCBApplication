//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import Foundation

public struct TCBNudgeMessage {
    let title: String
    let subtitle: String
    let type: TCBNudgeType
    let duration: Double
    let tapIcon: UIImage?
    let onTap: (() -> Void)?
    let onDismiss: (() -> Void)?
    
    public init(title: String,
                subtitle: String,
                type: TCBNudgeType,
                duration: Double = 2,
                tapIcon: UIImage? = nil,
                onTap: (() -> Void)? = nil,
                onDismiss: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.duration = duration
        self.tapIcon = tapIcon
        self.onTap = onTap
        self.onDismiss = onDismiss
    }
}
