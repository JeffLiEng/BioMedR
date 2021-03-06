% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/610-extractDNAPseKNC.R
\name{extrDNAPseKNC}
\alias{extrDNAPseKNC}
\title{The Pseudo K-tupler Composition Descriptor}
\usage{
extrDNAPseKNC(x, lambda = 1, k = 3, normalize = FALSE, w = 0.5,
  customprops = NULL)
}
\arguments{
\item{x}{the input data, which should be a list or file type.}

\item{lambda}{an integer larger than or equal to 0 and less than or equal to L-2 (L means the length of the shortest
              sequence in the dataset). It represents the highest counted rank (or tier) of the correlation along a
              DNA sequence. Its default value is 3.}

\item{k}{an integer larger than 0 represents the k-tuple. Its default value is 3.}

\item{normalize}{with this option, the final feature vector will be normalized based
                 on the total occurrences of all kmers. Therefore, the elements in the feature vectors
                 represent the frequencies of kmers. The default value of this parameter is False.}

\item{w}{the weight factor ranged from 0 to 1. Its default value is 0.05.}

\item{customprops}{the users can use their own indices to generate the feature vector. It should be a dict,
                   the key is dinucleotide (string), and its corresponding value is a list type.}
}
\value{
A vector
}
\description{
The Pseudo K-tupler Composition Descriptor
}
\details{
This function calculates the pseudo k-tupler composition Descriptor
}
\note{
if the user defined physicochemical indices have not been normalized, it should be normalized.
}
\examples{
x = 'GACTGAACTGCACTTTGGTTTCATATTATTTGCTC'
extrDNAPseKNC(x)
}
\author{
Min-feng Zhu <\email{wind2zhu@163.com}>
}
\references{
Guo S H, Deng E Z, Xu L Q, et al. iNuc-PseKNC: a sequence-based predictor for predicting nucleosome positioning
in genomes with pseudo k-tuple nucleotide composition. \emph{Bioinformatics}, 2014: btu083.
}
\seealso{
See \code{\link{extrDNAPseDNC}}
}
\keyword{PseKNC}
\keyword{extract}

