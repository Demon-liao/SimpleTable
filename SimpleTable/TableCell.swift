//
//  TableCell.swift
//  SimpleTable
//
//  Created by demon on 14-7-3.
//  Copyright (c) 2014年 demon. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    var _nameValue:UILabel!
    var _colorValue:UILabel!
    var name:NSString?{
        get{
            return NSString()
        }
        set{// newValue 默认参数
            _nameValue.text = newValue
        }
    }
    var color:NSString?{
        get{
            return NSString()
        }
        set{
            _colorValue.text = newValue
        }
    
    }
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        var nameLabelRect:CGRect=CGRectMake(0,5,70,15)
        var nameLabel:UILabel=UILabel(frame:nameLabelRect)
        nameLabel.textAlignment=NSTextAlignment.Right
        nameLabel.text="Name"
        nameLabel.font=UIFont.boldSystemFontOfSize(12)
        self.contentView.addSubview(nameLabel)
        
        var colorLabelRect:CGRect=CGRectMake(0,26,70,15)
        var colorLable:UILabel=UILabel(frame:colorLabelRect)
        colorLable.textAlignment=NSTextAlignment.Right
        colorLable.text="Color"
        colorLable.font=UIFont.boldSystemFontOfSize(12)
        self.contentView.addSubview(colorLable)
        
        var nameValueRect:CGRect=CGRectMake(80,5,200,15)
        _nameValue=UILabel(frame:nameValueRect)
        self.contentView.addSubview(_nameValue)
        
        var colorValueRect:CGRect=CGRectMake(80,25,200,15)
        _colorValue=UILabel(frame:colorValueRect)
        self.contentView.addSubview(_colorValue)
        // Initialization code

    }

    func setName(n:NSString){
        if(!n.isEqual(name)){
            name=n.copy() as? NSString
            _nameValue.text=name
        }
    }
    func setColor(c:NSString){
        if(!c.isEqual(color)){
            color=c.copy() as? NSString
            _colorValue.text=color
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
