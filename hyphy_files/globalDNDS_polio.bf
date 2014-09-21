/* SJS. 
Hyphy inference for an "experimental" dataset. Name of file indicates the mutation scheme.
Perform 6 total inferences, one for each of the following parameterizations: F61, F1x4, F3x4, CF3x4, Fnuc1 (goes w/ F1x4), Fnuc3 (goes w/ F3x4).
*/



global w; global k; global t; // note that we use "global t" (instead of locally estimated for each branch) since all branch lengths are the same in the simulation tree.

LIKELIHOOD_FUNCTION_OUTPUT = 1;
RANDOM_STARTING_PERTURBATIONS = 1;
OPTIMIZATION_PRECSION = 0.00000001;
#include "CF3x4.bf"; // to compute the CF3x4 frequencies
#include "GY94.mdl"; // Basic GY94 rate matrix
#include "fnuc.mdl"; // Custom Fnuc matrices for this run

/* Read in the data */
DataSet	raw_data = ReadDataFile("temp.fasta");

/* Filter the data to find and remove any stop codons*/
DataSetFilter   filt_data = CreateFilter(raw_data,3,"", "","TAA,TAG,TGA");


/* Set up frequencies. Note that these were all hard-coded in when the file was created via the script Omega_MutSel/np_scripts/prefs_to_freqs.py */

F61 = {{0.0658980266826},{0.0190980345093},{0.0125857102076},{0.072349648091},{0.0210171897485},{0.00639141874678},{0.00384026978991},{0.0242807457662},{0.0210622090622},{0.00420643998084},{0.00406483237882},{0.0159297041123},{0.0638000297411},{0.0183735246636},{0.0139628462019},{0.0698366867892},{0.0182849984315},{0.00466208605275},{0.00346875997338},{0.0176638732659},{0.00492059634909},{0.001523211736},{0.000903157403057},{0.0057863328958},{0.00512747727706},{0.00174366482802},{0.000919510926147},{0.00662577003547},{0.0209665374133},{0.00646009947811},{0.00391109537835},{0.0245361497935},{0.012814071735},{0.0032004656305},{0.00244560551775},{0.0121239466572},{0.00536653684769},{0.00164149287406},{0.000980975308666},{0.00623578423683},{0.0032463035022},{0.000981488590594},{0.000591873778875},{0.00372654975179},{0.0132435940758},{0.00400634967157},{0.0024193390934},{0.015219017099},{0.014986930627},{0.0566508200549},{0.0282138336754},{0.00870744628024},{0.0051908162612},{0.0330723232855},{0.00334643689084},{0.00119140937619},{0.0126433880064},{0.0793412947578},{0.0186147553317},{0.0150255793603},{0.0705709340124}};

F1x4 = {{0.0561142529503},{0.0202853562964},{0.0123240708202},{0.0620895998445},{0.0202853562964},{0.00733317576976},{0.00445516342937},{0.0224454499334},{0.0123240708202},{0.00445516342937},{0.00270666922567},{0.0136364040409},{0.0620895998445},{0.0224454499334},{0.0136364040409},{0.0687012337536},{0.0202853562964},{0.00733317576976},{0.00445516342937},{0.0224454499334},{0.00733317576976},{0.00265095007869},{0.0016105458555},{0.00811405169266},{0.00445516342937},{0.0016105458555},{0.000978463522768},{0.00492957314813},{0.0224454499334},{0.00811405169266},{0.00492957314813},{0.024835561937},{0.0123240708202},{0.00445516342937},{0.00270666922567},{0.0136364040409},{0.00445516342937},{0.0016105458555},{0.000978463522768},{0.00492957314813},{0.00270666922567},{0.000978463522768},{0.000594451168289},{0.00299488989512},{0.0136364040409},{0.00492957314813},{0.00299488989512},{0.0150884815479},{0.0224454499334},{0.0687012337536},{0.0224454499334},{0.00811405169266},{0.00492957314813},{0.024835561937},{0.00492957314813},{0.00299488989512},{0.0150884815479},{0.0687012337536},{0.024835561937},{0.0150884815479},{0.0760169099347}};

