//
//  JustLoaderComposer.swift
//  MyTests
//
//  Created by Kanyan Zheng on 2022/2/21.
//

import Foundation

public class JustLoaderComposer: NSObject {
    @objc public static func composed(client: JustClient) -> JustLoader {
        JustLoader(client: client)
    }
}
