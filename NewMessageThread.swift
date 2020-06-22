//
//  NewMessageThread.swift
//  Blitz
//
//  Created by Femi Orisamolu on 6/5/20.
//  Copyright © 2020 Femi Orisamolu. All rights reserved.
//

import UIKit

class NewMessageThread: UIViewController {
    
    private let tableView = UITableView()
    private let friends = UserService.friendsList.sorted { (profile1, profile2) -> Bool in
        return profile1.fullName < profile2.fullName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let backButton = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.title = "New Message"
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "newThreadCell")
        tableView.tableFooterView = UIView()
    }

}

extension NewMessageThread:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newThreadCell", for: indexPath) as! SearchTableViewCell
        cell.set(userProfile: friends[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let directMessages = DirectMessages(collectionViewLayout: UICollectionViewFlowLayout())
        directMessages.otherUser = friends[indexPath.row]
        self.navigationController?.pushViewController(directMessages, animated: true)
    }
}
