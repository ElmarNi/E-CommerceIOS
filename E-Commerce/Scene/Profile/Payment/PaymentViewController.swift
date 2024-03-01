//
//  PaymentViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 09.02.24.
//

import UIKit

class PaymentViewController: UIViewController {
    var onAction: ((Bool, String?) -> Void)? = nil
    private let cardHolderNameLabel = UserLabel(text: "Card Holder Name")
    private let cardHolderNameTextField = PaddedTextField(placeholder: "Enter card holder name")
    private let cardHolderNameError = ErrorLabel(text: "Please enter card holder name")
    
    private let cardNumberLabel = UserLabel(text: "Card Number")
    private let cardNumberTextField = PaddedTextField(placeholder: "4111 1111 1111 1111")
    private let cardNumberError = ErrorLabel()
    
    private let expirationLabel = UserLabel(text: "Expiration")
    private let expirationTextField = PaddedTextField(placeholder: "MM/YY")
    private let expirationError = ErrorLabel(text: "Please enter expiration")
    
    private let cvvLabel = UserLabel(text: "CVV")
    private let cvvTextField = PaddedTextField(placeholder: "123")
    private let cvvError = ErrorLabel()
    
    private let saveButton = RoundedButton(title: "Save")
    private var loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Payment Method"
        view.backgroundColor = .systemBackground
        view.addSubview(cardHolderNameLabel)
        view.addSubview(cardHolderNameTextField)
        view.addSubview(cardHolderNameError)
        
        view.addSubview(cardNumberLabel)
        view.addSubview(cardNumberTextField)
        view.addSubview(cardNumberError)
        
        view.addSubview(expirationLabel)
        view.addSubview(expirationTextField)
        view.addSubview(expirationError)
        
        view.addSubview(cvvLabel)
        view.addSubview(cvvTextField)
        view.addSubview(cvvError)
        
        view.addSubview(saveButton)
        view.addSubview(loadingView)
        
        cardNumberTextField.keyboardType = .numberPad
        cardNumberTextField.tag = 0
        expirationTextField.keyboardType = .numberPad
        expirationTextField.tag = 1
        cvvTextField.keyboardType = .numberPad
        cvvTextField.tag = 2
        setupUI()
        payment()
        
