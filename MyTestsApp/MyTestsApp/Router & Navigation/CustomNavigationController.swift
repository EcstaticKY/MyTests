//
//  CustomNavigationController.swift
//  MyTestsApp
//
//  Created by Kanyan Zheng on 2022/3/9.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavBar() {
//        let navBarAppearence = UINavigationBarAppearance()
//        navBarAppearence.configureWithOpaqueBackground()
//        navBarAppearence.backgroundColor = UIColor(hex: "#EEEEEE")
//        navBarAppearence.titleTextAttributes = [
//            .foregroundColor : UIColor.black,
//        ]
//        
//        navigationBar.standardAppearance = navBarAppearence
//        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
