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
import FCLAuthSwift
import Foundation
import UIKit

class ViewModel: ObservableObject {
    @Published var address: String = ""

    @Published var advance = false
    
    @Published var isLoading: Bool = false

    @Published var isPlayVideo: Bool = false

    @Published var videoURL: URL? = nil

    @Published var flovatars: [Flovatar] = []

    init() {
        fcl.delegate = self

        fcl.config(
            appInfo: FCLAppInfo(
                title: "Flovatar",
                icon: URL(string: "https://flovatar.com/bar.png")!,
                location: URL(string: "https://flovatar.com")!
            ),
            // default provider is  [.dapper, .blocto]
            providers: [.blocto]
        )
    }

    func authn(provider: FCLProvider) {
        // Default provider is dapper
        address = ""
        fcl.authenticate(provider: provider) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.address = data.address
                    self.advance = true
                case let .failure(error):
                    self.address = error.localizedDescription
                    self.advance = false
                }
            }
        }
    }

    // needs to be replaced with blockchain address lookup
    func fetchNFTs() {
        let apiClient = NFTAPIClient(url: URL(string: "https://flovatar.com/collection/api/0x715eba9a0dd9d21a")!)
        //        let apiClient = NFTAPIClient(url: URL(string: "https://flovatar.com/collection/api/" + address)!)
        apiClient.listNFTsForAddress(address: address) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.flovatars = response
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}

extension ViewModel: FCLAuthDelegate {
    func showLoading() {
        isLoading = true
    }

    func hideLoading() {
        isLoading = false
    }
}
