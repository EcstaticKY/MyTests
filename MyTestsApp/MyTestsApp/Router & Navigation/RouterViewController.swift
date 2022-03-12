//
//  RouterViewController.swift
//  MyTestsApp
//
//  Created by Kanyan Zheng on 2022/3/3.
//

import UIKit

class RouterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        title = "Router"
        view.backgroundColor = .cyan
        
        view.addSubview(gotoTextViewButton)
        view.addSubview(gotoBeautifulColorsButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gotoTextViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gotoTextViewButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            gotoBeautifulColorsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gotoBeautifulColorsButton.topAnchor.constraint(equalTo: gotoTextViewButton.bottomAnchor, constant: 20),
        ])
    }
    
    @objc private func goto(sender: UIButton) {
        switch sender.tag {
        case 0:
            let vc = TextViewTestController()
            self.navigationController?.pushViewController(vc, animated: false)
        case 1:
            let vc = BeautifulColorVC()
            self.navigationController?.pushViewController(vc, animated: false)
        default:
            break
        }
        
    }
    
    private lazy var gotoTextViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to text view", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(goto), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var gotoBeautifulColorsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to beautiful colors", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(goto), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

