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
import Foundation
import SwiftUI

// TODO: replace mock API with real API when available

class NFTAPIClient {
    public var url: URL

    init(url: URL) {
        self.url = url
    }

    private func loadJson(url: URL,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        let urlSession = URLSession(configuration: .default).dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            if let data = data {
                completion(.success(data))
            }
        }

        urlSession.resume()
    }

    public func listNFTsForAddress(address: String, completion: @escaping (Result<PaginatedResponse<Flovatar>, Error>) -> Void) {
        
        let fullURL = URLComponents(url: url, resolvingAgainstBaseURL: false)!

        let _ = print(fullURL.url!)

        loadJson(url: fullURL.url!) { result in
            switch result {
            case let .success(data):
                do {
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(PaginatedResponse<Flovatar>.self, from: data)
                    completion(Result.success(response))
                    
                } catch let DecodingError.dataCorrupted(context) {
                    let _ = (context)
                } catch let DecodingError.keyNotFound(key, context) {
                    let _ = print("Key '\(key)' not found:", context.debugDescription)
                    let _ = print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    let _ = print("Value '\(value)' not found:", context.debugDescription)
                    let _ = print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(PaginatedResponse<Flovatar>.self, from: data)
                        completion(Result.success(response))
                    } catch {
                        
                    }
                } catch {
                    let _ = print("error: ", error)
                } catch {
                    // completion(Result.failure(NFTAPIError.invalidResponse))
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

enum NFTAPIError: String, Error, LocalizedError {
    case generic
    case invalidResponse

    public var errorDescription: String? {
        return rawValue
    }
}
