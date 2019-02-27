//
//  ViewController.swift
//  Example
//
//  Created by Chamitha Wijesekera on 20/2/19.
//  Copyright © 2019 Chamitha Wijesekera. All rights reserved.
//

import Eureka
import LocationRow
import UIKit

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form
            +++ Section("LocationRow Example")
            <<< LocationRow("row1") { (row) in
                row.placeholder = "Location"
                }.onPresent({ (_, presentingViewController) in
                    presentingViewController.title = "Location"
                    presentingViewController.searchPlaceholder = "Enter Location"
                })
    }
}

