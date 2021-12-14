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
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: ViewModel
    @State var currentFlovatar: Flovatar?
    @State var opacity: Double = 0
    @State var activeTab: Int = 0
    @State var isMenuExpanded: Bool = false

    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 1.00, green: 0.00, blue: 0.98), Color(red: 0.26, green: 0.11, blue: 0.56)]),
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                VStack {
                    ZStack(alignment: .bottom) {
                        VStack {
                            Spacer()

                            flovatarsCarousel
                        }

                        Image("Beam")
                            .resizable()
                            .padding(.horizontal)
                            .shimmering()
                            .allowsHitTesting(false)
                    }
                    .frame(height: proxy.size.height / 3 * 2)

                    if let currentFlovatar = currentFlovatar, let name = currentFlovatar.name, !name.isEmpty {
                        Text("name")
                            .foregroundColor(.white)
                            .font(Font.custom("Staatliches-Regular", size: 30))
                            .padding()
                    }

                    if let currentFlovatar = currentFlovatar {
                        boostersView(flovatar: currentFlovatar)
                            .frame(height: 60)
                    }

                    Spacer()

                    nfts
                }
                .background(
                    backgroundGradient
                        .ignoresSafeArea()
                )
                .onChange(of: viewModel.flovatars) { newValue in
                    currentFlovatar = newValue.first
                }

                Color.black
                    .opacity(isMenuExpanded ? 0.4 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(Animation.easeIn(duration: 0.3)) {
                            isMenuExpanded = false
                        }
                    }

                topMenu
            }
        }
        .edgesIgnoringSafeArea(.top)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("flovatar-logo-small")
            }
        }
        .navigationBarItems(
            trailing: Button {
                withAnimation(Animation.easeIn(duration: 0.3)) {
                    isMenuExpanded = !isMenuExpanded
                }
            } label: {
                Image(systemName: isMenuExpanded ? "multiply" : "line.horizontal.3")
                    .resizable()
                    .padding(10)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
        )
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchNFTs()
        }
    }

    @ViewBuilder var nfts: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                LazyHStack(spacing: 0) {
                    ForEach(Array(viewModel.flovatars.enumerated()), id: \.offset) { index, flovatar in
                        if let svg = flovatar.svg, !svg.isEmpty {
                            SVGImage(image: svg)
                                .frame(width: 150, height: 200)
                                .onTapGesture {
                                    currentFlovatar = flovatar
                                }
                                .id(index)
                        }
                    }
                }
                .onChange(of: activeTab, perform: { index in
                    withAnimation {
                        value.scrollTo(index, anchor: .center)
                    }
                })
            }
        }
    }

    @ViewBuilder func boostersView(flovatar: Flovatar) -> some View {
        HStack(spacing: 15) {
            BoosterView(imageName: "booster_1", name: "\(flovatar.rareCount)")
            BoosterView(imageName: "booster_2", name: "\(flovatar.legendaryCount)")
            BoosterView(imageName: "booster_3", name: "\(flovatar.epicCount)")
        }
    }

    @ViewBuilder var topMenu: some View {
        ZStack {
            Color(red: 0.26, green: 0.11, blue: 0.56)
                .opacity(isMenuExpanded ? 1 : 0)

            Button {
                viewModel.logout()
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "")
                    Text(viewModel.address.isEmpty ? "LOGIN" : "LOGOUT")
                        .foregroundColor(.white)
                        .font(Font.custom("Staatliches-Regular", size: 30))
                }
            }
            .padding(.top, 100)
            .opacity(isMenuExpanded ? 1 : 0)

        }
        .clipped()
        .edgesIgnoringSafeArea(.top)
        .frame(height: isMenuExpanded ? 250 : 0)
    }

    @ViewBuilder var flovatarsCarousel: some View {
        if !viewModel.flovatars.isEmpty {
            TabView(selection: $activeTab) {
                ForEach(Array(viewModel.flovatars.enumerated()), id: \.offset) { index, flovatar in
                    if let svg = flovatar.svg, !svg.isEmpty {
                        SVGImage(image: svg)
                            .frame(width: 150, height: 200)
                            .onTapGesture {
                                currentFlovatar = flovatar
                            }
                            .scaleEffect(3.25, anchor: .center)
                            .padding(.bottom)
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: activeTab, perform: { index in
                currentFlovatar = viewModel.flovatars[index]
            })
        }
    }
}
