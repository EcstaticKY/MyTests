//
//  GestureTestViewController.swift
//  MyTestsApp
//
//  Created by Kanyan Zheng on 2022/3/12.
//

import UIKit

class GestureTestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(maskView)
    }
    
    @objc private func didTapMask() {
        print("did tap mask")
    }
    
    private lazy var maskView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = CustomColor.starBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapMask))
        view.addGestureRecognizer(tap)
        return view
    }()
}
