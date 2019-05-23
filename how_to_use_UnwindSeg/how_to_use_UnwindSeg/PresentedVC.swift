//
//  PresentedVC.swift
//  how_to_use_UnwindSeg
//
//  Created by dajinHan on 23/05/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit

class PresentedVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let dest = segue.destination as! ViewController
        dest.item = "Success"
        let button = sender as! UIButton
        print(button.tag)
    }
 

}
