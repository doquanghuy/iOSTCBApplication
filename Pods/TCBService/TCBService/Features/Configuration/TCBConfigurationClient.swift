//
//  TCBConfigurationClient.swift
//  TCBService
//
//  Created by Huy Van Nguyen on 11/4/20.
//

import Foundation
import TCBDomain

class TCBConfigurationClient: NSObject {
    
}

extension TCBConfigurationClient: TCBConfigurationService {
    func write(request: TCBWriteConfigurationRequest, completion: @escaping (TCBResult<Bool>) -> ()) {
        if writeJson(request.environment.fileName, request.configuration) {
            completion(.success(true))
        } else {
            completion(.success(false))
        }
    }
    
    func read(request: TCBReadConfigurationRequest, completion: @escaping (TCBResult<Configuration>) -> ()) {
        if let configuration = loadJson(request.environment.fileName) {
            completion(.success(configuration))
        } else {
            completion(.failure(APIError.unknown))
        }
    }
    
    private func loadJson(_ fileName: String?) -> Configuration? {
        if let documentsUrl: URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first, let fileName = fileName {
            let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)

            do {

                let data = try Data(contentsOf: destinationFileUrl, options: [])
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Configuration.self, from: data)
                return jsonData
            }catch {
                print(error)
            }
        }
        return nil
    }
    
    private func writeJson(_ fileName: String?,_ configuration: Configuration) -> Bool {
        if let documentsUrl: URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first, let fileName = fileName {
            let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
            do {
                let data = try JSONEncoder().encode(configuration)
                try data.write(to: destinationFileUrl)
            }catch {
                print(error)
                return false
            }
        }
        return true
    }
}
