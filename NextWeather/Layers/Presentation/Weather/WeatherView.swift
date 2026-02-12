//
//  WeatherView.swift
//  NextWeather
//
//  Created by Maros Petrus on 12.02.26.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject private var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("NextWeather")
                .task {
                    await viewModel.load()
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            VStack(spacing: 12) {
                ProgressView()
                Text("Loading…")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded:
            VStack(alignment: .leading, spacing: 16) {
                Text("Konstanz")
                    .font(.title)
                    .bold()
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("20")
                        .font(.system(size: 48, weight: .semibold, design: .rounded))
                    Text("°C")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                Text("Feels like 23°C")
                    .foregroundStyle(.secondary)
                Text("Feels warmer")
                    .font(.callout)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
                Button {
                    Task { await viewModel.load() }
                } label: {
                    Text("Refresh")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        case .failed(let message):
            VStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)

                Text("Something went wrong")
                    .font(.headline)

                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Button("Retry") {
                    Task { await viewModel.load() }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    WeatherView(viewModel: .init())
}
