//
//  SessionRepository.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 14/09/23.
//

import Foundation
struct SessionRepository: ProfileRepositoryProtocol{
   
    let databaseService: DatabaseServiceProtocol
    let storageService: StorageService
    let authService: AuthServiceProtocol
    init(databaseService: DatabaseServiceProtocol, storageService: StorageService, authService: AuthServiceProtocol) {
        self.databaseService = databaseService
        self.storageService = storageService
        self.authService = authService
    }
    
    private func savePhoto( id: String , image: Data?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let image =  image else {
            completion(.success(""))
            return
        }
        let path = String(format: StoragePath.image.rawValue, id)
        self.storageService.save(path: path, data: image, completion: { result in
            switch result {
            case .success(let url):
                completion(.success(url))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        })
    }
    private func validateNewUser(user: RequestUser, completion: @escaping (Bool?, Error?) -> Void){
        let path = String(format: StoragePath.users.rawValue, user.senderId.convertEmailToID())
        let userItem = User(senderId: user.senderId.convertEmailToID(), displayName: user.displayName, urlImage: "")
        self.databaseService.request(path: path, parameters: nil, decodable: userItem, method: .get){result in
                switch result {
                case .success(let user):
                    guard user != nil else {
                        completion(false,nil)
                        return
                    }

                    completion(true, nil)
                    break
                case .failure(let error):
                    completion(nil,error)
                    break
                }
        }
    }
    private func registerUserList(user: User, completion: @escaping CompletionHandler<Bool>){
        let path =  "\(StoragePath.registeredUsers.rawValue)/users"
        databaseService.request(path: path, parameters: nil, decodable: [user], method: .getArray){ result in
            switch result {
            case .success(let users):
                var userList:[User] = []
                if let list = users{
                    userList = list
                }
                userList.append(user)
                let parameters = ["users": userList.arrayDictionary] as? [String : Any]
                databaseService.request(path: "\(StoragePath.registeredUsers.rawValue)", parameters: parameters , decodable: Bool(), method: .set,completion: completion)
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
            
        }
    }
    func createProfile(image: Data?, user: RequestUser, completion: @escaping CompletionHandler<Bool>) {
        self.validateNewUser(user: user){ result, error  in
            guard let success = result, !success else{
                completion(.failure(DatabaseErrors.failedExistingItem))
                return
            }
            self.registerUser(email: user.senderId, password: user.password ?? ""){ result,error  in
                guard let success = result, success else{
                    completion(.failure(DatabaseErrors.failedToCreate))
                    return
                }
                self.createUser(image: image, user: user, completion: completion)
            }
            
        }
        
    }
    private func registerUser(email: String, password: String, completion: @escaping CompletionHandlerAuth){
        authService.singup(user: email, password: password, completion: completion)
    }
    private func createUser(image: Data?, user: RequestUser, completion: @escaping CompletionHandler<Bool>){
        let path = String(format: StoragePath.users.rawValue, user.senderId.convertEmailToID())
        self.savePhoto(id:user.senderId.convertEmailToID() , image: image){ result in
            switch result {
            case .success(let url):
                let userItem = User(senderId: user.senderId.convertEmailToID(), displayName: user.displayName, urlImage: url)
                databaseService.request(path: path, parameters: userItem.dictionary, decodable: Bool(), method: .set){ result in
                    switch result {
                    case .success(let response):
                        if let success =  response, success  {
                             registerUserList(user: userItem, completion: completion)
                        }else{
                            completion(.failure(DatabaseErrors.failedToCreate))
                        }
                        break
                    case .failure(let error):
                        completion(.failure(error))
                        break
                    }
                }
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
}
extension SessionRepository: LoginRepositoryPortocol{
    func login(user: String, password: String, completion: @escaping CompletionHandlerAuth) {
        authService.signIn(user: user, password: password, completion: completion)
    }
    
    
}
