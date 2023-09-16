//
//  ModulesFactory.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import UIKit
protocol SessionSceneFactory{
        func makeLogin() -> LoginViewController
        func makeRegister() -> RegisterViewController
        func removeRegister()
        func setCredentials(user: String)
        func isLogged() -> Bool
}
protocol ChatSceneFactory{
        func makeConverstions() -> UIViewController
        func makeChat() -> UIViewController
}
class ModulesFactory: InitialModuleFactory {
    func isLogged() -> Bool {
        return !self.container.id.isEmpty
    }
    
    func setCredentials(user: String) {
        self.container.id = user
    }
    
    func makeConverstions() -> UIViewController {
        return UIViewController()
    }
    
    func makeChat() -> UIViewController {
        return UIViewController()
    }
    
    
    var container: AppContainer
    var respository: SessionRepository
    private var loginViewController: LoginViewController?
    private let loginUseCase: LoginUseCaseIntput
    private var loginViewModel: LoginViewModelInput?
    private var registerViewController: RegisterViewController?
    private let registerUseCase: CreateProfileUseCaseIntput
    private var registerViewModel: RegisterViewModelInput?
    init(container: AppContainer) {
        self.container = container
        self.respository = SessionRepository(databaseService: self.container.dataService, storageService: self.container.storageService, authService: self.container.authService)
        
        self.loginUseCase  = LoginUseCase(repository: self.respository)
        
      
        self.registerUseCase = CreateProfileUseCase(repository: respository)
        
    }
    
    func makeLogin() -> LoginViewController {
        self.loginViewController  = LoginViewController.instantiate(storyboardName: "Session")
        self.loginViewModel = LoginViewModel(controller: self.loginViewController!, useCase: self.loginUseCase)
        loginViewController?.viewModel = loginViewModel
        return self.loginViewController!
    }
    func removeRegister() {
        self.registerViewModel = nil
        self.registerViewController = nil
    }
    func makeRegister() -> RegisterViewController {
        removeRegister() 
        self.registerViewController = RegisterViewController.instantiate(storyboardName: "Session")
        self.registerViewModel  = RegisterViewModel(controller: self.registerViewController!, useCase: registerUseCase)
        self.registerViewController?.viewModel = registerViewModel
        return self.registerViewController!
    }
    
}
