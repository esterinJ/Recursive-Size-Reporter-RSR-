# Create the sizeReport function
sizeReport <- function(path, patt=".*", dironly=FALSE, level=Inf) {
  
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

# Example how it works 

#1
sizeReport(path = "../")

#                                  path    size
#1                                  ../ 5110155
#2                              ..//1.R    1769
#3                             ..//Root 5108386
#4                           ..//Root/1   25272
#5                 ..//Root/1/Fig1.docx   20779
#6                  ..//Root/1/Fig2.bib    4493
#7                           ..//Root/2  308201
#8                  ..//Root/2/Fig3.csv     488
#9                ..//Root/2/Fig4.pages  307713
#10                          ..//Root/3 4774913
#11              ..//Root/3/infin.pages  388064
#12 ..//Root/3/Int_Fin_Formulario.pages 3506382
#13      ..//Root/3/IntFin_Formule.docx   19843
#14       ..//Root/3/PWE_Seminars.pages  860624


#2
options(width = 200)
sizeReport("~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root")

#                                                                                                                 path    size
# 1                             ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root 5108386
# 2                           ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/1   25272
# 3                 ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/1/Fig1.docx   20779
# 4                  ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/1/Fig2.bib    4493
# 5                           ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/2  308201
# 6                  ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/2/Fig3.csv     488
# 7                ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/2/Fig4.pages  307713
# 8                           ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/3 4774913
# 9               ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/3/infin.pages  388064
# 10 ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/3/Int_Fin_Formulario.pages 3506382
# 11      ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/3/IntFin_Formule.docx   19843
# 12       ~/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/R/Project_1/Root/3/PWE_Seminars.pages  860624


#3 
sizeReport(path = "../", level = 0)

#   path    size
# 1  ../ 5110155

#4
sizeReport(path = "../", level = 1)

#       path    size
# 1      ../ 5110155
# 2  ..//1.R    1769
# 3 ..//Root 5108386

#5 
sizeReport(path = "../", level = 2)

#                                   path    size
# 1                                  ../ 5110155
# 2                              ..//1.R    1769
# 3                             ..//Root 5108386
# 4                           ..//Root/1   25272
# 5                 ..//Root/1/Fig1.docx   20779
# 6                  ..//Root/1/Fig2.bib    4493
# 7                           ..//Root/2  308201
# 8                  ..//Root/2/Fig3.csv     488
# 9                ..//Root/2/Fig4.pages  307713
# 10                          ..//Root/3 4774913
# 11              ..//Root/3/infin.pages  388064
# 12 ..//Root/3/Int_Fin_Formulario.pages 3506382
# 13      ..//Root/3/IntFin_Formule.docx   19843
# 14       ..//Root/3/PWE_Seminars.pages  860624

#6
sizeReport(path = "../", dironly = TRUE)

#         path    size
# 1        ../ 5110155
# 2   ..//Root 5108386
# 3 ..//Root/1   25272
# 4 ..//Root/2  308201
# 5 ..//Root/3 4774913
 

#7
sizeReport(path = "../", patt = "pages$")

#                                 path    size
# 1                                 ../ 5110155
# 2               ..//Root/2/Fig4.pages  307713
# 3              ..//Root/3/infin.pages  388064
# 4 ..//Root/3/Int_Fin_Formulario.pages 3506382
# 5       ..//Root/3/PWE_Seminars.pages  860624

#8
sizeReport(path = "../", patt = "Fig[1-4]")

#                    path    size
# 1                   ../ 5110155
# 2  ..//Root/1/Fig1.docx   20779
# 3   ..//Root/1/Fig2.bib    4493
# 4   ..//Root/2/Fig3.csv     488
# 5 ..//Root/2/Fig4.pages  307713

#9 
sizeReport(path = "../", patt = "Fig[^1-4]")

# Error in sizeReport(path = "../", patt = "Fig[^1-4]") : 
#   No files or directories match the specified pattern.

#10 
sizeReport(path = "../", patt = "Root", dironly = T, level = 1)

#       path    size
# 1      ../ 5110155
# 2 ..//Root 5108386
