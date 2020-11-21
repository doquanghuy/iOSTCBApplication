//
//  TCBValidateTokenServices.swift
//  TCBService
//
//  Created by Son le on 10/30/20.
//

import Domain

protocol TCBValidateTokenServices {
    func checkValidation(completion: @escaping ((TCBResult<User?>) -> Void))
}
