//
//  ConversationsViewController.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import Foundation
import UIKit
protocol ConversationViewControllerCoordinator {
    func didSelectCell(idConversation: String?, recipient: User, sender: User?)
    func logoutUser()
}
class ConversationsViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ConversationViewModelOutput?
    private var conversations: [Conversation] = []
    var users: Observable<[User]?> = Observable([])
    var coordinator: ConversationViewControllerCoordinator?
    var id: String?
    var sender: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setListeningConversations()
        self.viewModel?.getUser()
        self.viewModel?.getConversations()
    }
    private func setListeningConversations(){
        self.viewModel?.conversations.observe(on: self){ items in
            self.conversations = items ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.viewModel?.users.observe(on: self){ items in
            self.users.value = items ?? []
        }
        self.viewModel?.sender.observe(on: self){ item in
            guard let user = item else{
                self.coordinator?.logoutUser()
                return
            }
            self.sender = user
        }
                                    
    }
    private func setupTableView() {
        tableView.register(UINib(nibName: "ConversationTableViewCell", bundle: nil),
                           forCellReuseIdentifier: ConversationTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func onClickSearchUsers(){
        let vc = SearchUsersViewController.instantiate(storyboardName: "Main")
        vc.id = self.id
        vc.delegate = self
        present(vc, animated: true)
    }
}
extension ConversationsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let conversation = conversations[indexPath.row]
        self.coordinator?.didSelectCell(idConversation: conversation.id, recipient: conversation.recipient, sender: self.sender)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension ConversationsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = conversations[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? ConversationTableViewCell else{
            return UITableViewCell()
        }
        cell.setData(item: model)
        return cell
    }

    
}
extension ConversationsViewController: SearchUserProtocol{
    
    
    func finishSearch(user: User) {
        guard let conversation = self.conversations.first(where: { $0.recipient.senderId == user.senderId}) else {
            self.coordinator?.didSelectCell(idConversation: nil, recipient: user, sender: self.sender)
            return
        }
        self.coordinator?.didSelectCell(idConversation: conversation.id, recipient: conversation.recipient, sender: self.sender)
    }
    
    
    func fetchUsers() {
        self.viewModel?.getUsers()
    }
    
    
}
