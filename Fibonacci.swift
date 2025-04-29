import Foundation

/**
 * Created by Val I on 2025-04-21
 * Version 1.0
 * Copyright (c) 2025 Val I. All rights reserved.
 *
 * The Fibonacci program reads an int from a file
 * and finds the fibonacci using recursion.
 *
 */

enum FibonacciError: Error {
    case invalidInput
}
// This function calculates fibonacci using recursion.
func fibonacci(_ number: Int) -> Int {
    if number == 0 {
        return 0
    } else if number == 1 {
        return 1
    } else {
        return fibonacci(number - 1) + fibonacci(number - 2)
    }
}

// File paths
let inputFilePath = "./input.txt"
let outputFilePath = "./output.txt"

// Open the input file for reading
guard let input = FileHandle(forReadingAtPath: inputFilePath) else {
    print("Error: can't find input file")
    exit(1)
}

// Open the output file for writing
guard let output = FileHandle(forWritingAtPath: outputFilePath) else {
    print("Error: can't open output file")
    exit(1)
}

// Read the contents of the input file
let inputData = input.readDataToEndOfFile()

// Convert the data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("Error: can't convert input data to string")
    exit(1)
}

// Split the string into lines
let inputLines = inputString.components(separatedBy: .newlines)

// Process each line
for line in inputLines {
    if !line.isEmpty {
        do {
            // Try to cast the line to an integer
            if let number = Int(line) {
                if number > 20 {
                    let warningMessage = "Number is too large.\n"
                    output.write(warningMessage.data(using: .utf8)!)
                } else if number < 0 {
                    let warningMessage = "Number is negative.\n"
                    output.write(warningMessage.data(using: .utf8)!)
                } else {
                    // Calculate the fibonacci of the number
                    let fibonacciResult = fibonacci(number)
                    let message = "Fibonacci of \(number): \(fibonacciResult)\n"
                    output.write(message.data(using: .utf8)!)
                }
            } else {
            throw FibonacciError.invalidInput
            }
        } catch FibonacciError.invalidInput {
            let errorMessage = "Invalid input '\(line)'. Not an integer.\n"
            output.write(errorMessage.data(using: .utf8)!)
        
        }

    }
}

// Close the input and output files
input.closeFile()
output.closeFile()