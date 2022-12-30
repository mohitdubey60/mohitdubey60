    //
    //  ProgressAddTimeSlotsViewController.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 12/08/22.
    //

import UIKit
import Combine

class ProgressAddTimeSlotsViewController: UIViewController {
    
    @IBOutlet weak var dateTimeListTable: UITableView!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    @IBOutlet weak var startDate: UIDatePicker!
    
    @Published var isRequestInProgress = false
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    var subscribers: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @IBOutlet weak var confirmButton: UIButton!
    let days = ProgressConstants.daysInAWeek
    var selectedDays: [String:Bool] = [:]
    var timeSlots: [TimeSlot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        daysCollectionView.allowsMultipleSelection = true
        
        let nib = UINib(nibName: "ButtonStyleCollectionViewCell", bundle: nil)
        daysCollectionView.register(nib, forCellWithReuseIdentifier: "ButtonStyleCollectionViewCell")
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
            
        //TimeSlotTableViewCell
        let tableNib = UINib(nibName: "TimeSlotTableViewCell", bundle: nil)
        dateTimeListTable.register(tableNib, forCellReuseIdentifier: "TimeSlotTableViewCell")
        dateTimeListTable.delegate = self
        dateTimeListTable.dataSource = self
        
        startDate.minimumDate = Date()
        startDate.maximumDate = Calendar.current.date(byAdding: .day, value: 10, to: Date())!
        
        resetDaysSelection()
        isButtonEnabled()
        
        $isRequestInProgress
            .receive(on: RunLoop.main)
            .map { return !$0 }
            .assign(to: \.isHidden, on: progressView)
            .store(in: &subscribers)
        $isRequestInProgress
            .receive(on: RunLoop.main)
            .map { return !$0 }
            .assign(to: \.isHidden, on: progressIndicator)
            .store(in: &subscribers)
        $isRequestInProgress
            .receive(on: RunLoop.main)
            .map { return !$0 }
            .assign(to: \.isEnabled, on: confirmButton)
            .store(in: &subscribers)
            //        $isRequestInProgress.receive(on: RunLoop.main)
            //            .assign(to: \.isAnimating, on: progressIndicator)
            //            .store(in: &subscribers)
        
        getAllRowsFromTimeSlot()
        
    }
    
    private func isButtonEnabled() {
        let startDate = startTime.date
        let endDate = endTime.date
        let selectedItems = daysCollectionView.indexPathsForSelectedItems
        confirmButton.isEnabled = Date.checkIfTimeSelectionIsValid(startTimeDate: startDate,
                                                                   endTimeDate: endDate) && (selectedItems?.count ?? 0) > 0
    }
    
    private func resetDaysSelection() {
        selectedDays.keys.forEach { key in
            selectedDays[key] = false
        }
    }
    
    @IBAction func confirmButtonClickAction(_ sender: Any) {
        if let selectedItems = daysCollectionView.indexPathsForSelectedItems {
            var localTimeSlots: [LocalTimeSlot] = []
            for index in selectedItems {
                let localTimeSlot = LocalTimeSlot(dayName: days[index.item],
                                                  startTime: Int64(startTime.date.timeIntervalSince1970),
                                                  endTime: Int64(endTime.date.timeIntervalSince1970),
                                                  startDate: Int64(startDate.date.timeIntervalSince1970))
                localTimeSlots.append(localTimeSlot)
            }
            
            isRequestInProgress = true
            Task {
                do {
                    let result = try await ProgressTrackerDatabaseUtility.shared.saveTimeSlots(timeSlots: localTimeSlots)
                    Swift.print("Mohit: Records saved \(result)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
                        self?.isRequestInProgress = false
                        self?.isButtonEnabled()
                        Swift.print("Mohit: Main executed \(self)")
                        self?.getAllRowsFromTimeSlot()
                    }
                } catch {
                    Swift.print("Mohit: Error in DB \(error)")
                }
            }
        }
    }
    
    func getAllRowsFromTimeSlot() {
        Task {
            timeSlots = try await ProgressTrackerDatabaseUtility.shared.retrieveAllData(predicate: nil)
            DispatchQueue.main.async {
                self.dateTimeListTable.reloadData()
            }
        }
    }
    
    @IBAction func startTimeChanged(_ sender: Any) {
        isButtonEnabled()
    }
    
    @IBAction func endTimeChange(_ sender: Any) {
        isButtonEnabled()
    }
    
    
    @IBAction func startDate(_ sender: Any) {
    }
    
}

extension ProgressAddTimeSlotsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = daysCollectionView.cellForItem(at: indexPath) as? ButtonStyleCollectionViewCell {
            selectedDays[days[indexPath.item]] = true
            cell.isSelected = true
            cell.updateViewOnSelectionChanged()
            isButtonEnabled()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = daysCollectionView.cellForItem(at: indexPath) as? ButtonStyleCollectionViewCell {
            selectedDays[days[indexPath.item]] = false
            cell.isSelected = false
            cell.updateViewOnSelectionChanged()
            isButtonEnabled()
        }
    }
}

extension ProgressAddTimeSlotsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = daysCollectionView.dequeueReusableCell(withReuseIdentifier: "ButtonStyleCollectionViewCell", for: indexPath) as? ButtonStyleCollectionViewCell {
            cell.title = days[indexPath.item]
            cell.isSelected = (selectedDays[days[indexPath.item]]) ?? false
            cell.displayData(title: days[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension ProgressAddTimeSlotsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 44, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftInset = CGFloat(12)
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let totalItems = collectionView.numberOfItems(inSection: 0)
        let edgeSpacing = 12 + 12
        let totalCellWidth = (44 * totalItems) + edgeSpacing
        let collectionViewWidth = collectionView.layer.frame.size.width
        let remainingSpace = collectionViewWidth - CGFloat(totalCellWidth)
        let desiredWidth = remainingSpace / CGFloat(totalItems - 1)
        
        return desiredWidth
    }
}


extension ProgressAddTimeSlotsViewController: UITableViewDelegate {
    
}

extension ProgressAddTimeSlotsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TimeSlotTableViewCell") as? TimeSlotTableViewCell {
            cell.displayData(timeSlot: timeSlots[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}
