//
//  TextViewTestController.swift
//  MyTestsApp
//
//  Created by Kanyan Zheng on 2022/3/9.
//

import UIKit

class TextViewTestController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(myTextView)
        view.addSubview(resignButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            myTextView.widthAnchor.constraint(equalToConstant: 300),
            myTextView.heightAnchor.constraint(equalToConstant: 27),
            
            resignButton.leadingAnchor.constraint(equalTo: myTextView.leadingAnchor),
            resignButton.topAnchor.constraint(equalTo: myTextView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func resign() {
        if myTextView.isFirstResponder {
            myTextView.resignFirstResponder()
        } else {
            myTextView.becomeFirstResponder()
        }
    }
    
    private lazy var myTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .lightGray
        textView.layer.cornerRadius = 2
        textView.layer.masksToBounds = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var resignButton: UIButton = {
        let button = UIButton()
        button.setTitle("RESIGN", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(resign), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
