//
//  ViewController.swift
//  TestTask_KhrystynaMatasova
//
//  Created by Roma Test on 06.08.2021.
//

import UIKit

class GameViewController: UIViewController {

    let aimButton = AimButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    let startButton = UIButton()
    let timerCountUILabel = UILabel()
    var timer: Timer?
    var touchCount = 0
    var countForTimer = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubbviews()
    }
    
    func setupSubbviews() {
        
        let background = UIImage(named: "background")
        let imageView = UIImageView()
        imageView.frame = view.bounds
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
            
        view.addSubview(aimButton)
        view.addSubview(startButton)
        view.addSubview(timerCountUILabel)
        aimButton.isHidden = true
        aimButton.center = view.center
        aimButton.configure(with: AimButtonViewModel())
        aimButton.addTarget(self, action: #selector(aimAction(sender:)), for: UIControl.Event.touchUpInside)
        
        startButton.bounds.size = CGSize(width: 400, height: 250)
        startButton.backgroundColor = .red
        startButton.setTitle("Start", for: UIControl.State.normal)
        startButton.addTarget(self, action: #selector(startAction), for: UIControl.Event.touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
        startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        
        timerCountUILabel.isHidden = true
        timerCountUILabel.text = "\(touchCount)"
        timerCountUILabel.font = UIFont.boldSystemFont(ofSize: 50)
        timerCountUILabel.translatesAutoresizingMaskIntoConstraints = false
        timerCountUILabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerCountUILabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    @objc func aimAction(sender:UIButton) {
        let xMax = view.bounds.width
        let xMin = 0 + sender.bounds.width
        let yMax = view.bounds.height
        let yMin = 0 + sender.bounds.height
        let x = CGFloat.random(in: xMin...xMax)
        let y = CGFloat.random(in: yMin...yMax)
        sender.center = view.convert(CGPoint(x: x, y: y), from: view)
        touchCount += 1
        if touchCount == 10 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else {return}
            vc.winner = true
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
         print("Button Clicked")
      }
    
    @objc func startAction(sender:UIButton) {
        aimButton.isHidden = false
        sender.isHidden = true
        timerCountUILabel.isHidden = true
        countForTimer += 1
        timerCountUILabel.text = "\(countForTimer)"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        print("Button Clicked")
    }
    
    @objc func timerAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.timer?.invalidate()
            if self.touchCount < 7 {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else {return}
                vc.winner = false
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            
        }
    }
   
}

