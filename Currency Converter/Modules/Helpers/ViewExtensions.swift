//
//  ViewExtensions.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 27/03/2021.
//

import UIKit

// swiftlint:disable trailing_whitespace
extension UIView {
    
    @discardableResult func alignParentTop(constant: CGFloat = 0, safeArea: Bool) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            if safeArea {
                self.topAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.topAnchor,
                    constant: constant
                ).isActive = true
            } else {
                self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            }
        }
        
        return self
    }
    
    @discardableResult func alignParentBottom(constant: CGFloat = 0, safeArea: Bool) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            if safeArea {
                self.bottomAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                    constant: -constant
                ).isActive = true
            } else {
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            }
        }
        
        return self
    }
    
    @discardableResult func alignParentLeft(constant: CGFloat = 0, safeArea: Bool) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            if safeArea {
                self.leadingAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.leadingAnchor,
                    constant: constant
                ).isActive = true
            } else {
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
            }
        }
        
        return self
    }
    
    @discardableResult func alignParentRight(constant: CGFloat = 0, safeArea: Bool) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            if safeArea {
                self.trailingAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.trailingAnchor,
                    constant: -constant
                ).isActive = true
            } else {
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
            }
        }
        
        return self
    }
    
    @discardableResult func centerHorizontallyWithParent(constant: CGFloat = 0, safeArea: Bool) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            if safeArea {
                self.centerXAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.centerXAnchor,
                    constant: constant
                ).isActive = true
            } else {
                self.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant).isActive = true
            }
        }
        
        return self
    }
    
    @discardableResult func centerVerticallyWithParent(constant: CGFloat = 0, safeArea: Bool) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            if safeArea {
                self.centerYAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.centerYAnchor,
                    constant: constant
                ).isActive = true
            } else {
                self.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant).isActive = true
            }
        }
        
        return self
    }
    
    @discardableResult func matchParentHorizontally(constant: CGFloat = 0, safeArea: Bool) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            if safeArea {
                self.leadingAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.leadingAnchor,
                    constant: constant
                ).isActive = true
                self.trailingAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.trailingAnchor,
                    constant: -constant
                ).isActive = true
            } else {
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
            }
        }
        
        return self
    }
    
    @discardableResult func matchParentVertically(constant: CGFloat = 0, safeArea: Bool) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            if safeArea {
                self.topAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.topAnchor,
                    constant: constant
                ).isActive = true
                self.bottomAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                    constant: -constant
                ).isActive = true
            } else {
                self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            }
        }
        
        return self
    }
    
    @discardableResult func alignBelow(to view: UIView, constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func alignAbove(to view: UIView, constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constant).isActive = true
        return self
    }
    
    @discardableResult func alignRight(to view: UIView, constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func alignLeft(to view: UIView, constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -constant).isActive = true
        return self
    }
    
    @discardableResult func width(constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult func height(constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
}
