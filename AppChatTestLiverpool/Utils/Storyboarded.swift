//
//  Storyboarded.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import Foundation
import UIKit
protocol Storyboarded {
    static func instantiate(storyboardName: String) -> Self
}
extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboardName: String) -> Self {
       let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
