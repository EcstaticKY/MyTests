//
//  UIConstants.swift
//  MyTestsApp
//
//  Created by Kanyan Zheng on 2022/3/10.
//

import UIKit

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

var keyWindow: UIWindow? {
    UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
}