F3x4 = {{0.0532929346101},{0.0173012027681},{0.0104886083817},{0.0656074239331},{0.0266389919871},{0.00864817457097},{0.00524283296989},{0.0327945093141},{0.0143931629796},{0.00467264625239},{0.00283272540669},{0.0177190157053},{0.074199189713},{0.0240882817928},{0.0146031786171},{0.0913445230705},{0.0155600364485},{0.00505146409454},{0.00306237834167},{0.0191555206175},{0.00777783564189},{0.00252502348617},{0.00153075961573},{0.00957507339335},{0.00420239835188},{0.00136428114778},{0.000827076063633},{0.00517345370872},{0.0216640743249},{0.00703310008017},{0.00426371700505},{0.02667002894},{0.0107688993465},{0.00349605276097},{0.00211943231827},{0.0132572872913},{0.00538293913632},{0.00174753599454},{0.00105941886962},{0.00662678406634},{0.00290842537645},{0.000944201281879},{0.000572408612966},{0.00358048019023},{0.0149934247656},{0.00486751731643},{0.00295086322075},{0.0184579810063},{0.0137695745942},{0.0522152320789},{0.0212012767088},{0.00688285586007},{0.00417263358112},{0.0261002918891},{0.00371883689169},{0.00225449203244},{0.0141021009788},{0.0590531936581},{0.0191712332049},{0.0116222877667},{0.0726987158667}};

pos_freqs = {{0.436697316472,0.316232977436,0.363302699299},{0.127503321237,0.158072131205,0.117943845892},{0.088243394371,0.0854070584978,0.0715017809555},{0.34755596792,0.440287832861,0.447251673853}};
CF3x4_ = BuildCodonFrequencies(CF3x4(pos_freqs, "TAA,TAG,TGA"));


/* Optimize likelihoods for each frequency specification */


////////////// F61 FREQUENCIES //////////////
Model MyModel = (GY94, F61, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn1 = (filt_data, Tree01);
Optimize (paramValues, LikFn1);
fprintf ("f61_hyout.txt", LikFn1);



////////////// F1x4 FREQUENCIES //////////////
global w; global k; global t;
Model MyModel = (GY94, F1x4, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn2 = (filt_data, Tree01);
Optimize (paramValues, LikFn2);
fprintf ("f1x4_hyout.txt", LikFn2);



////////////// F3x4 FREQUENCIES //////////////
global w; global k; global t;
Model MyModel = (GY94, F3x4, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn3 = (filt_data, Tree01);
Optimize (paramValues, LikFn3);
fprintf ("f3x4_hyout.txt", LikFn3);


////////////// CF3x4 FREQUENCIES //////////////
global w; global k; global t;
Model MyModel = (GY94, CF3x4_, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn4 = (filt_data, Tree01);
Optimize (paramValues, LikFn4);
fprintf ("cf3x4_hyout.txt", LikFn4);

////////////// Fnuc_f1x4 //////////////
global w; global k; global t;
Model MyModel = (Fnuc1, F1x4, 0);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn5 = (filt_data, Tree01);
Optimize (paramValues, LikFn5);
fprintf ("fnuc1_hyout.txt", LikFn5);


////////////// Fnuc_f3x4 //////////////
global w; global k; global t;
Model MyModel = (Fnuc3, F3x4, 0);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn6 = (filt_data, Tree01);
Optimize (paramValues, LikFn6);
fprintf ("fnuc3_hyout.txt", LikFn6);


////////////// CNF F61 //////////////
global w; global k; global t;
Model MyModel = (CNF61, F61, 0);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn7 = (filt_data, Tree01);
Optimize (paramValues, LikFn7);
fprintf ("cnf61_hyout.txt", LikFn7);

////////////// CNF F1x4 //////////////
global w; global k; global t;
Model MyModel = (CNF1x4, F1x4, 0);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn8 = (filt_data, Tree01);
Optimize (paramValues, LikFn8);
fprintf ("cnf61_hyout.txt", LikFn8);