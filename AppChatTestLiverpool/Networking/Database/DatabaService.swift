//
//  Databaservice.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 14/09/23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

protocol DatabaseServiceProtocol{
    func request<T: Decodable>(path: String, parameters: [String: Any]? ,decodable: T ,method: DatabaseMethods, completion: @escaping CompletionHandler<T> )
}
typealias CompletionHandler<T> = (Result<T?, Error>) -> Void
class DatabaseService: DatabaseServiceProtocol{
    private let database = Database.database().reference()

    func request<T>(path: String, parameters: [String: Any]? = nil ,decodable: T, method: DatabaseMethods, completion: @escaping CompletionHandler<T>) where T : Decodable {
        switch method {
        case .set:
            
            database.child(path).setValue(parameters){ error, _ in
                 
                guard error == nil else {
                    completion(.failure(DatabaseErrors.failedToCreate))
                    return
                }
                completion(.success(true as? T))
            }
            break
        case .setAutoID:
            database.child(path).childByAutoId().setValue(parameters){ error, _ in
                 
                guard error == nil else {
                    completion(.failure(DatabaseErrors.failedToCreate))
                    return
                }
                completion(.success(true as? T))
            }
            break
        case .get:
            database.child(path).observeSingleEvent(of: .value, with: { snapshot in
                print("request path:\(path)")
                guard let dic = snapshot.value as? [String: Any] else {
                    completion(.success(nil))
                    return
                }
                let data = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                let model = self.decodeData(data: data, decode: decodable)
                completion(.success(model))
            })
            break
        case .getArray:
            database.child(path).observeSingleEvent(of: .value, with: { snapshot in
                dump(snapshot)
                guard let dic = snapshot.value as? [[String: Any]] else {
                    completion(.success(nil))
                    return
                }
                let data = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                let model = self.decodeData(data: data, decode: decodable)
                completion(.success(model))
            })
            break
        case .getAutoID:
            database.child(path).childByAutoId().observeSingleEvent(of: .value, with: { snapshot in
               
                guard let dic = snapshot.value as? [[String: String]] else {
                    completion(.success(nil))
                    return
                }
                let data = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                let model = self.decodeData(data: data, decode: decodable)
                completion(.success(model))
            })
            break
        case .observing:
            database.child(path).observe(.value){ snapshot in
               
                dump(snapshot)
                guard let dic = snapshot.value as? [[String: Any]] else {
                    completion(.success(nil))
                    return
                }
                let data = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                let model = self.decodeData(data: data, decode: decodable)
                completion(.success(model))
            }
            break
        }
    }
    func decodeData <T: Decodable>(data: Data, decode: T)->T?{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model = (try? decoder.decode(T.self, from: data))
        return model
    }
    
}
