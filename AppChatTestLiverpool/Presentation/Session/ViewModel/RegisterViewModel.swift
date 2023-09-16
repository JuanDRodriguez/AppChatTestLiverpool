//
//  RegisterViewModel.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import UIKit


protocol RegisterViewModelInput{
    func saveUser( user: RequestUser, image: UIImage?)
}
protocol RegisterViewModelOutput{
    func errorMesagge(title: String, message: String)
    func doneProfile()
}
 
class RegisterViewModel: RegisterViewModelInput{
    
    let controller: RegisterViewModelOutput
    let useCase: CreateProfileUseCaseIntput
    
    init(controller: RegisterViewModelOutput, useCase: CreateProfileUseCaseIntput)
    {
        self.controller = controller
        self.useCase = useCase
    }
    
    func getImageProfile()
    {
        
    }
    func saveUser(user: RequestUser, image: UIImage?) {
        let image = image?.jpegData(compressionQuality: 1)
        useCase.execute(user: user, image: image){ result in
            switch result{
                
            case .success(_):
                self.controller.doneProfile()
                break
            case .failure(let error):
                let messageError = error as? DatabaseErrors ?? DatabaseErrors.failedToCreate
                DispatchQueue.main.async {
                    self.controller.errorMesagge(title: "", message: messageError.errorString)
                }
                
                break
            }
        }
    }
    
    
   
}
