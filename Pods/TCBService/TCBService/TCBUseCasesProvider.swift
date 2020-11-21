//
//  TCBUseCasesProvider.swift
//  TCBService
//
//  Created by duc on 10/16/20.
//

import TCBDomain

public class TCBUseCasesProvider: UseCasesProvider {
    public init() {}

    public func makeLoginUseCase() -> LoginUseCase {
        TCBLoginUseCase(authClient: TCBServiceFactory.loadService())
    }

    public func makeAccountUseCase() -> AccountUseCase {
        TCBAccountUseCase()
    }

    public func makeRecentActivityUseCase() -> RecentActivityUseCase {
        TCBRecentActivityUseCase(client: TCBServiceFactory.loadService())
    }
    
    public func makeRegisterUseCase() -> RegisterUseCase {
        TCBRegisterUseCase(authClient: TCBHTTPIdentityAuthClient())
    }
    
    public func makeProfileUseCase() -> ProfileUseCase {
        TCBProfileUseCase(authClient: TCBHTTPIdentityAuthClient())
    }
    
    public func makeConfigurationUseCase() -> ConfigurationUseCase {
        TCBConfigurationUseCase(configurationClient: TCBServiceFactory.loadService())
    }
    
    public func makeProductUseCase() -> ProductUseCase {
        TCBProductSummaryUseCase(client: TCBServiceFactory.loadService())
    }
    
    public func makePaymentUseCase() -> PaymentUseCase {
        TCBPaymentUseCase(client: TCBServiceFactory.loadService())
    }
    
    public func makeFiresbaseUseCase() -> FirebaseUseCase {
        TCBFirebaseUseCase()
    }
    
    public func makeAuditUseCase() -> AuditUseCase {
        TCBAuditUseCase.init(client: TCBDBSClient())
    }

    public func makeContactUseCase() -> DBSContactUseCase {
        TCBContactUseCase(client: TCBServiceFactory.loadService())
    }
}
