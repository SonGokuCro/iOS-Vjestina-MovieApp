//
//  LoginViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 02.04.2023..
//

import UIKit
import PureLayout


class LoginViewController: UIViewController{
    
    private let viewBackgroundColor = UIColor(red: 17/255, green: 37/255, blue: 61/255, alpha: 1)
    private let inputBackgroundColor = UIColor(red:29/255, green:59/255, blue:96/255, alpha:1)
    private let buttonBackgroundColor = UIColor(red: 103/255, green: 177/255, blue: 219/255, alpha: 1)
        
  
    var signInLabel = UILabel()
    var emailLabel = UILabel()
    var emailTextField = UITextField()
    var passwordLabel = UILabel()
    var passwordTextField = UITextField()
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
    }
    
    private func createViews(){
        initViews()
        styleViews()
        addingConstraints()
    }
    
    private func initViews(){
        view.addSubview(signInLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(button)
    }
    
    private func styleViews(){
        view.backgroundColor = viewBackgroundColor
        
        signInLabel.text = "Sign in"
        signInLabel.textColor = .white
        signInLabel.textAlignment = .center
        signInLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        emailLabel.text = "Email address"
        emailLabel.textColor = .white
        emailLabel.textAlignment = .left
        emailLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "ex. Matt@iosCourse.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(ciColor: .gray)]
        )
        emailTextField.setLeftPaddingPoints(10)
        emailTextField.backgroundColor = self.inputBackgroundColor
        emailTextField.layer.borderColor = self.buttonBackgroundColor.cgColor
        emailTextField.textColor = UIColor(ciColor: .white)
        emailTextField.autocapitalizationType = .none
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth =  1
        
        passwordLabel.text = "Password"
        passwordLabel.textColor = .white
        passwordLabel.textAlignment = .left
        passwordLabel.font = .systemFont(ofSize: 14, weight: .semibold)

        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter your password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(ciColor: .gray)]
        )
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.backgroundColor = self.inputBackgroundColor
        passwordTextField.layer.borderColor = self.buttonBackgroundColor.cgColor
        passwordTextField.textColor = UIColor(ciColor: .white)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth =  1
        
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = self.buttonBackgroundColor
        

    }
    
    private func addingConstraints(){
        signInLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 50)
        signInLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        signInLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        
        emailLabel.autoPinEdge(.top, to: .bottom, of: signInLabel, withOffset: 30)
        emailLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
        emailLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)

        emailTextField.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 8)
        emailTextField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
        emailTextField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        emailTextField.autoSetDimension(.height, toSize: 48)
        
        passwordLabel.autoPinEdge(.top, to: .bottom, of: emailTextField, withOffset: 30)
        passwordLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
        passwordLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)

        passwordTextField.autoPinEdge(.top, to: .bottom, of: passwordLabel, withOffset: 8)
        passwordTextField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
        passwordTextField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        passwordTextField.autoSetDimension(.height, toSize: 48)
        
        button.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 48)
        button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 40)
        button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 40)
        button.autoSetDimension(.height, toSize: 40)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
