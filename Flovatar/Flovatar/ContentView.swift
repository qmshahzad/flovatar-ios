//
//  FCLDemo
//
//  Copyright 2021 Zed Labs Pty Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import AVKit
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var isShowingDetailView = false

    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 1.00, green: 0.00, blue: 0.98),
                                    Color(red: 0.26, green: 0.11, blue: 0.56)]),
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()

                VStack(spacing: 50) {
                    Image("flovatar-logo")
                        .padding(.bottom)

                    Button {
                        viewModel.authn(provider: .blocto)
                    } label: {
                        HStack(spacing: 15) {
                            Text("Login with")
                                .font(.title2)
                                .foregroundColor(Color.black)
                            Image("blocto_logo")
                        }
                    }
                    .padding()
                    .background(Color(red: 1.00, green: 0.00, blue: 0.98))
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)

                    NavigationLink(
                        destination: DetailView(),
                        isActive: $viewModel.advance
                    ) { EmptyView() }
                }
                .accentColor(Color.white)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
