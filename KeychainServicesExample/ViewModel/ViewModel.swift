//
//  ViewModel.swift
//  KeychainServicesExample
//
//  Created by kanagasabapathy on 09/01/24.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var keychainError: String = String()
    @Published var passwordValue: String  = String()

    private let keychainService: KeyChainServiceable
    init(keychainService: KeyChainServiceable = KeychainServices()) {
        self.keychainService = keychainService
    }
    private func resetValues() {
        keychainError = ""
        passwordValue = ""
    }
}

extension ViewModel {
    func fetchPassword(userName: String) {
        let keychainServices = KeychainServices()
        resetValues()
        do {
            let password = try keychainServices.searchPasswordFor(username: userName)
            passwordValue =  password
        } catch let error as KeychainError {
            print("Exception fetching password: \(error.errorMessage ?? Constants.noMessage)")
            keychainError = error.errorMessage ?? "error"
        } catch {
            print(error)
        }
    }
    func saveUpdatePassword(username: String, password: String) {
        let keychainServices = KeychainServices()
        resetValues()
        do {
            try keychainServices.storePassword(username: username, password: password)
            passwordValue = password
        } catch let error as KeychainError {
            print("Exception setting/updating password: \(error.errorMessage ?? Constants.noMessage)")
        } catch {
            print(error)
        }
    }
    func deletePassword(username: String) {
        let keychainServices = KeychainServices()
        resetValues()
        do {
            try keychainServices.deletePasswordFor(username: username)
            passwordValue = username
        } catch let error as KeychainError {
            print("Exception Deleting password: \(error.errorMessage ?? Constants.noMessage)")
        } catch {
            print(error)
        }
    }
}
