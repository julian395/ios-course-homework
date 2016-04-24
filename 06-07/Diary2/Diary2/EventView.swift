//
//  EventView.swift
//  Diary2
//
//  Created by Julian1 on 24.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class EventView: UIView {

    var color = UIColor.redColor()
    
    var record: Diary? {
        didSet {
            if let weather = record?.img {
                switch weather {
                case .Sun:
                    color = UIColor.yellowColor()
                case .Cloud:
                    color = UIColor.blueColor()
                case .Rain:
                    color = UIColor.darkGrayColor()
                case .Default:
                    color = UIColor.lightGrayColor()
                default:
                    color = UIColor.lightGrayColor()
                }
            }
            
            initSubviews()
        }
    }
    
    var isFirst = false
    var isLast  = false
    var hasDate = true
    
    private func initSubviews() {
        let gap:CGFloat                  =  15
        let dateWidth:CGFloat            =  50
        let dateHeight:CGFloat           =  26
        var dateLineHeight:CGFloat       =  35
        let lastViewOffsetY:CGFloat      =  35
        let nameLabelMinWidth:CGFloat    =  dateHeight
        let nameLabelMaxWidth:CGFloat    = 140
        let dateLineHiddenHeight:CGFloat = 155
        
        var boundsSize = CGSizeZero
        
        var rect = CGRectZero
        rect.origin.y = dateLineHeight
        rect.size = CGSizeMake(dateWidth, dateHeight)
        if hasDate {
            let dateLabel = UILabel()
            dateLabel.textColor = color
            dateLabel.font = UIFont.systemFontOfSize(11)
            dateLabel.text = record?.eventDate
            dateLabel.textAlignment = .Center
            
            dateLabel.frame.size.width  = dateWidth
            dateLabel.frame.size.height = dateHeight
            
            rect.size = CGSizeMake(dateWidth, dateHeight)
            
            let dateView = getRoundedViewWithFrame(rect)
            dateView.addSubview(dateLabel)
            self.addSubview(dateView)
            boundsSize.height += rect.size.height
        } else if isLast {
            dateLineHeight += 0.5 * dateHeight
        } else {
            dateLineHeight += dateHeight
        }
        boundsSize.width += rect.size.width
        
        var lineImageFrame = CGRectZero
        lineImageFrame.origin.x = rect.origin.x
        lineImageFrame.origin.y = isFirst ? -dateLineHiddenHeight : 0
        lineImageFrame.size = CGSize(width: rect.size.width, height: isFirst ? dateLineHeight + dateLineHiddenHeight : dateLineHeight)
        var lineImageView = UIImageView(frame: lineImageFrame)
        lineImageView.image = drawLineInRect(ofSize: lineImageFrame.size, horizontally: false)
        self.addSubview(lineImageView)
        boundsSize.height += dateLineHeight
        
        if let weather = record?.img {
            if weather != .Default {
                let weatherSize = CGSizeMake(  2 * dateHeight,     2 * dateHeight)
                let imageSize   = CGSizeMake(0.7 * weatherSize.width, 0.7 * weatherSize.height)
                var imageFrame = CGRectZero
                imageFrame.origin.x = 0.5 * (weatherSize.width  - imageSize.width)
                imageFrame.origin.y = 0.5 * (weatherSize.height - imageSize.height)
                imageFrame.size = imageSize
                
                let weatherImageView = UIImageView(frame: imageFrame)
                weatherImageView.tintColor = color
                let images = ["sunny_sm", "rain_sm", "cloudy_sm"]
                weatherImageView.image = UIImage(named: images[weather.rawValue])?.imageWithRenderingMode(.AlwaysTemplate)
                
                rect.origin.x = rect.maxX + gap
                rect.origin.y = rect.midY - 0.5 * weatherSize.height
                rect.size = weatherSize
                
                let weatherView = getRoundedViewWithFrame(rect)
                weatherView.addSubview(weatherImageView)
                self.addSubview(weatherView)
                boundsSize.width += rect.size.width
                lineImageFrame = CGRectZero
                if hasDate {
                    lineImageFrame.origin.x = rect.origin.x - gap
                } else {
                    lineImageFrame.origin.x = rect.origin.x - gap - 0.5 * dateWidth
                }
                lineImageFrame.origin.y = rect.origin.y
                if hasDate {
                    lineImageFrame.size = CGSize(width: gap, height: weatherSize.height)
                } else {
                    lineImageFrame.size = CGSize(width: gap + 0.5 * dateWidth, height: weatherSize.height)
                }
                lineImageView = UIImageView(frame: lineImageFrame)
                lineImageView.image = drawLineInRect(ofSize: lineImageFrame.size, horizontally: true)
                self.addSubview(lineImageView)
            }
        }
        if !(record?.title ?? "").isEmpty {
            let nameLabel = UILabel()
            nameLabel.textColor = color
            nameLabel.font = UIFont.systemFontOfSize(15)
            nameLabel.lineBreakMode = .ByTruncatingTail
            nameLabel.text = record?.title
            nameLabel.textAlignment = .Center
            
            var nameSize = nameLabel.intrinsicContentSize()
            if nameSize.width < nameLabelMinWidth {
                nameSize.width = nameLabelMinWidth
            } else if nameSize.width > nameLabelMaxWidth {
                nameSize.width = nameLabelMaxWidth
            }
            nameSize.height = rect.height
            nameLabel.frame.origin.x = gap
            nameLabel.frame.size = nameSize
            
            rect.origin.x = rect.maxX + gap
            rect.origin.y = rect.midY - 0.5 * nameSize.height
            rect.size = nameSize
            rect.size.width += 2 * gap
            
            let nameView = getRoundedViewWithFrame(rect)
            nameView.addSubview(nameLabel)
            self.addSubview(nameView)
            lineImageFrame = CGRectZero
            lineImageFrame.origin.x = rect.origin.x - gap
            lineImageFrame.origin.y = rect.origin.y
            lineImageFrame.size = CGSize(width: gap, height: nameSize.height)
            lineImageView = UIImageView(frame: lineImageFrame)
            lineImageView.image = drawLineInRect(ofSize: lineImageFrame.size, horizontally: true)
            self.addSubview(lineImageView)
  
            boundsSize.width += rect.size.width
        }
        
        if isLast {
            boundsSize.height += lastViewOffsetY
        }
        
        self.bounds.size = boundsSize
    }
    
    private func getRoundedViewWithFrame(frame: CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.layer.cornerRadius = 0.5 * frame.size.height
        view.layer.borderWidth  = 1
        view.layer.borderColor  = color.CGColor
        view.clipsToBounds      = true
        return view
    }
    
    private func drawLineInRect(ofSize size: CGSize, horizontally: Bool) -> UIImage {
        let bounds = CGRect(origin: CGPoint.zero, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()

        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor)
        CGContextSetLineWidth(context, 1)
        
        CGContextBeginPath(context)
        if horizontally {
            CGContextMoveToPoint(context, CGRectGetMinX(bounds), CGRectGetMidY(bounds))
            CGContextAddLineToPoint(context, CGRectGetMaxX(bounds), CGRectGetMidY(bounds))
        } else {
            CGContextMoveToPoint(context, CGRectGetMidX(bounds), CGRectGetMinY(bounds))
            CGContextAddLineToPoint(context, CGRectGetMidX(bounds), bounds.size.height)
        }
        CGContextStrokePath(context)
 
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    //    // Only override drawRect: if you perform custom drawing.
    //    // An empty implementation adversely affects performance during animation.
    //    override func drawRect(rect: CGRect) {
    //    }
    
}
