    //
    //  ViewController.swift
    //  ApplicationLifeCycleUIKIt
    //
    //  Created by mohit.dubey on 13/05/23.
    //

import UIKit

class ViewController: BaseUIViewController {
        //https://picsum.photos/1024/1024
    @IBOutlet weak var imageViewToSimulateMemoryLeak: UIImageView!
    let dispatchQueue = DispatchQueue(label: "ImageDownloadQueue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    @IBAction func moveToSecondViewControllerAction(_ sender: Any) {
        if let secondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
            navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
    private func fetchImage(completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/1024/1024")!) { data, response, error in
            if let data {
                completion(data)
            }
        }
        
        task.resume()
    }
    
    @IBAction func imageFetchWithMemoryLeak(_ sender: Any) {
        DispatchQueue.global().async {
            for _ in 1...1000 {
                guard let data = try? Data(contentsOf: URL(string: "https://picsum.photos/1024/1024")!),
                      let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.imageViewToSimulateMemoryLeak.image = image
                    MemoryUtility.reportMemory()
                }
            }
        }
    }
    
    @IBAction func imageFetchWithoutMemoryLeak(_ sender: Any) {
        DispatchQueue.global().async {
            for _ in 1...1000 {
                autoreleasepool {
                    guard let data = try? Data(contentsOf: URL(string: "https://picsum.photos/1024/1024")!),
                          let image = UIImage(data: data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.imageViewToSimulateMemoryLeak.image = image
                        MemoryUtility.reportMemory()
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("Mohit: ERROR - Received memory warning......")
    }
}

