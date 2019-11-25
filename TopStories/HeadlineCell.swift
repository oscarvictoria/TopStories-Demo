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
    }

   
}
