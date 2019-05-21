//
//  ViewController.swift
//  how_to_use_textfield
//
//  Created by Choi Yechan on 17/05/2019.
//  Copyright © 2019 Choi Yechan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var textid: UITextField!
    @IBAction func setID() {
        YunniArray.append(Yunni(id:textid.text))
        print(YunniArray)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

