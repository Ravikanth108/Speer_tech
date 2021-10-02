//
//  Service.swift
//  Speer_Tech
//
//  Created by Ravi Kanth Bollam on 2021-10-01.
//

import Foundation

class service {
    static let shared = service()
    
    func fetchUsers(query: String, completion: @escaping (SearchUser?, Error?) -> ()) {
        let urlString = "https://api.github.com/search/users?" + "q=\(query)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch users:", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(SearchUser.self, from: data)
          
                    completion(users, nil)
                
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
    
    func fetchProfiles(username: String, completion: @escaping (UserProfile?, Error?) -> ()){
        let urlString = "https://api.github.com/users/" + "\(username)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch users:", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let user = try JSONDecoder().decode(UserProfile.self, from: data)
          
                    completion(user, nil)
                
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
    
    func fetchFollows(urlString: String, completion: @escaping ([Follows]?, Error?) -> ()){
        let urlString = urlString
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch follows:", err)
                return
            }
            guard let data = data else { return }
            do {
                let follows = try JSONDecoder().decode([Follows].self, from: data)
          
                    completion(follows, nil)
                
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
}
