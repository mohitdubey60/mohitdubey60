//
//  CombineHomeViewController.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 08/08/22.
//

import UIKit
import Combine

class CombineHomeViewController: UIViewController {
    @IBOutlet weak var enableViewSwitch: UISwitch!
    @IBOutlet weak var getApiDataButton: UIButton!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var productsTableView: UITableView!
    
    @Published var isViewEnabled: Bool = false
    private var viewSubscribers: Set<AnyCancellable> = Set<AnyCancellable>()
    private var productListCancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    var productList: DummyProductsListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        $isViewEnabled.receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: darkModeSwitch)
            .store(in: &viewSubscribers)
        $isViewEnabled.receive(on: RunLoop.main)
            .assign(to: \.isUserInteractionEnabled, on: productsTableView)
            .store(in: &viewSubscribers)
        $isViewEnabled.receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: getApiDataButton)
            .store(in: &viewSubscribers)
        
        isViewEnabled = enableViewSwitch.isOn
        
        let nib = UINib(nibName: "ProductCellTableViewCell", bundle: nil)
        productsTableView.register(nib, forCellReuseIdentifier: "ProductCellTableViewCell")
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    deinit {
        for subscriber in viewSubscribers {
            subscriber.cancel()
        }
    }
    
    @IBAction func apiClickAction(_ sender: Any) {
        DummyProductService.shared
            .getProductListWithAnyPublisher(from: CombineAPIConstants.endpointForProductList)
            .sink {[weak self] completion in
            if case let .failure(error) = completion {
                switch error {
                    case let decodingError as DecodingError:
                        Swift.print("Mohit: Error in Decoding \(decodingError.localizedDescription)")
                    case let networkError as NetworkError:
                        Swift.print("Mohit: Error in Newtwork \(networkError.localizedDescription)")
                    default:
                        Swift.print("Mohit: Error is Unknown")
                }
            } else {
                self?.productsTableView.reloadData()
                for item in self?.productListCancellables ?? [] {
                    item.cancel()
                    self?.productListCancellables.remove(item)
                }
            }
        } receiveValue: {[weak self] value in
            self?.productList = value
        }
        .store(in: &productListCancellables)
    }
    
    @IBAction func enableViewValueChanged(_ sender: Any) {
        isViewEnabled = enableViewSwitch.isOn
    }
    
    @IBAction func darkViewValueChanged(_ sender: Any) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = darkModeSwitch.isOn ? .dark : .light
        }
    }
}

extension CombineHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}

extension CombineHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellTableViewCell") as? ProductCellTableViewCell,
            let item = productList?.products?[indexPath.row] {
            cell.display(data: item)
            return cell
        }
        
        return UITableViewCell()
    }
}
