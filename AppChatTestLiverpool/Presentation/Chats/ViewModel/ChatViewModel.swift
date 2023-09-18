//
//  ChatViewModel.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import Foundation
import MessageKit
protocol ChatViewModelOutput {
    var items: Observable<[Message]> { get }
    var idConversationCreated:  Observable<String?> { get }
}
protocol ChatViewModelInput{
    func sendMessage(idConversation:String?, message:Message, sender:User)
    func loadMessagesChat(idConversation:String)
}
typealias ChatViewModelProtocol = ChatViewModelInput & ChatViewModelOutput
class ChatViewModel:   ChatViewModelProtocol{
    var idConversationCreated: Observable<String?> = Observable("")
    
    var items: Observable<[Message]> = Observable([])
    
    let dateFormatter: ISO8601DateFormatter = {
        let localISOFormatter = ISO8601DateFormatter()
        localISOFormatter.timeZone = TimeZone.current
        return localISOFormatter
    }()
    let useCase: ChatUseCaseInput
    var recipient: User
    
    init(useCase: ChatUseCaseInput, recipient: User) {
        self.useCase = useCase
        self.recipient = recipient
    }
    func loadMessagesChat(idConversation:String) {
        self.useCase.execute(idConversation: idConversation){ result in
            switch result{
                
            case .success(let listMessages):
                guard let list = listMessages else {return}
                let messages: [Message] = list.compactMap({
                    return Message(text: $0.message, user: User(senderId: $0.senderEmail, displayName: $0.senderName, urlImage: ""), messageId: $0.messageId, date: self.dateFormatter.date(from: $0.sentDate) ?? Date())
                })
                self.items.value = messages
                break
            case .failure(_):
                print("fail to fetch Messages")
            }
        }
    }
    func getStringFromMessageKit(textMessage: MessageKit.MessageKind) -> String{
        switch textMessage {
        case .text(let text):
            return text
        default:
            return ""
        }
    }
    func createConversation(sender: User,conversation:Conversation){
        self.useCase.execute(sender: sender, conversation: conversation){ result in
            switch result{
            case .success(_):
                self.idConversationCreated.value = conversation.id
                
            case .failure(_):
                print("fail to createConversatio")
            }
        }
        
    }
    func sendMessage(idConversation:String?, message:Message, sender:User){
        let date = dateFormatter.string(from: Date())
        guard let id = idConversation else{
            let id = "Conversation-\(sender.senderId)-\(recipient.senderId)-\(date)"
            let latestMessage = LatestMessage(date: date, text: self.getStringFromMessageKit(textMessage: message.kind), isRead: false)
            let conversation = Conversation( id: id, recipient: recipient, latestMessage:latestMessage )
            createConversation(sender: sender,conversation: conversation)
            let otherUser =  Conversation( id: id, recipient: sender, latestMessage:latestMessage )
            createConversation(sender: recipient, conversation: otherUser)
            self.loadMessagesChat(idConversation: conversation.id)
            self.sendMessage(idConversation: id, message: message, sender: sender)
            return
        }
        let latestMessage = LatestMessage(date: date, text: self.getStringFromMessageKit(textMessage: message.kind), isRead: false)
        let conversation = Conversation( id: id, recipient: recipient, latestMessage:latestMessage )
        createConversation(sender: sender,conversation: conversation)
        let otherUser =  Conversation( id: id, recipient: sender, latestMessage:latestMessage )
        createConversation(sender: recipient, conversation: otherUser)
        let message = MessageDTO(senderEmail: sender.senderId, messageId: message.messageId, sentDate: date, message: self.getStringFromMessageKit(textMessage: message.kind), senderName: sender.displayName)
        self.useCase.execute(idConversation: id, message: message){ result in
            switch result{
            case .success(_):
                break
            case .failure(_):
                print("fail to send message")
            }
        }
    }
}
