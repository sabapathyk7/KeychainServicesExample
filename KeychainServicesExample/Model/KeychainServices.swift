//
//  KeychainServices.swift
//  KeychainServicesExample
//
//  Created by kanagasabapathy on 09/01/24.
//

import Foundation

protocol KeyChainServiceable {
    func storePassword(username: String, password: String) throws
    func searchPasswordFor(username: String) throws -> String
    func deletePasswordFor(username: String) throws
}
final class KeychainServices: KeyChainServiceable {
    func storePassword(username: String, password: String) throws {

        guard let passwordData = password.data(using: .utf8) else {
            throw KeychainError(type: .incorrectData)
        }
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: passwordData
        ]

        let addKeychainStatus = SecItemAdd(attributes as CFDictionary, nil)
        switch addKeychainStatus {
        case errSecSuccess:
            break
        case errSecDuplicateItem: // Update the password in keychain
            try updatePasswordFor(username: username, newPassword: password)
        default:
            throw KeychainError(status: addKeychainStatus, type: .servicesError)
        }
    }

    func searchPasswordFor(username: String) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        let searchStatus = SecItemCopyMatching(query as CFDictionary, &item)
        guard searchStatus != errSecItemNotFound else {
            throw KeychainError(type: .notFound)
        }
        guard searchStatus == errSecSuccess else {
            throw KeychainError(status: searchStatus, type: .servicesError)
        }
        guard let existingItem = item as? [String: Any],
              let valueData = existingItem[kSecValueData as String] as? Data,
              let value = String(data: valueData, encoding: .utf8) else {
            throw KeychainError(type: .stringConversionError)
        }

        return value
    }

    private func updatePasswordFor(username: String, newPassword: String) throws {

        guard let newPasswordData = newPassword.data(using: .utf8) else {
            return
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username
        ]
        let attributes: [String: Any] = [
            kSecValueData as String: newPasswordData
        ]
        let updateKeychainItemStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard updateKeychainItemStatus != errSecItemNotFound else {
            throw KeychainError(type: .notFound)
        }
        guard updateKeychainItemStatus == errSecSuccess else {
            throw KeychainError(status: updateKeychainItemStatus, type: .servicesError)
        }
    }

    func deletePasswordFor(username: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username
        ]
        let deleteKeychainItemStatus = SecItemDelete(query as CFDictionary)
        guard deleteKeychainItemStatus != errSecItemNotFound else {
            throw KeychainError(type: .notFound)
        }
        guard deleteKeychainItemStatus == errSecSuccess else {
            throw KeychainError(status: deleteKeychainItemStatus, type: .servicesError)
        }
    }
}
