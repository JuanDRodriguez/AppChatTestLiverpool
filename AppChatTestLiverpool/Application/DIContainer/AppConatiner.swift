//
//  AppConatiner.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import Foundation
struct AppContainer{
    let dataService: DatabaseService
    let storageService: StorageService
    let authService: AuthService
    @UserDefault<String>(key: "id", defaultValue: "") var id
    @UserDefault<String>(key: "name", defaultValue: "") var name
    @UserDefault<String>(key: "url", defaultValue: "") var url
    init() {
        self.dataService = DatabaseService()
        self.storageService = StorageService()
        self.authService = AuthService()
    }

}
