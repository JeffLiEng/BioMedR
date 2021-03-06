#' The Trinucleotide-based Cross Covariance Descriptor
#' 
#' The Trinucleotide-based Cross Covariance Descriptor
#'
#' This function calculates the trinucleotide-based cross covariance Descriptor
#' 
#' @param x the input data, which should be a list or file type.
#' 
#' @param index the physicochemical indices, it should be a list and there are 12
#'              different physicochemical indices (Table 2), which the users can choose.
#'
#' @param nlag an integer larger than or equal to 0 and less than or equal to L-2 (L means the length 
#'             of the shortest DNA sequence in the dataset). It represents the distance between two dinucleotides.
#'
#' @param normaliztion with this option, the final feature vector will be normalized based
#'                  on the total occurrences of all kmers. Therefore, the elements in the feature vectors 
#'                  represent the frequencies of kmers. The default value of this parameter is False.
#'        
#' @param customprops the users can use their own indices to generate the feature vector. It should be a dict, 
#'                    the key is dinucleotide (string), and its corresponding value is a list type.                       
#' 
#' @return A vector 
#' 
#' @keywords extract TCC
#' 
#' @aliases extrDNATCC
#' 
#' @author Min-feng Zhu <\email{wind2zhu@@163.com}>
#' 
#' @export extrDNATCC
#' 
#' @seealso See \code{\link{extrDNATAC}} and \code{\link{extrDNATACC}}
#'          
#' @note if the user defined physicochemical indices have not been normalized, it should be normalized.
#' 
#' @examples
#'  
#' x = 'GACTGAACTGCACTTTGGTTTCATATTATTTGCTC'
#' extrDNATCC(x)
#'
extrDNATCC = function (x, index = c('Dnase I', 'Nucleosome'), nlag = 2, 
                      customprops = NULL, normaliztion = FALSE) {
  if (!checkDNA(x)) 
    stop('x has character except A, G, C, T !' )
  
  Tidx = read.csv(system.file('sysdata/12_trinucleotide_physicochemical_indices.csv', package = 'BioMedR'), header = TRUE)
  
  tidx = Tidx[, -1]
  row.names(tidx) = Tidx[, 1]
  
  if (!is.null(customprops)) {
    tidx = rbind(tidx, customprops)
    index = c(as.character(index), rownames(customprops))
  }

  n = length(index)
  
  ####normaliztion####
  Tdict = make_kmer_index(k = 3)
  if (normaliztion) {
    indmean = rowMeans(tidx[index, ])
    indsd   = apply(tidx[index, ], 1, sd) 
    
    Pr = data.frame(matrix(ncol = 64, nrow = n))
    for (i in 1:n) Pr[i, ] = (tidx[index[i], ] - indmean[i])/indsd[i]
    names(Pr) = Tdict
  }
  else  Pr = tidx[index, ]
  
 
  xSplit = strsplit(x, split = "")[[1]]
  xPaste = paste0(xSplit[1:(length(xSplit) - 2)], xSplit[2:(length(xSplit) - 1)],
                  xSplit[3:(length(xSplit))])
  P = vector('list', n)
  for (i in 1:n) P[[i]] = xPaste
  for (i in 1:n) {
    for (j in Tdict) {
      try(P[[i]][which(P[[i]] == j)] <- Pr[i, j], silent = TRUE)
       }
  }
  P = lapply(P, as.numeric)
  
  ###########################################################
  
  TCC = vector("numeric", n * (n-1) * nlag)
  N  = length(xPaste)
  
  idx = combn(1:n, 2)
  
  i = 0
  for (k in 1:dim(idx)[2]) {
  
   for (j in 1:nlag) {
     Pbar = lapply(seq_along(P), function(i) P[[i]][1:(N-j)])
     Pbar = sapply(Pbar, sum)/nchar(x)
     TCC[j + 4 * i] = (sum((P[[idx[1, k]]][1:(N - j)] - Pbar[idx[1, k]]) * (P[[idx[2, k]]][(1:(N - j)) + j] - Pbar[idx[2, k]])))/(N-j)
     names(TCC)[j + 4 * i] = c(paste(index[idx[1, k]], index[idx[2, k]], 'lag', j, sep = "."))
     
   }
   for (j in 1:nlag) {
     Pbar = lapply(seq_along(P), function(i) P[[i]][1:(N-j)])
     Pbar = sapply(Pbar, sum)/nchar(x)
     TCC[(nlag + j) + 4 * i] = (sum((P[[idx[2, k]]][1:(N - j)] - Pbar[idx[2, k]]) * (P[[idx[1, k]]][(1:(N - j)) + j] - Pbar[idx[1, k]])))/(N-j)
     names(TCC)[(nlag + j) + 4 * i] = c(paste(index[idx[2, k]], index[idx[1, k]], 'lag', j, sep = "."))
     
   }
   i = i + 1
  }

  TCC = round(TCC, 3)
  return(TCC)
  
  
}
