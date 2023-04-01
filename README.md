# Recursive-Size-Reporter-RSR-

RSR is an R function that can be used to monitor directory growth, identify large files/directories to remove or compress, or to analyze disk space usage in a project. It recursively reports the size of files and directories in a given path and returns a data frame with two columns: "path" and "size". The "path" column lists the full path of each item (file or directory) in the directory tree, and the "size" column lists the size of each item in bytes.

## Usage

To use RSR, simply source the R file containing the function definition, and call the function with the desired path as the input parameter:

- `path`: a character string specifying the path of the directory to be analyzed.
- `patt`: a character string specifying a regular expression pattern to match against files and directories. Only files and directories matching this pattern will be included in the report. The default value is ".*", which matches all files and directories.
- `dironly`: a logical value specifying whether to only include directories in the report. The default value is `FALSE`.
- `level`: an integer value specifying the depth of recursion when analyzing subdirectories. The default value is `Inf`, which means that all subdirectories will be analyzed.

The function returns a data frame with two columns: "path" and "size". Each row of the data frame represents a file or directory in the specified directory and its size in bytes.

The function first checks if the `level` argument is 0. If so, it returns the size of the specified directory. Otherwise, it uses the `list.files()` function to get a list of all items in the directory and iterates over each item in the list. For each item, the function checks if it matches the specified pattern and whether it is a directory (if `dironly` is `TRUE`). If the item is a directory, the function either recurses into the subdirectory (if the current level is less than the specified level) or adds its size to the report. If the item is a file, the function adds its size to the report.

## Application 

- Monitoring the growth of a directory over time
- Identifying large files or directories that can be removed or compressed
- Analyzing disk space usage in a project or system
