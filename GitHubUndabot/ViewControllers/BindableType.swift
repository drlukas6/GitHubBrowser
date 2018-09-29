//
//  BindableType.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 29/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit

protocol BindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}



