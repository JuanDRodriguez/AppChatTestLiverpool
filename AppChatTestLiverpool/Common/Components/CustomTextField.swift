//
//  CustomTextField.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import UIKit

class CustomTextField: UIView {
  
  @IBOutlet weak var textField: UITextField!
  private let placeholderColor = UIColor(red: 122.5/255, green: 121.5/255, blue: 120.25/255, alpha: 0.7)
    var isRequired: Bool = false
    var placeholderText: String = "" {
        didSet {
            let text = isRequired ? "\(placeholderText.localized().firstUpper) (\("required".localized()))" : placeholderText.localized().firstUpper
            textField.attributedPlaceholder = NSAttributedString(string: text,
                                                           attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
    var isTextSecureTextEntry: Bool = false {
         didSet{
             textField.isSecureTextEntry = isTextSecureTextEntry
             textField.textContentType = .password
             textField.autocapitalizationType = .none
             textField.autocorrectionType = .no
         }
    }
    
    var text: String? {
        return textField.text
    }
  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.loadFromNib()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.loadFromNib()
  }
  
  func loadFromNib() {
    if let contentView = Bundle.main.loadNibNamed("CustomTextField", owner: self, options: nil)?.first as? UIView {
      contentView.frame = bounds
      addSubview(contentView)
    }
  }
}
