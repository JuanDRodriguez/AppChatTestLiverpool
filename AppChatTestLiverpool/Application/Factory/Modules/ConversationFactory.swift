//
//  ConversationFactory.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import UIKit
protocol ConversationFactoryProtocol {
    func makeModule(coordinator: ConversationViewControllerCoordinator) ->  UIViewController
    func makeChatCoordinator(navigationController: UINavigationController, id:String?, recipient: User, sender:User ) -> Coordinator
}
struct ConversationFactory: ConversationFactoryProtocol {
    func makeChatCoordinator(navigationController: UINavigationController, id:String?, recipient: User, sender:User ) -> Coordinator {
        let factory = ChatFactory(appContainer: self.appContainer)
        return ChatCoordinator(navigationController: navigationController, moduleFactory: factory, idConversation: id, sender:sender, recipient: recipient)
    }
    
    
    
    
    let appContainer: AppContainer
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }
    
    func makeModule(coordinator: ConversationViewControllerCoordinator) -> UIViewController {
        let repository = ConversationRepository(databaseService: appContainer.dataService, id: appContainer.id)
        let conversationUseCase = ConversationUseCase(repository: repository)
        let viewModel = ConversationViewModel(usecase: conversationUseCase)
        viewModel.id = appContainer.id
        let viewController = ConversationsViewController.instantiate(storyboardName: "Main")
        viewController.id = appContainer.id
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        return viewController
    }
    
    /*func makeChatCoordinator(navigationController: UINavigationController) -> Coordinator {
        return ChatCoordinator(navigationController: UINavigationControllernavigationController, moduleFactory: , parent: <#T##DelegateAppCoordinator#>)(navigationController: navigationController, convesation: moduleFactory)
    }*/
    
    
}
