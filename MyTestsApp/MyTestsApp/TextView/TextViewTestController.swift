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
        addObservers()
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
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: - UI Events
    
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
    
    @objc private func didTapMask() {
        customTextInputView.endEditing()
        customTextInputView.isHidden = true
        maskViewWhileInputing.removeFromSuperview()
    }
    
    // MARK: - Lazy Views
    
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
        
        let button = UIButton()
        button.setTitle("RESIGN", for: .normal)
        button.setTitleColor(CustomColor.starBlue, for: .normal)
        button.addTarget(self, action: #selector(resign), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var htmlTextButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Give HTML", for: .normal)
        button.setTitleColor(CustomColor.prussianBlue, for: .normal)
        button.addTarget(self, action: #selector(giveHTML), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var newTextViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Input", for: .normal)
        button.setTitleColor(CustomColor.bambooGreen, for: .normal)
        button.addTarget(self, action: #selector(newTextView), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var customTextInputView: CustomTextInputView = {
        let inputView = CustomTextInputView.inputView()
        inputView.isHidden = true
        return inputView
    }()
    
    private lazy var maskViewWhileInputing: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapMask))
        view.addGestureRecognizer(tap)
        return view
    }()
}

extension TextViewTestController {
    @objc func keyboardWillShow(sender: Notification) {
        
        if let userInfo = sender.userInfo, let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            view.addSubview(maskViewWhileInputing)
            let keyboardHeight = keyboardEndFrame.size.height
            customTextInputView.frame = CGRect(x: 0, y: screenHeight - keyboardHeight - 50, width: screenWidth, height: 50)
        }
    }
    
    @objc private func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            view.addSubview(maskViewWhileInputing)
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                //Change This
                //self.signInButtonBottomConstraint?.constant = 0.0
                customTextInputView.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: 50)
            } else {
                //Modify This
                //self.signInButtonBottomConstraint?.constant -= (endFrame?.size.height ?? 0.0)
                let keyboardHeight = endFrame?.size.height ?? 0.0
                customTextInputView.frame = CGRect(x: 0, y: screenHeight - keyboardHeight - 50, width: screenWidth, height: 50)
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}

extension TextViewTestController: UIGestureRecognizerDelegate {
    @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
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
