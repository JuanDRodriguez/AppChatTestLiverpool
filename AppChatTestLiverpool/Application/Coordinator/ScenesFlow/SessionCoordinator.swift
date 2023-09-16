//
//  SessionCoordinator.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import UIKit
protocol RegisterCoordinatorInput{
    func showLogin()
}

protocol LoginCoordinatorInput{
    func showRegister()
    func showFlowChat(user: String)
}
class SessionCoordinator: NSObject, Coordinator{
    var navigationController: UINavigationController
    var moduleFactory: SessionSceneFactory
    let parent: DelegateAppCoordinator
    init(navigationController: UINavigationController, moduleFactory: SessionSceneFactory, parent: DelegateAppCoordinator) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
        self.parent = parent
        
    }
    
    func start() {
        self.navigationController.delegate = self
        showLogin()
    }
    func showViewController(viewController: UIViewController){
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
extension SessionCoordinator: RegisterCoordinatorInput{
    func showLogin() {
        let vc = moduleFactory.makeLogin()
        vc.coordinator = self
        self.showViewController(viewController: vc)
    }
}

extension SessionCoordinator: LoginCoordinatorInput{
    func showRegister() {
        let vc = moduleFactory.makeRegister()
        vc.coordinator =  self
        self.navigationController.title = "register".localized().firstUpper
        self.showViewController(viewController: vc)
    }
    
    func showFlowChat(user: String) {
        self.parent.root()
        self.moduleFactory.setCredentials(user: user)
    }
}
extension SessionCoordinator: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
                return
            }

          
            if navigationController.viewControllers.contains(fromViewController) {
                return
            }

           
        if let _ = fromViewController as? RegisterViewController {
            self.moduleFactory.removeRegister()
        }
    }
    
}
