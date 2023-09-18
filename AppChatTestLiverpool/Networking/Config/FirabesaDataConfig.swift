//
//  FirabesaDataConfig.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 14/09/23.
//

import Foundation

public enum StorageErrors: Error{
    case failedToUpload
    case failedToGetDownloadURL
    var errorString: String{
        switch self{
       
        case .failedToUpload:
            return "".localized().firstUpper
        case .failedToGetDownloadURL:
            return "1".localized().firstUpper
        }
    }
}
public enum AuthErrors: Error{
    case failedCreateUser
    case FailedLogin
    var errorString: String{
        switch self{
       
        case .failedCreateUser:
            return "failedCreateUser".localized().firstUpper
        case .FailedLogin:
            return "FailedLogin".localized().firstUpper
        }
    }
}
public enum DatabaseErrors: Error{
    case failedToFetch
    case failedToCreate
    case failedExistingItem
    var errorString: String{
        switch self{
        case .failedToFetch:
            return "".localized().firstUpper
        case .failedToCreate:
            return "failedCreateUser".localized().firstUpper
        case .failedExistingItem:
            return "failedExistingItem".localized().firstUpper
        }
    }
}
public enum StoragePath: String{
    case image = "images/%@_profile"
    case registeredUsers = "registeredUsers"
    case users = "users/%@"
    case messages = "conversations/%@/messages"
    case conversations = "users/%@/conversations"
    
}
public enum DatabasePath: String{
    case user = ""
}
public enum DatabaseMethods{
    case set
    case setAutoID
    case get
    case getArray
    case getAutoID
    case observing
}
