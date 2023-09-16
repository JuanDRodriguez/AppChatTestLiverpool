//
//  ProfileRepositoryProtocol.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 14/09/23.
//

import Foundation
typealias CompletionHandlerUrl = (Result<String, Error>) -> Void
protocol ProfileRepositoryProtocol{
    func createProfile(image: Data?, user: RequestUser ,completion: @escaping CompletionHandler<Bool>)
}
