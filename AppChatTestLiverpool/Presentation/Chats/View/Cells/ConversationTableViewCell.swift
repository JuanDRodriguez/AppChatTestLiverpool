//
//  ConversationTableViewCell.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import UIKit
import SDWebImage
class ConversationTableViewCell: UITableViewCell {
    static var reuseIdentifier: String = "\(String(describing: ConversationTableViewCell.self))"
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI(){
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2

    }
    func setData(item: Conversation){
        self.messageLabel.text = item.latestMessage.text
        self.nameLabel.text = item.recipient.displayName
        self.dateLabel.text = item.latestMessage.date
        DispatchQueue.main.async {
            self.userImageView.sd_setImage(with: URL(string: item.recipient.urlImage), completed: nil)
        }
    }
}
