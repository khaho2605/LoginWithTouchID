//
//  SuccessViewController.swift
//  LoginWithTouchID
//
//  Created by KHA on 1/8/18.
//  Copyright © 2018 Kha. All rights reserved.
//

import UIKit

class SuccessViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated:true);
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "LOGIN SUCCESS"
    }
    
    @IBAction func logoutBtnDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
