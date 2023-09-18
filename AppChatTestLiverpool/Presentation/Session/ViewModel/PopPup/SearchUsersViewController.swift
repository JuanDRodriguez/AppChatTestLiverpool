//
//  SearchUsers.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//


import UIKit
protocol SearchUserProtocol{
    func finishSearch(user: User)
    var users: Observable<[User]?> { get set }
    func fetchUsers()
}
class SearchUsersViewController: UIViewController, Storyboarded {
    var completion: ((User) -> (Void))?
    var listUsers: [User] = []
    var delegate: SearchUserProtocol?
    var id: String?
    private var hasFetched = false
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        delegate?.users.observe(on: self){items in
            guard let list = items, !list.isEmpty else{
                return
            }
            self.listUsers = list
            DispatchQueue.main.async {
                self.searchUsers(user: self.searchBar.text ?? "")
                self.tableView.reloadData()
            }
            
        }
    }
    func setupUI(){
        tableView.register(SearchUserCell.self,
                       forCellReuseIdentifier: SearchUserCell.identifier)
        searchBar.placeholder = "searchUsers".localized().firstUpper
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        searchBar.delegate = self
        
        searchBar.becomeFirstResponder()
        delegate?.users.observe(on: self){ result in
            self.listUsers = result ?? []
        }
    }
    @IBAction private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }

    func searchUsers(user: String) {
        let emailId = id ?? ""
       
           let newListUsers = listUsers.filter({
               let email = $0.senderId
               guard email != emailId  else{
                    return false
                }

               let name = $0.displayName.lowercased()

                return name.hasPrefix(user.lowercased())
            })
            self.listUsers = newListUsers
        
        
    }

    

    func updateUI() {
        
    }

}
extension SearchUsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = listUsers[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchUserCell.identifier,
                                                       for: indexPath) as? SearchUserCell else{
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // start conversation
        let user = listUsers[indexPath.row]

        dismiss(animated: true, completion: { [weak self] in
            self?.delegate?.finishSearch(user: user)
        })
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
extension SearchUsersViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }

        searchBar.resignFirstResponder()
        self.delegate?.fetchUsers()
        
    }
}

