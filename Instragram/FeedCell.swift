//
//  FeedCell.swift
//  PS Give
//
//  Created by Isha Chirimar on 8/15/17.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var school_name: UIButton!
    @IBOutlet weak var view_list: UIButton!
    @IBOutlet weak var profile_pic: UIImageView!
    @IBOutlet weak var list_name: UILabel!
    @IBOutlet weak var list_descrip: UITextView!
    @IBOutlet weak var uuid: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
