//
//  TCBConfigurationService.swift
//  TCBService
//
//  Created by Huy Van Nguyen on 11/4/20.
//

import TCBDomain

protocol TCBConfigurationService {
    func read(request: TCBReadConfigurationRequest, completion: @escaping (TCBResult<Configuration>) -> ())
    func write(request: TCBWriteConfigurationRequest, completion: @escaping (TCBResult<Bool>) -> ())
}

struct TCBReadConfigurationRequest {
    var environment: Environment
}

struct TCBWriteConfigurationRequest {
    var environment: Environment
    var configuration: Configuration
}
