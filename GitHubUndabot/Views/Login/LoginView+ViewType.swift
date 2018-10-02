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
        self.loginButton = UIButton(type: .system)
        self.gotoSearchButton = UIButton(type: .system)
    }
    
    func addSubviews() {
        self.addSubview(loginButton)
        self.addSubview(gotoSearchButton)
    }
    
    func setupSubviews() {
        self.backgroundColor = .white
        
        loginButton.autoAlignAxis(toSuperviewAxis: .vertical)
        loginButton.autoPinEdge(toSuperviewSafeArea: .top,
                                      withInset: ViewProperty.inset.loginViewStart)
        loginButton.autoSetDimension(.width, toSize: ViewProperty.size.buttonWidth)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = ViewProperty.color.undabotBlue
        loginButton.layer.cornerRadius = ViewProperty.size.defaultCorner
        loginButton.setTitle("Login", for: .normal)
        
        gotoSearchButton.autoAlignAxis(toSuperviewAxis: .vertical)
        gotoSearchButton.autoPinEdge(.top,
                                to: .bottom,
                                of: loginButton,
                                withOffset: ViewProperty.inset.small)
        gotoSearchButton.autoSetDimension(.width, toSize: ViewProperty.size.buttonWidth)
        gotoSearchButton.setTitleColor(.white, for: .normal)
        gotoSearchButton.backgroundColor = ViewProperty.color.undabotBlue
        gotoSearchButton.layer.cornerRadius = ViewProperty.size.defaultCorner
        gotoSearchButton.setTitle("Go To Search", for: .normal)
    }
}