        for case let textField as UITextField in view.subviews {
            textField.delegate = self
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        guard let cardHolder = cardHolderNameTextField.text,
              let cardNumber = cardNumberTextField.text,
              let expDate = expirationTextField.text,
              let cvv = cvvTextField.text
        else { return }
        var isError = cardHolder.isEmpty
        
        cardHolderNameError.isHidden = !cardHolder.isEmpty
        cardHolder.isEmpty ? cardHolderNameTextField.layer.borderColor = UIColor.red.cgColor : nil
        
        cardNumberError.isHidden = true
        expirationError.isHidden = true
        cvvError.isHidden = true
        
        if cardNumber.isEmpty {
            cardNumberError.isHidden = false
            cardNumberError.text = "Please enter card number"
            cardNumberTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        else if cardNumber.count < 16 {
            cardNumberError.isHidden = false
            cardNumberError.text = "Card number must be 16 digits"
            cardNumberTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        
        if expDate.isEmpty {
            expirationError.isHidden = false
            expirationError.text = "Please enter expiration"
            expirationTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        else if let errorString = expDateValidation(dateStr: expDate) {
            expirationError.isHidden = false
            expirationError.text = errorString
            expirationTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        
        if cvv.isEmpty {
            cvvError.isHidden = false
            cvvError.text = "Please enter CVV"
            cvvTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        else if cvv.count < 3 {
            cvvError.isHidden = false
            cvvError.text = "CVV must be 3 digits"
            cvvTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        
        if isError {
            if onAction == nil {
                loadingView.changeSpinnerAndBGColor(spinnerColor: .white, bgColor: .black.withAlphaComponent(0.8))
            }
            else {
                loadingView.changeSpinnerAndBGColor(spinnerColor: .systemGray, bgColor: .white)
            }
            loadingView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
                self?.loadingView.isHidden = true
                if let onAction = self?.onAction {
                    onAction(true, "Payment method succesfully changed")
                }
                else {
                    self?.showAlert(title: "Success", message: "Payment method succesfully changed")
                }
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func expDateValidation(dateStr:String) -> String? {
        let currentYear = Calendar.current.component(.year, from: Date()) % 100
        let currentMonth = Calendar.current.component(.month, from: Date())

        let enteredYear = Int(dateStr.suffix(2)) ?? 0
        let enteredMonth = Int(dateStr.prefix(2)) ?? 0
        
        if enteredYear > currentYear {
            if !(1 ... 12).contains(enteredMonth) {
                return "Entered Date Is Wrong"
            }
        } else if currentYear == enteredYear {
            if enteredMonth >= currentMonth {
                if !(1 ... 12).contains(enteredMonth) {
                    return "Entered Date Is Wrong"
                }
            } else {
                return "Entered Date Is Wrong"
            }
        } else {
           return "Entered Date Is Wrong"
        }
        
        return nil
    }
    
    private func payment() {
        loadingView.changeSpinnerAndBGColor(spinnerColor: .systemGray, bgColor: .systemBackground)
        loadingView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
            self?.loadingView.isHidden = true
        }
    }
    
    private func setupUI() {
        cardHolderNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        cardHolderNameTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(cardHolderNameLabel.snp.bottom).offset(8)
        }
        
        cardHolderNameError.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(cardHolderNameTextField.snp.bottom).offset(8)
        }
        
        cardNumberLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(cardHolderNameError.snp.bottom).offset(8)
        }
        
        cardNumberTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(cardNumberLabel.snp.bottom).offset(8)
        }
        
        cardNumberError.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(8)
        }
        
        expirationLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().dividedBy(2).offset(-20)
            make.top.equalTo(cardNumberError.snp.bottom).offset(8)
        }
        
        expirationTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().dividedBy(2).offset(-20)
            make.top.equalTo(expirationLabel.snp.bottom).offset(8)
        }
        
        expirationError.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().dividedBy(2).offset(-20)
            make.top.equalTo(expirationTextField.snp.bottom).offset(8)
        }
        
        cvvLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.width.equalToSuperview().dividedBy(2).offset(-20)
            make.top.equalTo(cardNumberError.snp.bottom).offset(8)
        }
        
        cvvTextField.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.width.equalToSuperview().dividedBy(2).offset(-20)
            make.top.equalTo(cvvLabel.snp.bottom).offset(8)
        }
        
        cvvError.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.width.equalToSuperview().dividedBy(2).offset(-20)
            make.top.equalTo(cvvTextField.snp.bottom).offset(8)
        }
        
        saveButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(cvvError.snp.bottom).offset(24)
            make.height.equalTo(60)
        }
        
        loadingView.snp.makeConstraints({$0.edges.equalToSuperview()})
    }
    
}

extension PaymentViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.isEmpty else { return }
        textField.layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1.00).cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0, let text = textField.text, text.count >= 16, !string.isEmpty {
            return false
        }
        else if textField.tag == 1 {
            guard let oldText = textField.text, let r = Range(range, in: oldText) else { return true }
            let updatedText = oldText.replacingCharacters(in: r, with: string)

            if string == "" {
                if updatedText.count == 2 {
                    textField.text = "\(updatedText.prefix(1))"
                    return false
                }
            } else if updatedText.count == 1 {
                if updatedText > "1" {
                    return false
                }
            } else if updatedText.count == 2 {
                if updatedText <= "12" {
                    textField.text = "\(updatedText)/"
                }
                return false
            } else if updatedText.count > 5 {
                return false
            }
            return true
        }
        else if textField.tag == 2, let text = textField.text, text.count >= 3, !string.isEmpty {
            return false
        }
        return true
    }
    
}
