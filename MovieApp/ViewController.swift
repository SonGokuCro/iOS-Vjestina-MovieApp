//
//  ViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 30.03.2023..
//

import UIKit
import MovieAppData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let details = MovieUseCase().getDetails(id: 111161)
        print(details)
    }


}

