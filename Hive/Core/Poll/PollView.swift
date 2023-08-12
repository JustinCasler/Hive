//
//  PollView.swift
//  Hive
//
//  Created by justin casler on 6/2/23.
//

import SwiftUI
import Foundation

struct PollView: View {
    struct Data: Identifiable
    {
        var id = UUID()
        var label: String
        var votes: Double
    }
    
    private var pollData: [Data] = []
    @State private var agreeVotes: Int
    @State private var disagreeVotes: Int
    
    init(agreeVotes: Int, disagreeVotes: Int) {
        self.agreeVotes = agreeVotes
        self.disagreeVotes = disagreeVotes
        updatePollData()
    }
    
    var body: some View {
        GeometryReader{
            geometry in
            VStack(alignment: .leading, spacing: 0) {
                let rowHeight = geometry.size.height / (CGFloat(pollData.count)*1)
                let labelWidth = geometry.size.width * 0.16
                let graphWidth = geometry.size.width * 0.6
                let valueWidth = geometry.size.width * 0.10
                
                ForEach(pollData) { data in
                    HStack{
                        Button {

                        } label: {
                            Text(data.label)
                                .font(.caption)
                                .bold()
                                .frame(maxWidth: labelWidth, maxHeight : .infinity, alignment: .center)
                        }
                        .foregroundColor(.black)
                        let rowWidth = calculateRowWidth(graphWidth, data)
                        
                        Rectangle()
                            .cornerRadius(5)
                            .padding(.vertical, 5)
                            .frame(maxWidth: . infinity)
                            .frame(maxWidth: rowWidth, maxHeight: .infinity, alignment: .leading)
                            .foregroundColor(Color.brown)
                        Text(String(Int(data.votes)))
                            .font(.caption2)
                            .frame(maxWidth: valueWidth, maxHeight: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: rowHeight)
                }
                
            }
            
        }
    }
    
    mutating func updatePollData() {
        pollData = [
            Data(label: "Agree", votes: Double(agreeVotes)),
            Data(label: "Disagree", votes: Double(disagreeVotes))
        ]
    }
    
    func calculateRowWidth(_ graphWidth: Double,_ data: Data) -> Double {
        let size = data.votes / maxCount() * graphWidth
        return size.isNaN ? 0.0 : size
    }
    
    func maxCount() -> Double {
        var largest = 0.0
        
        for data in pollData {
            if Double(data.votes) > largest{
                largest = Double(data.votes)
            }
        }
        return largest
    }
    
    func RandomNumber () -> Double {
        return Double(Int.random(in: 0...5000))
    }
}
