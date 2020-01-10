//
//  HeadlineCell.swift
//  TopStories
//
//  Created by Oscar Victoria Gonzalez  on 11/25/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class HeadlineCell: UITableViewCell {
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    
    // add a corner radius on a view we need to access the layer.corner radius prooperty
    // overridde the layoutSubViews() method
    // layoutSubviews() gets called when the constraints and the view os gettingpresents in its superview
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headlineImageView.layer.cornerRadius = 4
    }
    
    func configured(for headline: NewsHeadline) {
        headlineTitleLabel.text = headline.title
        bylineLabel.text = headline.byline
        
        // lets get image
        
        if let thumbImage = headline.thumbImage {
            // TODO: memory management - we need to handle retains cycles here
            // we can archive this by using a capture list
            // eg [unownd self] ... more on this later... more on this later
            ImageClient.fetchImage(for: thumbImage.url) { (result) in
                switch result {
                case .success(let image):
                    // update any UI elements on the main thread
                    DispatchQueue.main.async {
                        self.headlineImageView.image = image
                    }
                
                case .failure(let error):
                    print("configuredCell image error - \(error)")
                }
                
                
                
            }
        }
    }

   
}
