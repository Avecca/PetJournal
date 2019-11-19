//
//  VeterinaryTableViewCell.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-19.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import CoreData

class VeterinaryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(obj: NSManagedObject?){  //pet: Pet //Pet
        
        if obj != nil {
            let name = obj!.value(forKeyPath: "name") as? String
           // nameLbl?.text = name
           // nameBtn?.setTitle(name, for: .normal)
            
        }
    }

}
