//
//  PostCell.swift
//  Instagram
//
//  Created by Michael Gonzales on 3/7/16.
//  Copyright © 2016 mkgo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {
    
    var instagramPost: PFObject! {
        didSet {
            self.comment.text = instagramPost["caption"] as? String
            self.photoView.file = instagramPost["media"] as? PFFile
            self.photoView.loadInBackground()
        }
    }

    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var photoView: PFImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
