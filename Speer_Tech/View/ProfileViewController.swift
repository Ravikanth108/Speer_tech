//
//  ProfileViewController.swift
//  Speer_Tech
//
//  Created by Ravi Kanth Bollam on 2021-10-01.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bioTxtView: UITextView!
    @IBOutlet weak var followersLbl: UILabel!
    @IBOutlet weak var followingLbl: UILabel!
    @IBOutlet weak var followersBtn: UIButton!
    @IBOutlet weak var followingBtn: UIButton!
    
    var username: String = ""
    var profile = UserProfile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        fetchProfile()
        
    }
    
    func fetchProfile() {
        service.shared.fetchProfiles(username: username){ (user, err) in
            if let err = err {
                print("failed:\(err)")
                return
            }
            self.profile = user!
            DispatchQueue.main.async{
                self.imgView.sd_setImage(with: URL(string: self.profile.imageUrl))
                self.usernameLbl.text = self.profile.username
                if let name = self.profile.name{
                    self.nameLbl.text = name
                }
                else {
                    self.nameLbl.text = "Not available"
                }
                if let bio = self.profile.bio {
                        self.bioTxtView.text = bio
                    }
                    else {
                        self.bioTxtView.text = "Not available"
                    }
                self.followersLbl.text = String(self.profile.followers)
                self.followingLbl.text = String(self.profile.following)
            }
        }
    }
    
    @IBAction func showFollowers(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showFollows", sender: sender)
    }
    
    
    @IBAction func showFollowing(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showFollows", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showFollows"{
    
        let senderButton = sender as! UIButton

                switch senderButton {
                case followersBtn:
                    
            guard let vc = segue.destination as? FollowViewController else { return }
                    vc.urlString = profile.followersUrl
                    vc.navigationItem.title = "Followers"
                case followingBtn:
            guard let vc = segue.destination as? FollowViewController else { return }
                    vc.navigationItem.title = "Following"
                    var str = profile.followingUrl
                    str.removeSubrange(Range(uncheckedBounds: (lower: str.index(str.endIndex, offsetBy: -13), upper: str.endIndex)))
                      vc.urlString = str
                default:
                    print("Nothing")
                }
    }
    }
    
}
