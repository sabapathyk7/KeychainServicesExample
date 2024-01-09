//
//  UpdateDataView.swift
//  KeychainServicesExample
//
//  Created by kanagasabapathy on 09/01/24.
//

import SwiftUI

struct UpdateDataView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordValue: String = ""

    var body: some View {
        VStack {
            TextField(Constants.usernamePlaceHder, text: $username)
                .customTextField()
            SecureField(Constants.updatePasswordPlaceHder, text: $password)
                .customTextField()
            HStack {
                Spacer()
                Button(Constants.updateDataStr) {
                    viewModel.saveUpdatePassword(username: username, password: password)
                    passwordValue = Constants.updated + viewModel.passwordValue
                }
                .customTextField()
                Spacer()
            }
            Text(passwordValue)
                .customTextValue()
        }
        .navigationTitle(Constants.updateDataStr)
    }
}

#Preview {
    UpdateDataView()
}
