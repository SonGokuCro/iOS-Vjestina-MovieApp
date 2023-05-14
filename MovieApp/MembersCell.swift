//
//  MembersCell.swift
//  MovieApp
//
//  Created by endava-bootcamp on 14.05.2023..
//

import Foundation
import PureLayout
import MovieAppData


class MembersCell: UICollectionViewCell {
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    func createViews() {
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        contentView.addSubview(subtitleLabel)
    }
    
    func styleViews() {
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)

        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .black
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
    }
    
    func defineLayout() {
        titleLabel.autoPinEdge(toSuperviewEdge: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing)

        subtitleLabel.autoPinEdge(toSuperviewEdge: .leading)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .trailing)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
}




