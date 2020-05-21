//
//  MiDiaLayout.swift
//  TecNutricion-iOS
//
//  Created by user168638 on 5/21/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

enum SegmentStyle {
    case half
    case fullWidth
}

class MiDiaLayout: UICollectionViewLayout {
    var cachedAttributes = [UICollectionViewLayoutAttributes]()
    var contentBounds = CGRect.zero
    let spacing: CGFloat = 10
    
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
           
        // Reset cached info
        cachedAttributes.removeAll()
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
        
        let count = collectionView.numberOfItems(inSection: 0)
        let itemHeight = MiDiaCollectionViewCell.CELL_HEIGHT
        
        var currentIndex = 0
        var segment: SegmentStyle = .half
        var lastFrame: CGRect = .zero
//        let numberOfColumns: CGFloat = 2
        let cvWidth = collectionView.bounds.size.width
        
        while currentIndex < count {
            let fullWidthRect = CGRect(x: 0, y: lastFrame.maxY, width: cvWidth, height: itemHeight)
            var segmentRects = [CGRect]()
            
            switch segment {
            case .half:
                let divs = fullWidthRect.divided(atDistance: fullWidthRect.width/2, from: .minXEdge)
                segmentRects = [divs.slice, divs.remainder]
            case .fullWidth:
                segmentRects = [fullWidthRect]
            }
            for rect in segmentRects {
                let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: 0))
                attributes.frame = rect
                
                cachedAttributes.append(attributes)
                contentBounds = contentBounds.union(lastFrame)
                
                currentIndex += 1
                lastFrame = rect
            }
            
            switch count - currentIndex {
            case 1:
                segment = .fullWidth
            default:
                segment = .half
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrArray = [UICollectionViewLayoutAttributes]()
        
        // Find any cell in the query rect
        guard let lastIndex = cachedAttributes.indices.last,
              let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex) else { return attrArray }
        
        // Starting from the match, loop up and down through the array until all the attributes
        // have been added within the query rect.
        for attributes in cachedAttributes[..<firstMatchIndex].reversed() {
            guard attributes.frame.maxY >= rect.minY else { break }
            attrArray.append(attributes)
        }
        
        for attributes in cachedAttributes[firstMatchIndex...] {
            guard attributes.frame.minY <= rect.maxY else { break }
            attrArray.append(attributes)
        }
        
        return attrArray
    }
    
    // Perform a binary search on the cached attributes array.
    func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
        if end < start { return nil }
        
        let mid = (start + end) / 2
        let attr = cachedAttributes[mid]
        
        if attr.frame.intersects(rect) {
            return mid
        } else {
            if attr.frame.maxY < rect.minY {
                return binSearch(rect, start: (mid + 1), end: end)
            } else {
                return binSearch(rect, start: start, end: (mid - 1))
            }
        }
    }

}
