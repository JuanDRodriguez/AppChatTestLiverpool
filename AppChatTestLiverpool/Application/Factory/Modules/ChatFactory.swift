//
//  ChatFactory.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
import UIKit
protocol ChatFactoryProtocol{
    func makeModule(otherEmail: String, idConversation: String?, name: String, url: String) -> UIViewController
}
class ChatFactory: ChatFactoryProtocol {
    
    
    let appContainer: AppContainer
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }
    
    func makeModule(otherEmail: String, idConversation: String?, name: String, url: String) -> UIViewController {
        let repository = ChatRepository(databaseService: appContainer.dataService)
        let useCase = ChatUseCase(repository: repository)
        //let viewModel = ChatViewModel(useCase: useCase)
        let viewController = ChatViewController.instantiate(storyboardName: "Main")
        viewController.otherUserEmail = otherEmail
        viewController.conversationId = idConversation
        viewController.name = name
        viewController.imageOtherEmmail = url
        return viewController
    }
}

