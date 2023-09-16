//
//  LoginViewController.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//


import UIKit
import JGProgressHUD
class LoginViewController: UIViewController, Storyboarded {
   
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    lazy private var spinner: JGProgressHUD = {
        let hud = JGProgressHUD()
                hud.vibrancyEnabled = true
                hud.textLabel.text = "Loading"
                hud.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        return hud
    }()
    var coordinator: LoginCoordinatorInput?
    var viewModel: LoginViewModelInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.passwordTextField.isTextSecureTextEntry = true
        self.emailTextField.placeholderText = "email"
        self.passwordTextField.placeholderText = "password"
        self.loginButton.setTitle("logIn".localized().firstUpper, for: .normal)

        setupHidekeyboard()
    }
    
    @IBAction func onClickLoginButton(){
        guard let password = passwordTextField.text, !password.isEmpty,
            let email = emailTextField.text, !email.isEmpty else{
            self.showAlert(message: "fillFieldsRequired".localized().firstUpper)
            return
        }
        guard  email.emailValid() else {
            self.showAlert(message: "emailFormatIncorrect".localized().firstUpper)
            return
        }
        
        let request = RequestUser(senderId: email, displayName: "", password: password)
        DispatchQueue.main.async {
            self.spinner.show(in: self.view)
        }
        self.viewModel?.login(user: request)
    }
    @IBAction func onClickRegisterButton(){
        self.coordinator?.showRegister()
    }
}
extension LoginViewController: LoginViewModelOutput{
    func errorMesagge(title: String, message: String) {
        DispatchQueue.main.async {
            self.spinner.dismiss()
        }
        self.showAlert(title: title,message: message)
    }
    
    func doneLogin(user: RequestUser) {
        DispatchQueue.main.async {
            self.spinner.dismiss()
            self.coordinator?.showFlowChat(user: user.senderId.convertEmailToID())
        }
    }
    
    
}
