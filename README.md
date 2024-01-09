# iOS Keychain Services

## Overview

This iOS app demonstrates the usage of Keychain services for secure storage and retrieval of sensitive information, such as passwords. The app provides functionality to save, fetch, update, and delete passwords securely using Apple's Keychain services.

## Features

- **Save Password:** securely store passwords in the Keychain.
- **Fetch Password:** retrieve saved passwords from the Keychain.
- **Update Password:** update existing passwords in the Keychain.
- **Delete Password:** remove passwords from the Keychain.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/sabapathyk7/KeychainServicesExample.git
2. Open the Xcode project:
     ```bash
    cd KeychainServicesExample
    open KeychainServicesExample.xcodeproj
3. Build and run the app on a simulator or physical device.


## Examples
Saving a Password:
   
     let addKeychainStatus = SecItemAdd(attributes as CFDictionary, nil)
        switch addKeychainStatus {
        case errSecSuccess:
            break
        case errSecDuplicateItem: // Update the password in keychain
            try updatePasswordFor(username: username, newPassword: password)
        default:
            throw KeychainError(status: addKeychainStatus, type: .servicesError)
        }

Updating a Password:
   
     let updateKeychainItemStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

Fetching a Password:
   
     let searchStatus = SecItemCopyMatching(query as CFDictionary, &item)
     
Deleting the password:
   
     let deleteKeychainItemStatus = SecItemDelete(query as CFDictionary)

     
## Acknowledgments
[Apple Keychain Services Documentation](https://developer.apple.com/documentation/security/keychain_services)

## Connect with Me
Stay updated on the latest features and releases by following me on [LinkedIn](https://www.linkedin.com/in/sabapathy7/).
