# Kotlin Parser with ANTLR

## Project Overview
This project uses ANTLR to parse Kotlin code and build its abstract syntax tree (AST). The grammar file `proj.g4` defines the structure for recognizing various Kotlin statements like variable declarations, loops, class statements, methods, and more.

## Grammar Overview
The grammar supports parsing essential Kotlin constructs such as:
- **Imports**: Parsing `import` statements and imports from specific libraries.
- **Variable Definitions**: Handling variable and array declarations with optional initialization.
- **Control Structures**: Parsing `for`, `while`, `do-while` loops and `if-else`, `switch-case` conditions.
- **Classes**: Supporting class definitions, constructors, and object creation.
- **Methods**: Recognizing method declarations and method calls.
- **Exceptions**: Parsing `try-catch` blocks.
- **Print Statements**: Handling `print` function calls.
- **Expressions**: Supporting various expressions, including mathematical and logical operations.

### Core Grammar Sections:
1. **Imports**: Parses import statements like `import libName;` or `from lib import func1, func2;`.
2. **Variable Declarations**: Parses `var` and `const` declarations with optional initialization and array declarations.
3. **Loops**: Supports `for`, `while`, and `do-while` loops.
4. **Class Declarations**: Parses class declarations with optional inheritance and interfaces.
5. **Method Declarations**: Parses method definitions and function calls.
6. **Conditions**: Supports `if-else`, `elif`, and `switch-case` conditions.
7. **Exceptions**: Handles `try-catch` blocks and multiple catch statements.
8. **String Interpolation**: Recognizes string interpolations like `"$var"`.
9. **Expressions**: Supports assignment, return, and mathematical/logical expressions.

## Lexer Tokens
- **ACCESS_MODIFIER**: Parses visibility and mutability modifiers (`public`, `private`, etc.).
- **DATA_TYPES**: Supports types like `Boolean`, `Int`, `Double`, `String`, etc.
- **Operators**: Recognizes arithmetic, bitwise, comparison, and logical operators.

## Setup Instructions
1. **Install ANTLR**: Make sure you have ANTLR installed on your machine. You can download it from the official [ANTLR website](https://www.antlr.org/).
2. **Generate Parser and Lexer**:
    ```bash
    antlr4 proj.g4
    ```
3. **Compile the Generated Files**:
    ```bash
    javac proj*.java
    ```
4. **Run the Parser**:
    ```bash
    java org.antlr.v4.runtime.misc.TestRig proj start -tokens input.kt
    ```

## Usage Example
Given a text file like `test1.txt` or a Kotlin source file `input.kt`:
```kotlin
fun main() {
    val x = 10
    print(x)
}
```
