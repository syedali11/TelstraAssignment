//
//  ImageExtension.swift
//  SwiftAssignment
//
//  Created by Syed Tariq Ali on 31/05/21.
//

import UIKit

// MARK: - UIImageView extension
extension UIImageView {
    
    func loadThumbnail(urlSting link:String?) {
        image = UIImage(named: "noImage")
        if link != nil, let url = URL(string: link!) {
            APIHandler.downloadImage(url: url) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async() {
                        self.image = UIImage(data: data)
                    }
                case .failure(_):
                    DispatchQueue.main.async() {
                        self.image = UIImage(named: "noImage")
                    }
                }
            }
        }
        else {
            self.image = UIImage(named: "noImage")
        }
    }
}
