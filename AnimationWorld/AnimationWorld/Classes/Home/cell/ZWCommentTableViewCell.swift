//
//  ZWCommentTableViewCell.swift
//  AnimationWorld
//
//  Created by zzw on 2018/9/4.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher
class ZWCommentTableViewCell: UITableViewCell ,NibReusable {

    @IBOutlet weak var userpic: UIImageView!
    @IBOutlet weak var userNameLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!


    var model = ZWCartoonInfoModel(){
        didSet{
  
            userpic.kf.setImage(with: ImageResource(downloadURL:URL(string: model.userpic)!))
            userNameLab.text = model.user
            timeLab.text = model.pubtime
            contentLab.text = model.content
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
