//
//  VideoPlayerTableViewController.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 11/05/23.
//

import UIKit

protocol VideoPlayability: AnyObject {
    func playCellInCenter()
}

class VideoPlayerTableView: UITableView {
}

class VideoPlayerTableViewController: UITableViewController, VideoPlayability {
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        super.scrollViewDidEndDecelerating(scrollView)
        playCellInCenter()
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        super.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
        playCellInCenter()
    }
    
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        super.scrollViewDidEndScrollingAnimation(scrollView)
        playCellInCenter()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
        
        if let localCell = cell as? IVideoPlayerCell {
            localCell.willDisplay()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        super.scrollViewDidScroll(scrollView)
        
        playCellInCenter()
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        super.tableView(tableView, didEndDisplaying: cell, forRowAt: indexPath)
        
        if let localCell = cell as? IVideoPlayerCell {
            localCell.didEndDisplay()
        }
    }
    private func pauseAllPlayersInCell() {
        for cell in tableView.visibleCells.filter({ $0 is IVideoPlayerCell }) as! [IVideoPlayerCell] {
            cell.pauseVideo()
        }
    }
    
    func playCellInCenter() {
        var minDistanceFromCenter: CGFloat = -1
        for cell in tableView.visibleCells.filter({ $0 is IVideoPlayerCell }) as! [IVideoPlayerCell] {
            if cell.videoPlayer == nil {
                continue
            }
                        
            if let indexPath = tableView.indexPath(for: cell) {
                let cellRect = tableView.rectForRow(at: indexPath)
                let superView = tableView.superview
                
                let convertedRect = tableView.convert(cellRect, to: superView)
                let intersect = CGRectIntersection(tableView.frame, convertedRect)
                let visibleHeight = CGRectGetHeight(intersect)
                
                
                let distance = abs(tableView.frame.midY - intersect.midY)
                
                if visibleHeight > (cell.bounds.size.height * 0.6) && (minDistanceFromCenter < 0 || distance < minDistanceFromCenter) {  // only if 60% of the cell is visible.
                    
                    //cell is visible more than 60%
                    pauseAllPlayersInCell()
                    print("Mohit: \(indexPath.row) \(visibleHeight > (cell.bounds.size.height * 0.6)) && \((minDistanceFromCenter < 0 || distance < minDistanceFromCenter)), minDistance \(minDistanceFromCenter) - Ditance \(distance)") //your visible cell.
                    cell.playVideo()
                }
                
                minDistanceFromCenter = distance
            }
        }
    }
}
