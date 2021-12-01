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
import Shimmer

struct DetailView: View {
    @StateObject var viewModel = ViewModel()
    @State var currentSVG: String = ""

    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 1.00, green: 0.00, blue: 0.98), Color(red: 0.26, green: 0.11, blue: 0.56)]),
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack(alignment: .bottom) {
                    VStack {
                        Spacer()

                        SVGImage(image: currentSVG)
                            .frame(width: 150, height: 200)
                            .scaleEffect(2.5, anchor: .center)
                    }
                    .padding(.bottom, 80)

                    Image("Beam")
                        .resizable()
                        .edgesIgnoringSafeArea(.top)
                        .scaledToFill()
                        .shimmering()
                }
                .frame(height: proxy.size.width / 3 * 2)

                Spacer()

                nfts
                    .frame(height: proxy.size.width / 3)
            }
            .background(
                backgroundGradient
                    .ignoresSafeArea()
            )
            .onChange(of: viewModel.flovatars) { newValue in
                if let svg = newValue.first?.svg {
                    currentSVG = svg
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchNFTs()
        }
    }

    @ViewBuilder var nfts: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(viewModel.flovatars, id: \.self) { flovatar in
                    if let svg = flovatar.svg {
                        SVGImage(image: svg)
                            .frame(width: 150, height: 200)
                            .onTapGesture {
                                currentSVG = svg
                            }
                    }
                }
            }
        }
    }
}
