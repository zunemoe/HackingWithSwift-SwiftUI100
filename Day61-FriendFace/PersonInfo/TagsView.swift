//
//  TagsView.swift
//  PersonInfo
//
//  Created by Zune Moe on 30/07/2021.
//

import SwiftUI

struct TagsView: View {
    var tags: [String]
    
    @State private var totalHeight
        = CGFloat.zero //variant for ScrollView/List
//        = CGFloat.infinity //variant for VStack
    
    var body: some View {
        VStack {
            GeometryReader{ geo in
                self.generateTags(in: geo)
            }
        }
        .frame(height: totalHeight) //variant for ScrollView/List
//        .frame(maxHeight: totalHeight) //variant for VStack
    }
    
    private func generateTags(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {            
            ForEach (self.tags, id: \.self) { tag in
                self.tagView(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading) { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0
                        }
                        return result
                    }
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func tagView(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.body)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(5)
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            let rect = geo.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView(tags: ["Hello World Testing", "Hello World", "World Testing", "Testing line limit with very long text. So this line must be very long"])
    }
}
