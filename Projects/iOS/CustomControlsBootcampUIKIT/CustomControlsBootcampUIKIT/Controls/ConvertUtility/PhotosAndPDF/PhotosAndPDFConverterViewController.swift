//
//  PhotosAndPDFConverterViewController.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 20/07/23.
//

import UIKit

class PhotosAndPDFConverterViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let photoAndPDFConvertView = PhotosAndPDFConvertSwiftUIView(pdfCompressVM: PDFCompressViewModel())
        addSwiftUIViewToController(photoAndPDFConvertView)
    }
}
