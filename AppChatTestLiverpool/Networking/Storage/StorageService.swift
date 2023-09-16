//
//  StorageService.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 14/09/23.
//

import Foundation
import FirebaseStorage

protocol RemoteStorageImageService {
    func save(path: String, data: Data, completion: @escaping(Result<String,Error>) -> Void)
}

struct StorageService: RemoteStorageImageService{
    private let storage = Storage.storage().reference()
    func save(path: String, data: Data, completion: @escaping(Result<String,Error>) -> Void) {
        storage.child(path).putData(data, completion: { _, error in
            guard error == nil else{
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            self.storage.child(path).downloadURL(completion: {url,error in
                guard let url = url else{
                    completion(.failure(StorageErrors.failedToGetDownloadURL))
                    return
                }
                completion(.success(url.absoluteString))
                
            })
        })
    }
    
    
}
