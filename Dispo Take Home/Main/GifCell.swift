//
//  GifCell.swift
//  Dispo Take Home
//
//  Created by Eric Engman on 1/17/22.
//

import UIKit
import Kingfisher

final class GifCell: UICollectionViewCell {
    
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 10
        return imgView
    }()
        
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(imgView)
        contentView.addSubview(label)
        imgView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(4)
            make.top.equalTo(contentView).offset(4)
            make.bottom.equalTo(contentView).offset(4)
            make.width.equalTo(bounds.height)
        }
        label.snp.makeConstraints { make in
            make.left.equalTo(imgView.snp.right).offset(12)
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(12)
        }
    }
    
    private lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        return loading
    }()
    
    public func setupCell(from object: GifObject?) {
        label.text = object?.title
        imgView.kf.setImage(with: object?.images.fixed_height.url)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

