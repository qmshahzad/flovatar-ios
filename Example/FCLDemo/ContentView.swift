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
    @ObservedObject var viewModel = ViewModel()
    @State var advance = false
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 1.00, green: 0.00, blue: 0.98), Color(red: 0.26, green: 0.11, blue: 0.56)]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        
        NavigationView {
            ZStack {
                    backgroundGradient
                    .ignoresSafeArea()
                    VStack {
                        Image("flovatar-logo").padding(.bottom)
                        NavigationLink(destination: DetailView(), isActive: $advance) {
                            Button("Login with Blocto") {
                                viewModel.authn(provider: .blocto)
                            }
                            .padding()
                            .background(Color(red: 0.26, green: 0.11, blue: 0.56))
                            .clipShape(Capsule())
                            if viewModel.isLoading {
                                ProgressView()
                            } else {
                                Text(verbatim: viewModel.address)
                                .navigationBarHidden(true)
                            }
                        }
                    }
                    .accentColor(Color.white)
            }
                        
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
