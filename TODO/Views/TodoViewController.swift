//
//  TodoViewController.swift
//  TODO
//
//  Created by 장가겸 on 8/28/23.
//

import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        "https://spartacodingclub.kr/css/images/scc-og.jpg".loadAsyncImage(imageView)
        // Do any additional setup after loading the view.
    }
    


}
