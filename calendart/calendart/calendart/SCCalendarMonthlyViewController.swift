//
//  SCCalendarMonthlyViewController.swift
//  calendartest
//
//  Created by Good on 28/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation

class SCCalendarViewController: UIViewController, UICollectionViewDelegate {
   
    var separatorView : UIView
    var yearView : UICollectionView
    var separatorViewHeightConstraint : NSLayoutConstraint
    var dataSource : SSCalendarMonthlyDataSource
    var startingIndexPath : NSIndexPath?
    
    @IBOutlet weak var todayBarButtonItem1: UIBarButtonItem!
    
    var dataController : SSDataController
    var years : Array<Any> = Array()
    
//    init(events:[SSEvent]) {
//        super.init(nibName: nil, bundle: nil)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    public func initWithEvents(events : [SSEvent]) -> Any {
        dataController =  SSDataController()
        dataController.setEvents(events)
        self.years = dataController.calendarYears
        
        return self
    }
    
    func initWithDataController(dataController:SSDataController) -> Any {
        self.dataController = dataController
        self.years = dataController.calendarYears
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayBarButtonItem1.title = "Today";
        
        separatorView.backgroundColor = UIColor.init(hexString: COLOR_SEPARATOR)
        
        separatorViewHeightConstraint.constant = SSDimensions.onePixel() //[SSDimensions onePixel];
        
        dataSource = SSCalendarMonthlyDataSource.init(view: yearView)
        yearView.dataSource = dataSource;
        yearView.delegate = self;
        
        dataSource.years = years;
        
        refresh()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SSStyles.showShadow(on: self.navigationController?.navigationBar)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SSStyles.showShadow(on: self.navigationController?.navigationBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dataSource .updateLayout(forBounds: yearView.bounds)
        
        if startingIndexPath != nil {
            self.scrollToIndexPath(indexPath: startingIndexPath!, updateTitle: false)
            self.startingIndexPath = nil
        }
    }
    
    func refresh () {
        let calendarCounts = dataController.calendarCountCache
        if calendarCounts != nil {
            dataController .updateCalendarYears()
            yearView.reloadData()
        }
    }

    func scrollToIndexPath(indexPath: NSIndexPath, updateTitle:Bool) {
        yearView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.top, animated: false)
        
        let layout : UICollectionViewFlowLayout = yearView.collectionViewLayout as! UICollectionViewFlowLayout
        
        var offset = yearView.contentOffset
        offset.y = offset.y - layout.headerReferenceSize.height
        yearView.contentOffset = offset
        
        if (updateTitle) {
            let year = (years[indexPath.section / 12] as! SSYearNode).value
            self.title = NSString.init(format: "%li", year) as String
        }
        
    }
    
    
    //MARK: - UICollectionViewDelegateMethods
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as! SSCalendarDayCell
        
        let viewController = SSCalendarDailyViewController.init(dataController: dataController)
        viewController?.day = cell.day
        //TODO: -
        //self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visiblCells : Array = yearView.visibleCells
        for cell : SSCalendarDayCell in visiblCells as! Array<SSCalendarDayCell>{
            if (cell.day != nil && cell.frame.origin.y >= 0) {
                self.title = String(cell.day.year)
                break
            }
        }
    }
 
}
