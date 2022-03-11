//
//  CustomTextInputView.swift
//  MyTestsApp
//
//  Created by Kanyan Zheng on 2022/3/10.
//

import UIKit

class CustomTextInputView: UIView {
    
    static func inputView() -> CustomTextInputView {
        print("height: \(screenHeight)")
        return CustomTextInputView(frame: CGRect(x: 0, y: screenHeight - 50, width: screenWidth, height: 50))
    }
    
    func beginEditing() {
        if textInputView.canBecomeFirstResponder {
            textInputView.becomeFirstResponder()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(hex: "#EEEEEE")
        addSubview(textInputView)
        addSubview(emojiButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emojiButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emojiButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            emojiButton.widthAnchor.constraint(equalToConstant: 40),
            emojiButton.heightAnchor.constraint(equalTo: emojiButton.widthAnchor),
            
            textInputView.leadingAnchor.constraint(equalTo: emojiButton.trailingAnchor, constant: 10),
            textInputView.centerYAnchor.constraint(equalTo: centerYAnchor),
            textInputView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textInputView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private lazy var emojiButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "swift")
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textInputView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
}
