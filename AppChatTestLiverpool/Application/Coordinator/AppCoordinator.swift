//
//  AppCoordinator.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import UIKit
protocol DelegateAppCoordinator{
    func root()
}
class AppCoordinatoor: Coordinator{
   
    let coordinatorFactory: CoordinatorFactory
    let modulesFactory: ModulesFactory
    var navigationController: UINavigationController
    let appContainer: AppContainer
    var window: UIWindow?
    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationController = navigationController
        self.appContainer = AppContainer()
        self.modulesFactory = ModulesFactory(container: appContainer)
        self.coordinatorFactory = CoordinatorFactory(navigationController: self.navigationController, moduleFactory: self.modulesFactory)
        self.window = window
    }
    
    func start() {
        
        let coordinator = coordinatorFactory.makeInitialCoordinator(parent: self, appContainer: self.appContainer)
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
    
}
extension AppCoordinatoor: DelegateAppCoordinator{
    func root() {
        self.start()
    }
    
    
}
