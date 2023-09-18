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
    func didSelectCell(idConversation: String?, recipient: User, sender: User?) {
        let coordinator = conversationFactory.makeChatCoordinator(navigationController: navigationController, id: idConversation, recipient: recipient, sender: sender ?? User(senderId: "", displayName: "", urlImage: ""))
        coordinator.start()
    }
}
