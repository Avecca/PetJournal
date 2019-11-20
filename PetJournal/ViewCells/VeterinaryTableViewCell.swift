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

    @IBOutlet weak var reasonBtn: UIButton!
    @IBOutlet weak var dateBtn: UIButton!
    
    var formatter = DateFormatter()
    
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
            let reason = obj!.value(forKeyPath: "reason") as? String
            reasonBtn?.setTitle(reason, for: .normal)
            let date = (obj!.value(forKeyPath: "date") as? Date)!
            
            formatter.locale = Locale(identifier: "sv_SE")
            formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd-HH:mm")
            
            dateBtn?.setTitle(formatter.string(from: date), for: .normal)
           // nameLbl?.text = name
           // nameBtn?.setTitle(name, for: .normal)
            
        }
    }

}
