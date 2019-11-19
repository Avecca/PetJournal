//
//  VeterinaryOverviewViewController.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-19.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import CoreData

class VeterinaryOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var VeterinaryTV: UITableView!
    
    var visit: NSManagedObject?
    private let veterinaryVisits = VeterinaryVisits();
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        veterinaryVisits.fetchVisits()
        self.VeterinaryTV.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VeterinaryTV.delegate = self
        VeterinaryTV.dataSource = self
        
        
        self.VeterinaryTV.reloadData()
        
        

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return veterinaryVisits.countVisists()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = VeterinaryTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PetTableViewCell
        
        let cellIndex = indexPath.item
        
        visit = veterinaryVisits.entryVisit(index: cellIndex)!
        cell.configCell(obj: visit)
        
        //TODO TAG
//        TODO upside down
//                cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
