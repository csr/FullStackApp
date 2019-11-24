//
//  ViewController.swift
//  MyJournal
//
//  Created by Cesare de Cal on 11/23/19.
//  Copyright © 2019 Cesare de Cal. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var posts = [Post]()

    fileprivate func fetchPosts() {
        Service.shared.fetchPosts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Failed fetching posts:", error)
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Posts"
        navigationItem.rightBarButtonItem = .init(title: "Create Post", style: .plain, target: self, action: #selector(handleCreatePost))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body        
        return cell
    }
    
    @objc func handleCreatePost() {
        print("Create post")
    }
}

