//
//  TCBConfigurationUseCase.swift
//  TCBService
//
//  Created by Huy Van Nguyen on 11/4/20.
//

import TCBDomain

class TCBConfigurationUseCase: ConfigurationUseCase {
    private let configurationClient: TCBConfigurationService

    init(configurationClient: TCBConfigurationService) {
        self.configurationClient = configurationClient
    }
    
    func read(environment: Environment, completion: @escaping TCBResponseCompletion<Configuration>) {
        let configurationRequest = TCBReadConfigurationRequest(environment: environment)
        configurationClient.read(request: configurationRequest) { (result) in
            completion(TCBDomain.TCBResult<Configuration>.from(result))
        }
    }
    
    func write(environment: Environment, configuration: Configuration, completion: @escaping TCBResponseCompletion<Bool>) {
        let configurationRequest = TCBWriteConfigurationRequest(environment: environment, configuration: configuration)
        configurationClient.write(request: configurationRequest) { (result) in
            completion(TCBDomain.TCBResult<Bool>.from(result))
        }
    }
}
