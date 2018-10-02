//
//  LoginView+ViewType.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 02/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

extension LoginView: ViewType {
    func initializeSubviews() {
        self.usernameTextField = UITextField()
        self.passwordTextField = UITextField()
        self.loginButton = UIButton(type: .system)
        self.gotoSearchButton = UIButton(type: .system)
    }
    
    func addSubviews() {
        self.addSubview(usernameTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(gotoSearchButton)
    }
    
    func setupSubviews() {
        self.backgroundColor = .white
        
        usernameTextField.autoAlignAxis(toSuperviewAxis: .vertical)
        usernameTextField.autoPinEdge(toSuperviewSafeArea: .top,
                                      withInset: ViewProperty.inset.loginViewStart)
        usernameTextField.autoSetDimension(.width,
                                           toSize: ViewProperty.size.textFieldWidth)
        usernameTextField.placeholder = "username"
        usernameTextField.borderStyle = .roundedRect
        
        passwordTextField.autoAlignAxis(toSuperviewAxis: .vertical)
        passwordTextField.autoPinEdge(.top,
                                      to: .bottom,
                                      of: usernameTextField,
                                      withOffset: ViewProperty.inset.small)
        passwordTextField.autoSetDimension(.width,
                                           toSize: ViewProperty.size.textFieldWidth)
        passwordTextField.placeholder = "********"
        passwordTextField.borderStyle = .roundedRect
        
        loginButton.autoAlignAxis(toSuperviewAxis: .vertical)
        loginButton.autoPinEdge(.top,
                                to: .bottom,
                                of: passwordTextField,
                                withOffset: ViewProperty.inset.small)
        loginButton.setTitle("Login", for: .normal)
        
        gotoSearchButton.autoAlignAxis(toSuperviewAxis: .vertical)
        gotoSearchButton.autoPinEdge(.top,
                                to: .bottom,
                                of: loginButton,
                                withOffset: ViewProperty.inset.small)
        gotoSearchButton.setTitle("Go To Search", for: .normal)
    }
}
