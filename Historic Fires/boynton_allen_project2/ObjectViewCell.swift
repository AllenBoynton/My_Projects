//
//  ObjectViewCell.swift
//  boynton_allen_project2
//
//  Created by Allen Boynton on 11/2/15.
//  Copyright © 2015 Full Sail University. All rights reserved.
//

import UIKit

class ObjectViewCell: UITableViewCell {
    
    // Outlet to connect my table view
    @IBOutlet weak var fireArticle: UILabel!
    @IBOutlet weak var fireSource: UILabel!
    @IBOutlet weak var fireImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
