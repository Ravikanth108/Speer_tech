//
//  FollowViewController.swift
//  Speer_Tech
//
//  Created by Ravi Kanth Bollam on 2021-10-01.
//

import UIKit

class FollowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var followsTableView: UITableView!
    
    var urlString = ""
    var follows = [Follows]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        followsTableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        fetchFollows()
    }
   
    func fetchFollows(){
        service.shared.fetchFollows(urlString: urlString){ (follows,err) in
            if let err = err {
                print("Failed to load:\(err)")
                return
            }
            self.follows = follows!
            DispatchQueue.main.async {
                self.followsTableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return follows.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = followsTableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as! UsersTableViewCell
        cell.nameLbl.text = follows[indexPath.row].username
        cell.imgView.sd_setImage(with: URL(string: follows[indexPath.row].imageUrl))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.username = follows[indexPath.row].username
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
}
