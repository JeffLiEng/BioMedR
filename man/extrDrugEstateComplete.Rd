% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/476-extractDrugEstate.R
\name{extrDrugEstateComplete}
\alias{extrDrugEstateComplete}
\title{Calculate the E-State Molecular Fingerprints (in Complete Format)}
\usage{
extrDrugEstateComplete(molecules, silent = TRUE)
}
\arguments{
\item{molecules}{Parsed molucule object.}

\item{silent}{Logical. Whether the calculating process
should be shown or not, default is \code{TRUE}.}
}
\value{
An integer vector or a matrix. Each row represents one molecule,
the columns represent the fingerprints.
}
\description{
Calculate the E-State Molecular Fingerprints (in Complete Format)
}
\details{
79 bit fingerprints corresponding to the E-State atom types
described by Hall and Kier.
}
\examples{
smi = system.file('vignettedata/test.smi', package = 'BioMedR')
mol = readMolFromSmi(smi, type = 'mol')
fp  = extrDrugEstateComplete(mol)
dim(fp)
}
\author{
Min-feng Zhu <\email{wind2zhu@163.com}>,
        Nan Xiao <\url{http://r2s.name}>
}
\seealso{
\link{extrDrugEstate}
}
\keyword{extrDrugEstateComplete}

