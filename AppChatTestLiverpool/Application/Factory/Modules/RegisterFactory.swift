//
//  RegisterFactory.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import UIKit
protocol RegisterFactoryProtocol {
    func makeModule(coordinator: RegisterCoordinatorInput) -> UIViewController
    func makeCoordinator(navigationController: UINavigationController, appContainer: AppContainer) -> Coordinator
}
class RegisterFactory: RegisterFactoryProtocol{
    
    let appContainer: AppContainer
    let delegate: DelegateAppCoordinator
    
    init(appContainer: AppContainer, delegate: DelegateAppCoordinator) {
        self.appContainer = appContainer
        self.delegate = delegate
    }
    
    func makeModule(coordinator: RegisterCoordinatorInput) -> UIViewController {
        let respository = SessionRepository(databaseService: self.appContainer.dataService, storageService: self.appContainer.storageService, authService: self.appContainer.authService)
        let registerUseCase = CreateProfileUseCase(repository: respository)
        let registerViewController = RegisterViewController.instantiate(storyboardName: "Session")
        let registerViewModel  = RegisterViewModel(controller: registerViewController, useCase: registerUseCase)
        registerViewController.coordinator = coordinator
        registerViewController.viewModel = registerViewModel
        return registerViewController
    }
    
    func makeCoordinator(navigationController: UINavigationController, appContainer: AppContainer) -> Coordinator {
        let factory = LoginFactory(appContainer: appContainer)
        return LoginCoordinator(navigationController: navigationController, factory: factory, appContainer: appContainer, delegate: delegate)
    }
    
}
