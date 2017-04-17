//
//  NetworkClient.swift
//  GitHubUsers
//
//  Created by Kapam6a on 13.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

protocol NetworkClient {
    func send(request: URLRequest, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void)
}

class NetworkClientImplementation: NetworkClient {
    
    //MARK : NetworkClient
    
    func send(request: URLRequest, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    success(data)
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }.resume()
    }
}
