    //
    //  SetProgressHoursViewController.swift
    //  ProgressTrackerApp-iOS-UIKit
    //
    //  Created by mohit.dubey on 10/02/23.
    //

import UIKit

class SetProgressHoursViewController: BaseViewController {
    @IBOutlet weak var daysCollectionView: UICollectionView!
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    @IBOutlet weak var addHoursActionButton: UIButton!
    
    @IBOutlet weak var uiTableViewParentContainer: UIView!
    @IBOutlet weak var progressTimeLogsTV: UITableView!
    
    var vm: SetProgressHoursViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        setupTableView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            self?.shouldShowError()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func addLogsAction(_ sender: Any) {
        let st = startTime.date
        let et = endTime.date
        
        vm.addSelectedDays(startDateTime: st, endDateTime: et) { result, message in
            if !result {
                print("Error=> \(message)")
            } else {
                print("Success=> \(message)")
            }
        }
    }
    
}

    //MARK: -ErrorView
extension SetProgressHoursViewController {
    func shouldShowError() {
        if vm.dayLogs.values.count > 0 {
            removeErrorState()
        } else {
            showErrorState()
        }
    }
    
    func removeErrorState() {
        if let localView = uiTableViewParentContainer.subviews.first(where: { $0 is ErrorView }) {
            localView.removeFromSuperview()
        }
    }
    
    func showErrorState() {
        if let localView = self.uiTableViewParentContainer.subviews.compactMap({ localView in
            if localView is ErrorView {
                return localView
            }
            return nil
        }).first {
            localView.removeFromSuperview()
        }
        
        if let errorView = UINib(nibName: ErrorView.className, bundle: .main).instantiate(withOwner: nil, options: nil).first as? ErrorView {
            self.uiTableViewParentContainer.addSubview(errorView)
            errorView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                errorView.leadingAnchor.constraint(equalTo: self.uiTableViewParentContainer.leadingAnchor),
                errorView.trailingAnchor.constraint(equalTo: self.uiTableViewParentContainer.trailingAnchor),
                errorView.topAnchor.constraint(equalTo: self.uiTableViewParentContainer.topAnchor),
                errorView.bottomAnchor.constraint(equalTo: self.uiTableViewParentContainer.bottomAnchor)
            ])
            
            errorView.setupErrorView(errorType: .noContent, errorImage: nil, title: "No logs available", description: "Add new productive hours to show more logs", actionButtonText: nil, completion: nil)
        }
    }
}

    //MARK: -Collection view
extension SetProgressHoursViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func setupCollectionView() {
        registerCollectionViewCells()
        daysCollectionView.dataSource = self
        daysCollectionView.delegate = self
        daysCollectionView.allowsMultipleSelection = true
        
        setCollectionViewLayout(for: daysCollectionView)
        controlActionOnDaysSelectionChange(indexes: daysCollectionView.indexPathsForSelectedItems ?? [])
    }
    
    private func setCollectionViewLayout(for collectionView: UICollectionView) {
        let availableWidth = collectionView.bounds.width
        let availableSize = floor(availableWidth/8)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: availableSize, height: availableSize)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView.collectionViewLayout = layout
    }
    
    private func registerCollectionViewCells() {
        daysCollectionView.register(UINib(nibName: DaysCollectionViewCell.className, bundle: .main), forCellWithReuseIdentifier: DaysCollectionViewCell.className)
    }
    
    private func controlActionOnDaysSelectionChange(indexes: [IndexPath]) {
        UIView.animate(withDuration: 0.1, delay: 0) {[weak self] in
            guard let self else {
                return
            }
            
            self.addHoursActionButton.isEnabled = self.vm.collectionViewAllSelectedItems(indexes: indexes)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysCollectionViewCell.className, for: indexPath)
        if let dequedCell = cell as? DaysCollectionViewCell {
            dequedCell.prepareCellForDisplay(dayOfWeek: vm.days[indexPath.item])
            return dequedCell
        }
        
        fatalError(CollectionControlErrors.noMatchingCellToDequeue.localizedDescription)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        controlActionOnDaysSelectionChange(indexes: collectionView.indexPathsForSelectedItems ?? [])
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        controlActionOnDaysSelectionChange(indexes: collectionView.indexPathsForSelectedItems ?? [])
    }
}

    //MARK: -TableView
extension SetProgressHoursViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        progressTimeLogsTV.delegate = self
        progressTimeLogsTV.dataSource = self
        progressTimeLogsTV.separatorStyle = .none
        registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        progressTimeLogsTV.register(UINib(nibName: WeekRowTableViewCell.className, bundle: .main), forCellReuseIdentifier: WeekRowTableViewCell.className)
        progressTimeLogsTV.register(UINib(nibName: NoDataTableViewCell.className, bundle: .main), forCellReuseIdentifier: NoDataTableViewCell.className)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        DaysOfWeek.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let day = DaysOfWeek.allCases[section]
        return day.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day = DaysOfWeek.allCases[section]
        if let count = vm.dayLogs[day.rawValue]?.count, count > 0 {
            return count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day = DaysOfWeek.allCases[indexPath.section]
        if let logs = vm.dayLogs[day.rawValue], logs.count > 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: WeekRowTableViewCell.className, for: indexPath) as? WeekRowTableViewCell {
                let log = logs[indexPath.row]
                cell.displayData(title: "\(log.sd?.dateToHHmm() ?? "") - \(log.ed?.dateToHHmm() ?? "")", subtitle: "", leftText: "\(log.diffInMinutes)")
                cell.selectionStyle = .none
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.className, for: indexPath) as? NoDataTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GoalsDashboardViewController.getInstance()
        navigationController?.pushViewController(vc, animated: true)
    }
}

    //MARK: -DaysObserver Protocol
extension SetProgressHoursViewController: DayLogsObserver {
    func daysUpdated() {
        DispatchQueue.main.async {[weak self] in
            guard let self else {
                return
            }
            
            self.progressTimeLogsTV.reloadData()
            self.shouldShowError()
        }
    }
}
