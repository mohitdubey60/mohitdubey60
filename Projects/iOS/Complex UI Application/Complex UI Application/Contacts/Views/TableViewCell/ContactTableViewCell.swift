//
//  ContactTableViewCell.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 09/08/22.
//

import UIKit
import Contacts

class ContactTableViewCell: UITableViewCell {

    var contact: CNContact!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var phoneNumbersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateContactRow(_ contact: CNContact) {
        let displayString = !contact.givenName.isEmpty ? contact.givenName : (!contact.familyName.isEmpty ? contact.familyName : contact.phoneNumbers.first?.value.stringValue)
        let phoneNumberText = contact.phoneNumbers.count > 1 ? "\(contact.phoneNumbers.count) phone numbers available" : "\(contact.phoneNumbers.first?.value.stringValue ?? "")"
        contactName.text = displayString
        phoneNumbersLabel.text = phoneNumberText
    }
    
    func displayData(contact: CNContact) {
        self.contact = contact
        updateContactRow(contact)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateContactRow(contact)
    }
    
}
