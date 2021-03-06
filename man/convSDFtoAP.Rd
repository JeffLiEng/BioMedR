% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/713-convSDFtoAP.R
\name{convSDFtoAP}
\alias{convSDFtoAP}
\title{Atom pair library}
\usage{
convSDFtoAP(sdfset, type = "AP", uniquePairs = TRUE)
}
\arguments{
\item{sdfset}{Objects of classes \code{SDFset} or \code{SDF}}

\item{type}{if \code{type="AP"}, the function returns \code{APset}/\code{AP}
            objects; if \code{type="character"}, it returns the result as a
            \code{character} vector of length one. The latter is useful for
            storing AP data in tabular files.}

\item{uniquePairs}{When the same atom pair occurs more than once in a single compound, should the
                   names be unique or not? Setting this to true will take slightly longer to compute.}
}
\value{
\item{APset}{ if input is \code{SDFset}}
        \item{AP}{ if input is \code{SDF}}
}
\description{
Atom pair library
}
\details{
Creates from a SDFset a searchable atom pair library that is stored in a
container of class APset.
}
\examples{
data(sdfbcl)

apset <- convSDFtoAP(sdfbcl)
}
\author{
Min-feng Zhu <\email{wind2zhu@163.com}>,
}
\keyword{convSDFtoAP}

