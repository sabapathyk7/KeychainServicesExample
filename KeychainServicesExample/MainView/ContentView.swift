//
//  ContentView.swift
//  KeychainServicesExample
//
//  Created by kanagasabapathy on 09/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ViewModel = ViewModel()
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Keychain Services")
                .font(.largeTitle)
                .bold()
            Text("Let's test it out")
                .font(.subheadline)
                .bold()
            NavigationStack {
                List {
                    NavigationLink("Save Data") {
                        SaveDataView(viewModel: viewModel)
                    }
                    NavigationLink("Get Data") {
                        GetDataView()
                    }
                    NavigationLink("Update Data") {
                        UpdateDataView()
                    }
                    NavigationLink("Delete Data") {
                        DeleteDataView()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
