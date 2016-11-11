//
//  SongTableViewCell.swift
//  lab01
//
//  Created by macdt on 07/11/2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
