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

extension ViewType {
    func designView() {
        initializeSubviews()
        addSubviews()
        setupSubviews()
    }
}

enum ViewProperty {
    enum inset {
        static let large: CGFloat = 16.0
        static let small: CGFloat = 8.0
        static let continous: CGFloat = 2.0
        static let loginViewStart: CGFloat = 200.0
        static let none: CGFloat = 0.0
    }
    enum size {
        static let defaultStackViewSpacing: CGFloat = 5.0
        static let smallImage: CGSize = CGSize(width: 80.0, height: 80.0)
        static let mediumImage: CGSize = CGSize(width: 120.0, height: 120.0)
        static let largeImage: CGSize = CGSize(width: 200.0, height: 200.0)
        static let smallImageCorner: CGFloat = 40.0
        static let mediumImageCorner: CGFloat = 60.0
        static let largeImageCorner: CGFloat = 100.0
        static let defaultCorner: CGFloat = 15.0
        static let smallFont: CGFloat = 12.0
        static let largeFont: CGFloat = 20.0
        static let borderWidth: CGFloat = 2.0
        static let buttonHeight: CGFloat = 40.0
        static let buttonWidth: CGFloat = 300.0
    }
    enum color {
        static let undabotBlue: UIColor = UIColor(red: 0.255, green: 0.596, blue: 0.784, alpha: 1.0)
    }
}
