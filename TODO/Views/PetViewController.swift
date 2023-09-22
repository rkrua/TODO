//
//  CatDogViewController.swift
//  TODO
//
//  Created by 장가겸 on 8/31/23.
//

import UIKit

class PetViewController: UIViewController {


    @IBAction func refreshButton(_ sender: Any) {
    }
    @IBOutlet weak var imageView: UIImageView!
    
    private let url = "https://api.thecatapi.com/v1/images/search"
    private var pets: [Pet] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPets()
    }
    func getPets() {
        
    }
}
