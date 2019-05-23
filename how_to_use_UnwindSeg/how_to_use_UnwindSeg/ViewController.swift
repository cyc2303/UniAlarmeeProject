//
//  ViewController.swift
//  how_to_use_UnwindSeg
//
//  Created by dajinHan on 23/05/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var item:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func toBase(segue:UIStoryboardSegue){
        print(self.item)
    }


}

