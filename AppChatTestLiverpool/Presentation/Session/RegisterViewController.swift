//
//  RegisterViewController.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import UIKit
import JGProgressHUD

class RegisterViewController: UIViewController, Storyboarded{
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var firstNameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var registerButton: UIButton!
    
    lazy private var spinner: JGProgressHUD = {
        let hud = JGProgressHUD()
                hud.vibrancyEnabled = true
                hud.textLabel.text = "Loading"
                hud.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        return hud
    }()
    
    var viewModel: RegisterViewModelInput?
    var coordinator: RegisterCoordinatorInput?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.passwordTextField.isTextSecureTextEntry = true
        self.profileImgView.layer.cornerRadius = self.profileImgView.frame.size.width / 2
        self.firstNameTextField.isRequired = true
        self.passwordTextField.isRequired = true
        self.emailTextField.isRequired = true
        self.firstNameTextField.placeholderText = "name"
        self.lastNameTextField.placeholderText = "lastName"
        self.emailTextField.placeholderText = "email"
        self.passwordTextField.placeholderText = "password"
        self.registerButton.setTitle("signUp".localized().firstUpper, for: .normal)
        
        setupHidekeyboard()
    }
    func takePicture(type: UIImagePickerController.SourceType)
    {
        if UIImagePickerController.isSourceTypeAvailable(type){
            let myPickerController = UIImagePickerController()
            myPickerController.allowsEditing = true
            myPickerController.delegate = self;
            self.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    @IBAction func onClickTakePicture(){
        self.showActionSheet()
    }
    @IBAction func onClickRegisterButton(){
        guard let email = emailTextField.text, !email.isEmpty, email.emailValid() else {
            self.showAlert(message: "emailFormatIncorrect".localized().firstUpper)
            return
        }
        guard let user =  self.getValidUser(email: email) else{
            self.showAlert(message: "fillFieldsRequired".localized().firstUpper)
            return
        }
        DispatchQueue.main.async {
            self.spinner.show(in: self.view)
        }
        self.viewModel?.saveUser(user: user, image: self.profileImgView.image)
    }
    func getValidUser(email: String)-> RequestUser?{
        
        guard  let name =  self.firstNameTextField.text, !name.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else{ return nil }
        let lastName = self.lastNameTextField.text ?? ""
        return  RequestUser(senderId: email, displayName: "\(name.trim()) \(lastName.trim())", password: password)
    }
    func showActionSheet() {
        DispatchQueue.main.async {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
                self.takePicture(type: .camera)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
                self.takePicture(type: .photoLibrary)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
}
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImgView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension RegisterViewController: RegisterViewModelOutput{
    func errorMesagge(title: String, message: String) {
        DispatchQueue.main.async {
            self.spinner.dismiss()
        }
        self.showAlert(title: title,message: message)
    }
    
    func doneProfile() {
        DispatchQueue.main.async {
            self.spinner.dismiss()
            self.coordinator?.showLogin()
        }
    }
    
}
