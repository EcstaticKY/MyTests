//
//  JustLoader.swift
//  MyTests
//
//  Created by Kanyan Zheng on 2022/2/21.
//

import Foundation

@objc public protocol JustClient {
    func just()
}

public class JustLoader: NSObject {
    let client: JustClient
    
    public init(client: JustClient) {
        self.client = client
    }
    
    @objc public func justLoad() {
        client.just()
    }
}
