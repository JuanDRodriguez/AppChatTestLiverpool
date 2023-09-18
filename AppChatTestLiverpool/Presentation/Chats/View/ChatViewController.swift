//
//  ChatViewController.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController, Storyboarded {

    lazy var messageList: [Message] = []
    var viewModel: ChatViewModelProtocol?
    var otherUserEmail: String = ""
    var conversationId: String?
    var sender: User!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configMessageCollection()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        setupListening()
    }
    
    func setupListening(){
        
        self.viewModel?.items.observe(on: self){ item in
            self.messageList = item
            DispatchQueue.main.async {
                self.messagesCollectionView.reloadDataAndKeepOffset()
                self.messagesCollectionView.scrollToLastItem(at: .bottom)
                self.messageInputBar.inputTextView.text = nil
            }
        }
        guard let idConversation = self.conversationId else {
            self.viewModel?.idConversationCreated.observe(on: self){ id in
                guard let idConversation = id, !idConversation.isEmpty else{
                    return
                }
                self.conversationId = idConversation
                self.viewModel?.loadMessagesChat(idConversation: idConversation)
            }
            return
            
        }
        self.viewModel?.loadMessagesChat(idConversation: idConversation)
        
        
        
    }
    func configMessageCollection(){
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messageInputBar.delegate = self
    }
   


}
extension ChatViewController: InputBarAccessoryViewDelegate{
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let messageId = Date().toMillis()
        let message = Message(text: text, user: self.sender, messageId: "\(messageId ?? 0000000)", date: Date())
        self.viewModel?.sendMessage(idConversation: self.conversationId, message: message, sender: sender)
    }
    
}
// MARK: MessagesDataSource
extension ChatViewController: MessagesDataSource{
    var currentSender: MessageKit.SenderType {
        self.sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        messageList[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return self.messageList.count
    }
    
    
}
// MARK: MessagesLayoutDelegate
extension ChatViewController: MessagesLayoutDelegate {
  func cellTopLabelHeight(for _: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
    18
  }

  func cellBottomLabelHeight(for _: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
    17
  }

  func messageTopLabelHeight(for _: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
    20
  }

  func messageBottomLabelHeight(for _: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
    16
  }
}

// MARK: MessagesDisplayDelegate

extension ChatViewController: MessagesDisplayDelegate {
    // MARK: - Text Messages
    
    func textColor(for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> UIColor {
        isFromCurrentSender(message: message) ? .white : .darkText
    }
    
    func detectorAttributes(for detector: DetectorType, and _: MessageType, at _: IndexPath) -> [NSAttributedString.Key: Any] {
        switch detector {
        case .hashtag, .mention: return [.foregroundColor: UIColor.blue]
        default: return MessageLabel.defaultAttributes
        }
    }
    
    func enabledDetectors(for _: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> [DetectorType] {
        [.url, .address, .phoneNumber, .date, .transitInformation, .mention, .hashtag]
    }
    
    // MARK: - All Messages
    
    func backgroundColor(for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> UIColor {
        let sender = message.sender
        if sender.senderId == self.sender.senderId {
            // our message that we've sent
            return .link
        }

        
        return .secondarySystemBackground
    }
    
    func messageStyle(for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> MessageStyle {
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(tail, .curved)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) {
        //let avatar = SampleData.shared.getAvatarFor(sender: message.sender)
        //avatarView.set(avatar: avatar)
    }
    
    func configureMediaMessageImageView(
        _ imageView: UIImageView,
        for message: MessageType,
        at _: IndexPath,
        in _: MessagesCollectionView)
    {
        if case MessageKind.photo(let media) = message.kind, case _ = media.url {
            //imageView.kf.setImage(with: imageURL)
        } else {
            //imageView.kf.cancelDownloadTask()
        }
    }
}
extension ChatViewController: MessageCellDelegate {
    func didTapMessage(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            return
        }

        let message = self.messageList[indexPath.section]
  
    }
}
