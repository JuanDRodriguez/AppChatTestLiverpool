//
//  ChatFactory.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
import UIKit
protocol ChatFactoryProtocol{
    func makeModule( idConversation: String?, recipient: User, sender: User) -> UIViewController
}
class ChatFactory: ChatFactoryProtocol {
    
    
    let appContainer: AppContainer
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }
    
    func makeModule( idConversation: String?, recipient: User, sender: User) -> UIViewController {
        let repository = ChatRepository(databaseService: appContainer.dataService)
        let useCase = ChatUseCase(repository: repository)
        let viewModel = ChatViewModel(useCase: useCase, recipient: recipient)
        let viewController = ChatViewController.instantiate(storyboardName: "Main")
        viewController.conversationId = idConversation
        viewController.viewModel = viewModel
        viewController.sender = sender
        return viewController
    }
}

