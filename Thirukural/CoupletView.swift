//
//  CoupletView.swift
//  Thirukural
//
//  Created by Anbarasu S on 29/03/20.
//  Copyright © 2020 Uyar Valluvam. All rights reserved.
//

import SwiftUI

struct CoupletView: View {
    private var selectedChapter: CDChapter
    private var fetchRequest: FetchRequest<CDCouplet>

    init(chapter: CDChapter) {
        self.selectedChapter = chapter

        let lastIndex = chapter.chapterIndex*10
        let firsIndex = lastIndex-9

        fetchRequest = FetchRequest<CDCouplet>(
        entity: CDCouplet.entity(),
        sortDescriptors: [NSSortDescriptor(key: "coupletIndex", ascending: true)],
        predicate: NSPredicate(format: "coupletIndex >= %d AND coupletIndex <= %d", firsIndex, lastIndex))
    }

    var body: some View {
        List {
            ForEach(fetchRequest.wrappedValue) { couplet in
                NavigationLink(destination: ExplanationView(couplet: couplet)) {
                    Text(couplet.coupletTamil)
                }

            }
        }

            .navigationBarTitle(Text("\(selectedChapter.chapterTamil)"))
    }
}
