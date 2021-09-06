//
//  DeviceListViewCell.swift
//  DeviceListViewCell
//
//  Created by Solomon Chai on 2021-09-05.
//

import UIKit

class DeviceListViewCell: UITableViewCell {

    @IBOutlet weak var deviceImage: UIImageView!
    @IBOutlet weak var uuidLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
