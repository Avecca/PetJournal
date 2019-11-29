//
//  TabOverView.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-14.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class TabOverView: UITabBarController {  // UITabBarControllerDelegate

    var tBI =  UITabBarItem.appearance()//UITabBarItem()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Start on the Pets tab
            self.selectedIndex = 1;
             
         tBI.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
           // tBI.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)
        tabBar.unselectedItemTintColor = .darkGray
         
   
          // UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.7607843137, blue: 0, alpha: 1)

    }
    
    
//    UITabBarControllerDelegate {
//

//
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        guard viewController is CreatePetViewController else { return true }
//        let storyboard = UIStoryboard(name: "Popup", bundle: nil)
//        let createPetViewController = storyboard.instantiateViewController(withIdentifier: "CreatePetViewController") as! CreatePetViewController
//        createPetViewController.modalPresentationStyle = .overCurrentContext
//        tabBarController.present(createPetViewController, animated: true, completion: nil)
//        return false
//    }

}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
