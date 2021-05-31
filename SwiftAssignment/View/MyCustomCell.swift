//
//  MyCustomCell.swift
//  SwiftAssignment
//
//  Created by Syed Tariq Ali on 31/05/21.
//

import Foundation
import UIKit
class MyCustomCell: UITableViewCell {

    var rowData : Row? {
        didSet {
            titleLabel.text = rowData?.title
            rowDescriptionLabel.text = rowData?.rowDescription
        }
    }

    //MARK: Subviews
     private let titleLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .black
     lbl.font = UIFont.boldSystemFont(ofSize: 16)
     lbl.textAlignment = .left
     lbl.numberOfLines = 0
     return lbl
     }()


     private let rowDescriptionLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .black
     lbl.font = UIFont.systemFont(ofSize: 16)
     lbl.textAlignment = .left
     lbl.numberOfLines = 0
     return lbl
     }()


    private let rowImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.image  = UIImage(named: "noImage")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()


    public func setImage(url: String){
        rowImageView.loadThumbnail(urlSting: url)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(rowImageView)
        addSubview(titleLabel)
        addSubview(rowDescriptionLabel)


        rowImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        titleLabel.anchor(top: topAnchor, left: rowImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 5, width: frame.size.width, height: 0, enableInsets: false)
        rowDescriptionLabel.anchor(top: titleLabel.bottomAnchor, left: rowImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 5, width: frame.size.width / 2, height: 0, enableInsets: false)
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

}
