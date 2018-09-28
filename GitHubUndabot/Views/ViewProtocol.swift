//
//  ViewProtocol.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit

protocol ViewType where Self: UIView {
    func initializeSubviews()
    func addSubviews()
    func setupSubviews()
}

enum ViewProperties {
    static let smallInset: CGFloat = 8.0
    static let noInset: CGFloat = 0.0
}
