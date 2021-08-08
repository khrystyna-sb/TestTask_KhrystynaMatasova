//
//  GameViewController.swift
//  TestTask_KhrystynaMatasova
//
//  Created by Roma Test on 06.08.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let networkService = NetworkService()
    var gameOver: GameOver?
    let webView = WKWebView()
    let url = "https://2llctw8ia5.execute-api.us-west-1.amazonaws.com/prod"
    var winner = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        networkService.fetchUrl(urlString: url) { (gameOver) in
            guard let gameOver = gameOver else {return}
            self.gameOver = gameOver
            if self.winner == true {
                guard let loserUrl = URL(string: gameOver.winner) else {return}
                self.webView.load(URLRequest(url: loserUrl))
            } else {
                guard let loserUrl = URL(string: gameOver.loser) else {return}
                self.webView.load(URLRequest(url: loserUrl))
            }
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
   
}
