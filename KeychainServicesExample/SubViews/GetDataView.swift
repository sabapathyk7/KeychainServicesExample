//
//  GetDataView.swift
//  KeychainServicesExample
//
//  Created by kanagasabapathy on 09/01/24.
//

import SwiftUI

struct GetDataView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State private var username: String = ""
    @State private var passwordValue: String = ""
    var body: some View {
        VStack {
            TextField(Constants.usernamePlaceHder, text: $username)
                .customTextField()
            HStack {
                Spacer()
                Button(Constants.fetchDataStr) {
                    viewModel.fetchPassword(userName: username)
                    passwordValue = Constants.fetched + viewModel.passwordValue
                }
                .customTextField()
                Spacer()
            }
            Text(passwordValue)
                .customTextValue()
        }
        .navigationTitle(Constants.fetchDataStr)
    }
}

#Preview {
    GetDataView()
}
