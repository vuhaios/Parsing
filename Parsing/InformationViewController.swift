//
//  InformationViewController.swift
//  Parsing
//
//  Created by Sai Sailesh Kumar Suri on 02/11/18.
//  Copyright © 2018 Honeywell. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    var dictionary : NSDictionary? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        let spe = MBProgressHUD.showAdded(to: self.view, animated: true)
        spe.label.text = "Getting the Data"
        spe.contentColor = UIColor.white
        spe.backgroundView.color = UIColor.brown
        spe.detailsLabel.text = "Please Wait"
        spe.isUserInteractionEnabled = true
        spe.hide(animated: true, afterDelay: 3)
        dateLabel.text = dictionary?.value(forKey: "date") as! String

        // Do any additional setup after loading the view.
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
