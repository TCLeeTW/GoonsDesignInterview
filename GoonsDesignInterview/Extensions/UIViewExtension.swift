//
//  ViewFrameAlignExtension.swift
//  iOS App
//
//  Created by TC Lee on 2023/9/7.
//

import UIKit
extension UIView{
    
    public var width:CGFloat{
        return frame.size.width
    }
    
    public var height:CGFloat{
        return frame.size.height
    }
    
    public var top:CGFloat{
        return frame.origin.y
    }
    
    public var bottom:CGFloat{
        return frame.origin.y + frame.size.height
    }
    
    public var left:CGFloat{
        return frame.origin.x
    }
    
    public var right:CGFloat{
        return frame.origin.x + frame.size.width
    }
    
    public var xCenter:CGFloat{
        return frame.origin.x + ( frame.size.width / 2 )
    }
    
    public var yCenter:CGFloat{
        return frame.origin.y + ( frame.size.height / 2 )
    }
}

extension UIViewController{
    public func centerAlign(_ parent:CGFloat,_ child:CGFloat)->CGFloat{
        return (parent-child)/2
    }
}

extension UICollectionReusableView{
    public func centerAlign(_ parent:CGFloat,_ child:CGFloat)->CGFloat{
        return (parent-child)/2
    }
}


