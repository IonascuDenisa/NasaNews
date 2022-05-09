//
//  NasaNewsTableViewCell.swift
//  NasaNews
//
//  Created by Denisa Ionascu on 08.05.2022.
//

import UIKit

struct NasaNewsTableViewCellModel{
    let title: String
    let date: String
}

class NasaNewsTableViewCell: UITableViewCell {
    static let cellId = "NasaNewsTableViewCell"
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let accesorryImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func setUp(with model: Item){
        titleLabel.text = model.title
        dateLabel.text = model.date
    }

    override var reuseIdentifier: String? {
        return NasaNewsTableViewCell.cellId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NasaNewsTableViewCell{
    func configure(){
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.numberOfLines = 2 
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.numberOfLines = 1
        
        
        
        dateLabel.textColor = UIColor.secondaryLabel
        accesorryImageView.tintColor = UIColor.secondaryLabel
        accesorryImageView.contentMode = UIView.ContentMode.scaleAspectFit
        accesorryImageView.image = UIImage(systemName: "arrowtriangle.right")
        
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(accesorryImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -5).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        accesorryImageView.translatesAutoresizingMaskIntoConstraints = false
        accesorryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        accesorryImageView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10).isActive = true
        accesorryImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        accesorryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        accesorryImageView.widthAnchor.constraint(equalToConstant: 30).isActive =  true
    
    }
}
