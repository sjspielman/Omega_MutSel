Omega_MutSel
============

Repository for "The relationship between dN/dS and scaled selection coefficients", Stephanie J. Spielman and Claus O. Wilke.
All code written by SJS (contact at stephanie.spielman@gmail.com).

## Description of Contents ##

* datasets/  Contains tab-delimited summary files for simulated datasets.  All simulated alignments available from ...
 * [no_synsel.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/datasets/no_synsel.txt)
   * simulations with symmetric mutation rates and in which synonymous codons all have same fitness ([Figure 1A](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/MainText/dnds_variance.pdf), [Figure 2B](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/MainText/regression_convergence.pdf))
 * [synsel.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/datasets/synsel.txt)
   * simulations with symmetric mutation rates and in synonymous codons have different fitness ([Figure 1A](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/MainText/dnds_variance.pdf), [Figure 2B](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/MainText/regression_convergence.pdf))
 * [conv.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/datasets/conv.txt)
   * simulations to demonstrate convergence of omega to dN/dS ([[Figure 2C](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/MainText/regression_convergence.pdf)](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/MainText/regression_convergence_raw.pdf))
 * [np.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/datasets/np.txt)
   * simulations which use experimental NP amino acid fitness data ([Bloom 2014](http://mbe.oxfordjournals.org/content/31/8/1956)) in combination with NP mutation rates ([Bloom 2014](http://mbe.oxfordjournals.org/content/31/8/1956)) ([Figure 3](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/MainText/nyp_bias_r2.pdf), [Tables 1, S1, and S2](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/latex_tables.txt), and [Figure S1](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/SI/nyp_regression.pdf))
 * [yeast.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/datasets/yeast.txt)
   * simulations which use experimental NP amino acid fitness data ([Bloom 2014](http://mbe.oxfordjournals.org/content/31/8/1956)) in combination with yeast mutation rates ([Zhu 2014](http://www.pnas.org/content/111/22/E2310)) ([Figure 3](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/MainText/nyp_bias_r2.pdf), [Tables 1, S1, and S2](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/latex_tables.txt), and [Figure S1](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/SI/nyp_regression.pdf))
 * [polio.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/datasets/polio.txt)
   * simulations which use experimental NP amino acid fitness data ([Bloom 2014](http://mbe.oxfordjournals.org/content/31/8/1956)) in combination with polio virus mutation rates ([Acevedo 2014](http://www.nature.com/nature/journal/v505/n7485/full/nature12861.html)) ([Figure 3](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/MainText/nyp_bias_r2.pdf), [Tables 1, S1, and S2](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/latex_tables.txt), and [Figure S1](https://github.com/clauswilke/Omega_MutSel/blob/master/Manuscript/figures/SI/nyp_regression.pdf))

scripts/
- - - -
Contains scripts used in analysis. [NOTE: all simulated alignments were created using a custom sequence simulation library, [pyvolve](https://github.com/sjspielman/pyvolve). See within for details.]

 experimental_data/
 - - - -
   * [nucleoprotein_amino_preferences.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/experimental_data/nucleoprotein_amino_preferences.txt)
     * This file corresponds exactly to supplementary_file_1.xls from of [Bloom 2014](http://mbe.oxfordjournals.org/content/31/8/1956). Gives amino acid preference/fitness data for each of the 498 positions in NP. Each row is a position, and each column is the amino acid preference (alphabetical)
    * [np_codon_eqfreqs.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/experimental_data/np_codon_eqfreqs.txt)
      * Contains codon equilibrium frequencies computed from NP preference data and NP mutation rates. Each row is a position, and values are alphabetical (first column is AAA, second column is AAC, etc.). Generated by [prefs_to_freqs.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/np_scripts/prefs_to_freqs.py) .
    * [yeast_codon_eqfreqs.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/experimental_data/yeast_codon_eqfreqs.txt)
      * Contains codon equilibrium frequencies computed from yeast preference data and yeast mutation rates. Each row is a position, and values are alphabetical (first column is AAA, second column is AAC, etc.). Generated by [prefs_to_freqs.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/np_scripts/prefs_to_freqs.py) .
    * [polio_codon_eqfreqs.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/experimental_data/polio_codon_eqfreqs.txt)
      * Contains codon equilibrium frequencies computed from polio preference data and polio mutation rates. Each row is a position, and values are alphabetical (first column is AAA, second column is AAC, etc.). Generated by [prefs_to_freqs.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/np_scripts/prefs_to_freqs.py) .

 * np_scripts/
   * [prefs_to_freqs.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/np_scripts/prefs_to_freqs.py)
     * Compute equilibrium codon frequencies for a variety of frequency parameterizations from experimental NP amino acid fitness data in combination with either NP, yeast, or polio mutation rates. See script for full description.
    * [globalDNDS_raw_exp.bf](https://github.com/clauswilke/Omega_MutSel/blob/master/hyphy_files/globalDNDS_raw_exp.bf)
      * Template batchfile used by [prefs_to_freqs.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/np_scripts/prefs_to_freqs.py) to create [globalDNDS_{np/yeast/polio}.bf](https://github.com/clauswilke/Omega_MutSel/tree/master/hyphy_files) files.

 * simulation_scripts/   Scripts in this directory were created to run specifically on The University of Texas at Austin's Center for Computational Biology and Bioinformatics cluster, [Phylocluster](http://ccbb.biosci.utexas.edu/resources.html). All files w/ extension ".qsub" are job submission scripts corresponding to a particular python script, such that _xyz_.qsub goes with run_ *xyz*.py.
   * [run_sim_nyp.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/simulation_scripts/run_sim_nyp.py)
     * simulate alignments which use NP amino acid fitness data and either NP, yeast, or polio mutation rates
    * [run_nyp.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/simulation_scripts/run_nyp.py)
      * infer dN/dS, omega for NP, yeast, or polio datasets
    * [run_siminf.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/simulation_scripts/run_siminf.py)
      * simulate alignments and subsequently infer dN/dS and omega for the "synonymous selection" and "no synonymous selection" sets
    * [run_convergence.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/simulation_scripts/run_convergence.py)
      * simulate alignmets, infer dN/dS and omega to demonstrate omega convergence with data sets of increasing size
    * [functions_omega_mutsel.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/simulation_scripts/functions_omega_mutsel.py)
      * Contains functions used by scripts in this directory.

 * hyphy_files/        Contains files used in HYPHY inference.
   * [globalDNDS_fequal.bf](https://github.com/clauswilke/Omega_MutSel/blob/master/hyphy_files/globalDNDS_fequal.bf) 
     * hyphy batchfile to infer omega according to GY94 M0 model with Fequal (1/61 for all codons) frequency parameterization. Used to determined omega for no[synsel.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/datasets/conv.txt), [synsel.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/datasets/conv.txt), [conv.txt](https://github.com/clauswilke/Omega_MutSel/blob/master/datasets/conv.txt) .
    * [globalDNDS_np.bf](https://github.com/clauswilke/Omega_MutSel/blob/master/hyphy_files/globalDNDS_np.bf)
      * hyphy batchfile to infer omega for simulations with experimental NP amino acid fitness data and NP mutation rates, according to a variety of frequency parameterizations. Generated by [prefs_to_freqs.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/np_scripts/prefs_to_freqs.py) .
    * [globalDNDS_yeast.bf](https://github.com/clauswilke/Omega_MutSel/blob/master/hyphy_files/globalDNDS_yeast.bf)
      * hyphy batchfile to infer omega for simulations with experimental NP amino acid fitness data and yeast mutation rates, according to a variety of frequency parameterizations. Generated by [prefs_to_freqs.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/np_scripts/prefs_to_freqs.py) .
    * [globalDNDS_yeast.bf](https://github.com/clauswilke/Omega_MutSel/blob/master/hyphy_files/globalDNDS_yeast.bf)
      * hyphy batchfile to infer omega for simulations with experimental NP amino acid fitness data and polio mutation rates, according to a variety of frequency parameterizations. Generated by [prefs_to_freqs.py](https://github.com/clauswilke/Omega_MutSel/blob/master/scripts/np_scripts/prefs_to_freqs.py) .
    * [CF3x4.bf](https://github.com/clauswilke/Omega_MutSel/blob/master/hyphy_files/CF3x4.bf)
      * hyphy batchfile used in conjunction with [globalDNDS_{np/yeast/polio}.bf](https://github.com/clauswilke/Omega_MutSel/tree/master/hyphy_files) files to compute CF3x4 equilibrium codon frequencies.
    * [GY94.mdl](https://github.com/clauswilke/Omega_MutSel/blob/master/hyphy_files/GY94.mdl)
      * contains standard GY94 rate matrix
    * [MG_np.mdl](https://github.com/clauswilke/Omega_MutSel/blob/master/hyphy_files/MG_np.mdl)
      * contains MG1 and MG3 matrices for NP mutation rates 
    * [MG_yeast.mdl](https://github.com/clauswilke/Omega_MutSel/blob/master/hyphy_files/MG_yeast.mdl)
      * contains MG1 and MG3 matrices for yeast mutation rates 
    * [MG_polio.mdl](https://github.com/clauswilke/Omega_MutSel/blob/master/hyphy_files/MG_polio.mdl)
      * contains MG1 and MG3 matrices for polio mutation rates 











