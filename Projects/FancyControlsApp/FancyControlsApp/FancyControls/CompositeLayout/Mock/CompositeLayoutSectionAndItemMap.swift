//
//  CompositeLayoutSectionAndItemMap.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 13/11/22.
//

import Foundation

struct CompositeLayoutSectionMapping {
    var itemCount: Int
    var layoutType: CompositeLayoutTypes
    var headerString: String = ""
}

struct CompositeLayoutSectionAndItemMap {
    static var sectionItemMap: [Int : CompositeLayoutSectionMapping] = [0 : CompositeLayoutSectionMapping(itemCount: 3, layoutType: .pager300),
                                                                        1 : CompositeLayoutSectionMapping(itemCount: 8, layoutType: .grid4Column, headerString: "4 column grid"),
                                                                        2 : CompositeLayoutSectionMapping(itemCount: 8, layoutType: .horizontalListWidthRectangles, headerString: "Horizontal continuous list"),
                                                                        3 : CompositeLayoutSectionMapping(itemCount: 8, layoutType: .grid2Column, headerString: "2 column grid")]
}
