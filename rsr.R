# Create the rsr function
rsr <- function(path, patt=".*", dironly=FALSE, level=Inf) {
  
  # Initialize an empty data frame to store the report
  report <- data.frame(path = character(), size = numeric())
  
  # check if level = 0 
  if(level==0){
    # check if directory exists 
    if(dir.exists(path)){
      # add path and size of the directory to the report 
      report <- rbind(report, data.frame(path = path, size = sum(file.size(list.files(path,recursive = T, full.names = T)))))
    }
    return(report)
  }
  else{
    # add root directory always on the top
    report <- rbind(report, data.frame(path = path, size = sum(file.size(list.files(path,recursive = T, full.names = T)))))
    # Use the list.files() function to get a list of all items in the directory
    items <- list.files(path, recursive = ifelse(level == 1, FALSE, TRUE), pattern = patt, include.dirs = TRUE)
    if(!any(grepl(patt, items))) stop("No files or directories match the specified pattern.")
    
    # Iterate over each item in the list
    for (item in items) {
      # Get the full path of the item
      item_path <- file.path(path, item)
      # Check if the item is a directory 
      if (dironly == TRUE && !dir.exists(item_path)) {
        next
      }
      else{
        # Get the size of the item
        if(dir.exists(item_path)){
          item_size <- sum(file.size(list.files(item_path,recursive = T, full.names = T)))
        }
        else{
          item_size <- file.size(item_path)
        }
        # Add the item's path and size to the report data frame
        report <- rbind(report, data.frame(path = item_path, size = item_size))
      }
    }
    return(report)
  }
}