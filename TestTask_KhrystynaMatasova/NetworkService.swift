//
//  NetworkService.swift
//  TestTask_KhrystynaMatasova
//
//  Created by Roma Test on 07.08.2021.
//

import Foundation

class NetworkService {
 
    func fetchUrl(urlString: String, response: @escaping (GameOver?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        request(url: url) { (data, error) in
            guard let data = data else {return}
            do {
                let finalURL = try JSONDecoder().decode(GameOver.self, from: data)
                response(finalURL)
            } catch let jsonError {
                print("Failed to decode JSON", jsonError.localizedDescription)
                response(nil)
            }
        }
    }
 
    func request(url: URL, completion: @escaping (Data?, Error?) -> Void) {
       // guard let url = URL(string: urlString) else { return  }
       
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else { return }
                completion(data, nil)
            }
        }
        
        dataTask.resume()
    }
}
