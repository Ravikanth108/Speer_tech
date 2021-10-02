//
//  SearchViewController.swift
//  Speer_Tech
//
//  Created by Ravi Kanth Bollam on 2021-10-01.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usersTableView: UITableView!
    
    var timer: Timer?
    var users : [Items] = []
    let refreshControl = UIRefreshControl()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        title = "GitHub Users"
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
         usersTableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        usersTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.usersTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as! UsersTableViewCell
        cell.users = self.users[indexPath.row]
        return cell
    }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    self.performSegue(withIdentifier: "showProfile", sender: indexPath)
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showProfile") {
            let destinationVC = segue.destination as! ProfileViewController
            let row = (sender as! NSIndexPath).row
            let username = users[row].username
                destinationVC.username = username
        }
    }
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.search), userInfo: nil, repeats: false)
    }
    
    @objc func search() {
        self.users.removeAll()
        guard let query = self.searchBar.text else { return }
        if query == "" { return }
        self.activityIndicator.startAnimating()
        service.shared.fetchUsers(query: query){ (users, err) in
            if let err = err {
                print("Failed to fetch users:", err)
                return
            }
            self.users.append(contentsOf: users!.items)
            DispatchQueue.main.async {
                if self.users.count == 0 {
                    let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.usersTableView.bounds.size.width, height: self.usersTableView.bounds.size.height))
                    noDataLabel.text          = "No users found"
                    noDataLabel.textColor     = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.usersTableView.backgroundView  = noDataLabel
                    self.usersTableView.separatorStyle  = .none
                }
                self.usersTableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
