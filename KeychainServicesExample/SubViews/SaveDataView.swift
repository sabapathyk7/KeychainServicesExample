//
//  SaveDataView.swift
//  KeychainServicesExample
//
//  Created by kanagasabapathy on 09/01/24.
//

import SwiftUI

struct SaveDataView: View {
    @State private var usernameField = ""
    @State private var passwordField = ""
    @ObservedObject var viewModel: ViewModel
    @State private var passwordValue: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField(Constants.usernamePlaceHder, text: $usernameField)
                .customTextField()
            SecureField(Constants.passwordPlaceHder, text: $passwordField)
                .customTextField()
            HStack {
                Spacer()
                Button(Constants.saveDataStr) {
                    viewModel.saveUpdatePassword(username: usernameField, password: passwordField)
                    passwordValue = Constants.saved + viewModel.passwordValue
                }
                .customTextField()
                Spacer()
            }
            Text(passwordValue)
                .customTextValue()
        }
        .navigationTitle(Constants.saveDataStr)
    }
}

#Preview {
    SaveDataView(viewModel: ViewModel())
}
