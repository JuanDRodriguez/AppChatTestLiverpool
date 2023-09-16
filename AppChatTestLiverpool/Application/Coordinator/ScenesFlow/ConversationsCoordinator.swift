//
//  ConversationsCoordinator.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import UIKit
class ConversationCoordinator: Coordinator{
    var navigationController: UINavigationController
    private var conversationFactory: ConversationFactoryProtocol
    
    init(navigationController: UINavigationController, conversationFactory: ConversationFactoryProtocol) {
        self.navigationController = navigationController
        self.conversationFactory = conversationFactory
    }
    
    func start() {
        
        let vc = conversationFactory.makeModule(coordinator: self)
        vc.title = "conversations".localized().firstUpper
        //self.navigationController = UINavigationController(rootViewController: vc)
        self.navigationController.modalPresentationStyle = .overFullScreen
        self.navigationController.setViewControllers([vc], animated: true)
    }
    
    
}
extension ConversationCoordinator: ConversationViewControllerCoordinator{
    func didSelectCell(otherEmail: String, idConversation: String?, name: String, url: String) {
        let coordinator = conversationFactory.makeChatCoordinator(navigationController: self.navigationController, email: otherEmail, id: idConversation, name: name, url: url)
        coordinator.start()
    }
    
}
