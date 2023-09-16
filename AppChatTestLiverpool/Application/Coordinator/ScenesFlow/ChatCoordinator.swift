//
//  ChatCoordinator.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import UIKit
class ChatCoordinator: Coordinator{
    var navigationController: UINavigationController
    let moduleFactory: ChatFactoryProtocol
    let otherEmail: String
    let idConversation: String?
    let name: String
    let url: String
    init(navigationController: UINavigationController, moduleFactory: ChatFactoryProtocol, otherEmail: String, idConversation: String?, name: String, url: String) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
        self.otherEmail = otherEmail
        self.idConversation = idConversation
        self.name = name
        self.url = url
    }
    
    func start() {
        let vc = moduleFactory.makeModule(otherEmail: self.otherEmail, idConversation: self.idConversation, name: self.name, url: self.url)
        vc.title = name.firstUpper
        
        self.navigationController.pushViewController(vc, animated: true)
    }
}
