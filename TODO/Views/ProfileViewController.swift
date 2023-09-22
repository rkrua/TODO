//
//  ProfileViewController.swift
//  TODO:
//
//  Created by 장가겸 on 9/22/23.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var profileId: UILabel!
    @IBOutlet var messageButton: UIButton!
    @IBOutlet var followButton: UIButton!
    @IBOutlet var profileLink: UILabel!
    @IBOutlet var profileDescription: UILabel!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var postLabel: UILabel!
    @IBOutlet var followingNumber: UILabel!
    @IBOutlet var followerLabel: UILabel!
    @IBOutlet var followerNumber: UILabel!
    @IBOutlet var postNumber: UILabel!
    @IBOutlet var followingLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    let FollowButtonLabel = {
        let label = UILabel()
        label.text = "Follow"
        return label
    }()

    let MessabeButtonLabel = {
        let label = UILabel()
        label.text = "Message"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        profileId.text = "nabaecamp"
        profileId.font = UIFont.boldSystemFont(ofSize: 16)
        profileLink.text = "spartacodingclub.kr"
        profileDescription.text = "iOS Developer 🍎"
        profileName.text = "르탄이"
        profileName.font = UIFont.boldSystemFont(ofSize: 16)
        postNumber.text = "7"
        postNumber.font = UIFont.boldSystemFont(ofSize: 16)
        followerNumber.text = "0"
        followerNumber.font = UIFont.boldSystemFont(ofSize: 16)
        followingNumber.text = "0"
        followingNumber.font = UIFont.boldSystemFont(ofSize: 16)
        postLabel.text = "post"
        followingLabel.text = "following"
        followerLabel.text = "follower"
        messageButton.setTitle("Message", for: .normal)
        followButton.setTitle("Follow", for: .normal)
    }
}
