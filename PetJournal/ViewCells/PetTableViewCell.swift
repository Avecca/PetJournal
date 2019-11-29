//
//  PetTableViewCell.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-14.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import CoreData

class PetTableViewCell: UITableViewCell {

   // @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameBtn: UIButton!
    
    @IBOutlet weak var petImageView: UIImageView!
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
            nameBtn?.setTitle(name, for: .normal)
            petImageView.imageCircle(anyImage: #imageLiteral(resourceName: "paw_print"))
            
        }
        
    }

}

extension UIImageView {
    public func imageCircle(anyImage: UIImage){

        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        self.image = anyImage
    }
    
}
