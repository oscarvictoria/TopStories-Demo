//
//  NewsDetailController.swift
//  TopStories
//
//  Created by Oscar Victoria Gonzalez  on 11/26/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class NewsDetailController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailByline: UILabel!
    
    var newsHeadline: NewsHeadline?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    func updateUI() {
        guard let headline = newsHeadline else {
            fatalError("newsHeadline is nil, verify (prepare for segue:)")
        }
        navigationItem.title = headline.title
        detailTextView.text = headline.abstract
        detailByline.text = headline.byline
      
        if let superJumboImage = headline.superJumbo {
            ImageClient.fetchImage(for: superJumboImage.url) { [unowned self] (result) in
                switch result {
                case .failure(let error):
                    print("error: \(error)")
                case .success(let image):
                    DispatchQueue.main.async {
                        self.detailImageView.image = image
                    }
                    
                }
                
            
        }
    }

}
}
