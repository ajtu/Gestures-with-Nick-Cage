//
//  ViewController.swift
//  Gestures-with-Nick-Cage
//
//  Created by Alvin on 10/25/18.
//  Copyright © 2018 AlvinTu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))
        imageView.addGestureRecognizer(longPress)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(_:)))
        imageView.addGestureRecognizer(swipe)



        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let randomInt = Int.random(in: 400...700)
        let urlString = URL(string: "https://www.placecage.com/500/\(randomInt)")
        print(urlString!)

        imageView.load(url: urlString!)

        
    }
    
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        let randomInt = Int.random(in: 400...700)
        let urlString = URL(string: "https://www.placecage.com/g/500/\(randomInt)")
        imageView.load(url: urlString!)
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        let randomInt = Int.random(in: 400...700)
        let urlString = URL(string: "https://www.placecage.com/c/500/\(randomInt)")
        imageView.load(url: urlString!)
    }
    
    
    
    
    

    

}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.main.async {
            self.image = UIImage(named: "loading")
            self.isUserInteractionEnabled = false
        }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
          
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.isUserInteractionEnabled = true

                    }
                }
            }
        }
    }
}
