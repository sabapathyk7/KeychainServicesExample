//
//  KeychainError.swift
//  KeychainServicesExample
//
//  Created by kanagasabapathy on 09/01/24.
//

import Foundation

struct KeychainError: Error {
    var errorMessage: String?
    var type: KeychainErrorType
    enum KeychainErrorType {
        case servicesError
        case notFound
        case stringConversionError
        case incorrectData
    }

    init(status: OSStatus, type: KeychainErrorType) {
        self.type = type
        if let message = SecCopyErrorMessageString(status, nil) {
            self.errorMessage = String(message)
        } else {
            self.errorMessage = "Status Code: \(status)"
        }
    }

    init(type: KeychainErrorType) {
        self.type = type
    }

    init(errorMessage: String, type: KeychainErrorType) {
        self.type = type
        self.errorMessage = errorMessage
    }
}
