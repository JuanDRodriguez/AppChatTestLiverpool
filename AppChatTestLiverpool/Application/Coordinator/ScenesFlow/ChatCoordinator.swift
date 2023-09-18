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
    let idConversation: String?
    let sender: User
    let recipient: User
    
    init(navigationController: UINavigationController, moduleFactory: ChatFactoryProtocol, idConversation: String?, sender: User, recipient: User) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
        self.idConversation = idConversation
        self.sender = sender
        self.recipient = recipient
    }
    
    func start() {
        let vc = moduleFactory.makeModule(idConversation: self.idConversation, recipient: recipient, sender: sender)
        vc.title = recipient.displayName.firstUpper
        
        self.navigationController.pushViewController(vc, animated: true)
    }
}
