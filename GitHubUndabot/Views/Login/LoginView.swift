//
//  LoginView.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 02/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    var loginButton: UIButton!
    var gotoSearchButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        designView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        designView()
    }
}
