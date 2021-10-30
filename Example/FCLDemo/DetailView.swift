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
    @ObservedObject var viewModel = ViewModel()
    
    
    let backgroundGradient = LinearGradient(
        
        gradient: Gradient(colors: [Color(red: 1.00, green: 0.00, blue: 0.98), Color(red: 0.26, green: 0.11, blue: 0.56)]),
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationView {
            ZStack {
                        backgroundGradient
                            .ignoresSafeArea()
                        Image("beam")
                            .resizable()
                            .edgesIgnoringSafeArea(.top)
                            .scaledToFit()
                            .shimmering()
                        Spacer()
                        VStack {
//                            NFTs()
                        }
                    }
                    .accentColor(Color.white)
        }
        
    }


    fileprivate func NFTs() -> some View {
        viewModel.fetchNFTs()
        return Section {

            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem()], content: {
                    ForEach(viewModel.nfts, id: \.self) { nft in
                        Button(action: {
                            viewModel.isPlayVideo.toggle()
                            viewModel.videoURL = nft.metadata.topShotImages.black
                        }) {
                            VStack {
                                AsyncImage(url: nft.metadata.image) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 300, height: 450, alignment: .bottom)
                                .cornerRadius(30)
                                .padding(10)

                                Text(nft.metadata.title)
                            }
                        }
                    }
                })
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
