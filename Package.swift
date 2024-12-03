//
//  Package.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 02.12.2024.
//

import PackageDescription

let package = Package(
    name: "YourProject",
    dependencies: [
        .package(url: "https://github.com/vapor/postgres-nio.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: [
                .product(name: "PostgresNIO", package: "postgres-nio")
            ]),
    ]
)
