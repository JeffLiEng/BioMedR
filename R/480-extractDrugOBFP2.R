#' Calculate the FP2 Molecular Fingerprints
#' 
#' Calculate the FP2 Molecular Fingerprints
#' 
#' Calculate the 1024 bit FP2 fingerprints provided by OpenBabel.
#' 
#' @param molecules R character string object containing the molecules. 
#' See the example section for details.
#' @param type \code{'smile'} or \code{'sdf'}.
#' 
#' @return A matrix. Each row represents one molecule, 
#' the columns represent the fingerprints.
#' 
#' @keywords extrDrugOBFP2
#'
#' @aliases extrDrugOBFP2
#' 
#' @author Min-feng Zhu <\email{wind2zhu@@163.com}>, 
#'         Nan Xiao <\url{http://r2s.name}>
#' 
#' @export extrDrugOBFP2
#' 
#' @examples
#' mol1 = 'C1CCC1CC(CN(C)(C))CC(=O)CC'  # one molecule SMILE in a vector
#' mol2 = c('CCC', 'CCN', 'CCN(C)(C)', 'c1ccccc1Cc1ccccc1', 
#'          'C1CCC1CC(CN(C)(C))CC(=O)CC')  # multiple SMILEs in a vector
#' 
#' smifp0 = extrDrugOBFP2(mol1, type = 'smile')
#' smifp1 = extrDrugOBFP2(mol2, type = 'smile')
#' 

extrDrugOBFP2 = function (molecules, type = c('smile', 'sdf')) {

    if (type == 'smile') {

        if ( length(molecules) == 1L ) {
           
            mol = ChemmineOB::forEachMol("SMILES", molecules, identity)
            fp = ChemmineOB::fingerprint_OB(mol, 'FP2')

            } else if ( length(molecules) > 1L ) {

                fp = matrix(0L, nrow = length(molecules), ncol = 1024L)

                for ( i in 1:length(molecules) ) {
                    mol = ChemmineOB::forEachMol("SMILES", molecules[i], identity)
                    fp[i, ] = ChemmineOB::fingerprint_OB(mol, 'FP2')
                }

            }

        } else if (type == 'sdf') {

            smi = ChemmineOB::convertFormat(from = 'SDF', to = 'SMILES', 
                                            source = molecules)
            smiclean = strsplit(smi, '\\t.*?\\n')[[1]]

            if ( length(smiclean) == 1L ) {
  
                smi = ChemmineOB::forEachMol("SMILES", smiclean, identity)
                fp = ChemmineOB::fingerprint_OB(smi, 'FP2')

                } else if ( length(smiclean) > 1L ) {

                    fp = matrix(0L, nrow = length(smiclean), ncol = 1024L)
                    for ( i in 1:length(smiclean) ) {
                        smi = ChemmineOB::forEachMol("SMILES", smiclean[i], identity)
                        fp[i, ] = ChemmineOB::fingerprint_OB(smi, 'FP2')
                    }

                }

            } else {

                stop('Molecule type must be "smile" or "sdf"')

            }

    return(fp)

}
