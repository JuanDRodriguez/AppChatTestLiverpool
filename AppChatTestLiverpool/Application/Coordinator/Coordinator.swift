//
//  Coordinator.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import UIKit
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

