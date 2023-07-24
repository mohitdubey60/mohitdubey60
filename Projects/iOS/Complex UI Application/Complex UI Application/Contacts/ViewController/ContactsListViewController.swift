    //
    //  ContactsListViewController.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 09/08/22.
    //

import UIKit
import Contacts

class ContactsListViewController: UIViewController {
    
    @IBOutlet weak var contactsListTableView: UITableView!
    var contacts = [CNContact]()
    var contactFirstLetters: [String] = []
    var contactsDict: [String : [CNContact]] = [:]
    
    let store = CNContactStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ContactTableViewCell", bundle: nil)
        contactsListTableView.register(nib, forCellReuseIdentifier: "ContactTableViewCell")
        
        contactsListTableView.delegate = self
        contactsListTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestAccess {[weak self] accessGranted in
            if accessGranted {
                let keys = [
                    CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                    CNContactPhoneNumbersKey,
                    CNContactEmailAddressesKey
                ] as [Any]
                let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
                do {
                    try self?.store.enumerateContacts(with: request){
                        (contact, stop) in
                            // Array containing all unified contacts from everywhere
                        self?.contacts.append(contact)
                    }
                    
                    self?.getContacts()
                } catch {
                    print("unable to fetch contacts")
                }
            }
        }
    }
}

extension ContactsListViewController {
    fileprivate func requestPermissionPopup(_ completionHandler: @escaping (Bool) -> Void) {
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                completionHandler(true)
            } else {
                DispatchQueue.main.async {
                    self.showSettingsAlert(completionHandler)
                }
            }
        }
    }
    
    func requestAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:
                completionHandler(true)
            case .denied:
                showSettingsAlert(completionHandler)
            case .restricted, .notDetermined:
                fallthrough
            @unknown default:
                requestPermissionPopup(completionHandler)
        }
    }
    
    private func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Go to Settings to grant access.", preferredStyle: .alert)
        if
            let settings = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settings) {
            alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { action in
                completionHandler(false)
                UIApplication.shared.open(settings)
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
            completionHandler(false)
        })
        present(alert, animated: true)
    }
}

extension ContactsListViewController {
    func getContacts() {
        let regex = try! NSRegularExpression(pattern: "[A-Z]", options: [])
        
        contactsDict = Dictionary(grouping: contacts) { contact in
            let firstLetter = String(contact.givenName.uppercased().prefix(1))
            if regex.firstMatch(in: firstLetter, range: NSRange(location: 0, length: firstLetter.count)) != nil {
                return firstLetter
            } else {
                return "#"
            }
        }
        contactFirstLetters = contactsDict.keys.sorted()
        for item in contactFirstLetters {
            contactsDict[item] = contactsDict[item]?.sorted(by: { item1, item2 in
                item1.givenName < item2.givenName
            })
        }
        DispatchQueue.main.async {
            self.contactsListTableView.reloadData()
        }
    }
}

extension ContactsListViewController: UITableViewDelegate {
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactFirstLetters
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactFirstLetters[section].uppercased()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactFirstLetters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ContactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsDict[contactFirstLetters[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = contactsListTableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as? ContactTableViewCell,
           let cn = (contactsDict[contactFirstLetters[indexPath.section]])?[indexPath.row]{
            cell.displayData(contact: cn)
            return cell
        }
        
        return UITableViewCell()
    }
}
