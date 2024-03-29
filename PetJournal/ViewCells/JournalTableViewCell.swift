//
//  JournalTableViewCell.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-22.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import CoreData

class JournalTableViewCell: UITableViewCell {
    

  //  @IBOutlet weak var entryBtn: UIButton!
    @IBOutlet weak var journalEntryButton: UIButton!
    
    var formatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configCell(obj: Entry?){  //pet: Pet //Pet
        
       // print((String(describing: obj.self)))
        if obj != nil {
            let subj = obj?.subject //obj!.value(forKeyPath: "name") as? String
           // nameLbl?.text = name
            let date = obj?.timeStamp ?? Date()
            
            
            formatter.locale = Locale(identifier: "sv_SE")
            formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd-HH")
            
            let subjString = (subj?.uppercased() ?? "UNNAMED ENTRY") + "  @  " + formatter.string(from: date)
            journalEntryButton?.setTitle(subjString, for: .normal)

        }
        
    }

}
