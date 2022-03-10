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
        view.addSubview(htmlTextButton)
        view.addSubview(newTextViewButton)
        
        keyWindow?.addSubview(customTextInputView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            myTextView.widthAnchor.constraint(equalToConstant: 300),
            myTextView.heightAnchor.constraint(equalToConstant: 30),
            
            resignButton.leadingAnchor.constraint(equalTo: myTextView.leadingAnchor),
            resignButton.topAnchor.constraint(equalTo: myTextView.bottomAnchor, constant: 20),
            
            htmlTextButton.leadingAnchor.constraint(equalTo: resignButton.trailingAnchor, constant: 40),
            htmlTextButton.topAnchor.constraint(equalTo: myTextView.bottomAnchor, constant: 20),
            
            newTextViewButton.leadingAnchor.constraint(equalTo: resignButton.leadingAnchor),
            newTextViewButton.topAnchor.constraint(equalTo: resignButton.bottomAnchor, constant: 20),
        ])
    }
    
    // MARK: - Button Action
    
    @objc private func resign() {
        if myTextView.isFirstResponder {
            myTextView.resignFirstResponder()
        } else {
            myTextView.becomeFirstResponder()
        }
    }
    
    @objc private func giveHTML() {
        let htmlString = "www.google.com"
        let string = NSMutableAttributedString(string: htmlString)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.blue,
            .font : UIFont.systemFont(ofSize: 16)
        ]
        string.addAttributes(attributes, range: NSRange(location: 0, length: htmlString.count))
        
        myTextView.attributedText = string
    }
    
    @objc private func newTextView() {
        customTextInputView.isHidden = false
        customTextInputView.beginEditing()
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
        textView.delegate = self
        tap.delegate = self
        
        let toolbarView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 20))
        toolbarView.backgroundColor = .cyan
        textView.inputAccessoryView = toolbarView
        
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
    
    private lazy var htmlTextButton: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "html button"
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.addTarget(self, action: #selector(giveHTML), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var newTextViewButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "New Input"
        configuration.image = UIImage(systemName: "swift")
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.addTarget(self, action: #selector(newTextView), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var customTextInputView: CustomTextInputView = {
        let inputView = CustomTextInputView.inputView()
        inputView.isHidden = true
        return inputView
    }()
}

extension TextViewTestController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

extension TextViewTestController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        // perform your checks and choose what to do with the result.
        false
    }
}
