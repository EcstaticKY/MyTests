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
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        if let textView = sender.view as? UITextView {
            let layoutManager = textView.layoutManager
            var location = sender.location(in: textView)
            location.x -= textView.textContainerInset.left
            location.y -= textView.textContainerInset.top
            
            let characterIndex = layoutManager.characterIndex(for: location, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
            
            guard let text = textView.text else { return }
            print(text)
            
            if characterIndex < textView.textStorage.length {
                print(characterIndex)
            }
        }
    }
    
    private lazy var myTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .lightGray
        textView.layer.cornerRadius = 2
        textView.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        textView.addGestureRecognizer(tap)
        tap.delegate = self
        
        textView.isUserInteractionEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var resignButton: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "RESIGN"
        configuration.subtitle = "Great Try"
        configuration.image = UIImage(systemName: "swift")
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.addTarget(self, action: #selector(resign), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension TextViewTestController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
