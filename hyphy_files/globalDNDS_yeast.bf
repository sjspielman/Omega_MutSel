/* SJS 9/9/14.
Hyphy inference for an "experimental" dataset. Name of file indicates the mutation scheme.
Run across 5 sets of equilibrium freqs: Fequal, Ftrue, F61, F3x4, Fnuc. 
Note the following: 
 - Ftrue refers to codon frequencies which would exist in the absence of natural selection. 
 - Fnuc is not so much a frequency parameterization, but actually a new model.
*/


global w;
global k;
global t;

LIKELIHOOD_FUNCTION_OUTPUT = 1;
RANDOM_STARTING_PERTURBATIONS = 1;
#include "matrices.mdl"; // Basic GY94 rate matrix
#include "fnuc.mdl";     // Custom Fnuc matrix for this run

/* Read in the data */
DataSet	raw_data = ReadDataFile("temp.fasta");

/* Filter the data to find and remove any stop codons*/
DataSetFilter   filt_data = CreateFilter(raw_data,3,"", "","TAA,TAG,TGA");


/* Set up frequencies. MANY OF THESE WERE HARD-CODED IN WHEN THIS FILE WAS CREATED!!!*/

Fequal = {{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623}};

Ftrue = {{0.0415420976134},{0.019859659982},{0.0199226668741},{0.0418410026486},{0.019859659982},{0.00952086207663},{0.00952773729476},{0.0199841786885},{0.0199226668741},{0.00952773729476},{0.00960027733595},{0.0200172808268},{0.0418410026486},{0.0199841786885},{0.0200172808268},{0.0418563181783},{0.0212103555792},{0.00960702697888},{0.0100649760394},{0.0202818863501},{0.00960702697888},{0.00456888973382},{0.00459672580976},{0.00960216068013},{0.0100649760394},{0.00459672580976},{0.00472709614948},{0.00965950242228},{0.0202818863501},{0.00960216068013},{0.00965950242228},{0.0201068649502},{0.0189747676791},{0.00936938936388},{0.00917571428658},{0.0199620548488},{0.00936938936388},{0.00452903599734},{0.00451834486019},{0.0095442790625},{0.00917571428658},{0.00451834486019},{0.0045759964321},{0.00956040435674},{0.0199620548488},{0.0095442790625},{0.00956040435674},{0.0200222354502},{0.0189970705278},{0.0428338830373},{0.0189970705278},{0.00937204102203},{0.00925761483226},{0.0200028931788},{0.00925761483226},{0.0105071511614},{0.0202173800273},{0.0428338830373},{0.0200028931788},{0.0202173800273},{0.0420783446859}};

F61 = {{0.0425878663474},{0.0199078643132},{0.0206080077075},{0.0410957486733},{0.0211288327264},{0.0101737510099},{0.0102015024614},{0.0211244049354},{0.0281069065528},{0.0113126700256},{0.0135933116374},{0.0233415011914},{0.038607136559},{0.0183427368963},{0.0208081941436},{0.0378467556072},{0.0212454327197},{0.00799840204442},{0.0102324620869},{0.0165134584925},{0.00727186274848},{0.00347178512148},{0.00349349462},{0.00721584392773},{0.0144718989509},{0.00684780307396},{0.00682240822034},{0.0139887873167},{0.0205386820914},{0.00972918740468},{0.0097893064169},{0.0198883449017},{0.0190032600421},{0.00794583686669},{0.00925901840985},{0.0165008466301},{0.0130669480887},{0.00632403196468},{0.00631782177592},{0.0132104311994},{0.012572795276},{0.00617384774217},{0.00622587915583},{0.0128712793025},{0.0193448210618},{0.00925162260606},{0.00926846715473},{0.0191727272757},{0.0136570776602},{0.03037549023},{0.0221599938113},{0.010960463496},{0.0108055448481},{0.0230642639634},{0.00804200517678},{0.00718219624967},{0.017182851242},{0.0429633607131},{0.0156993564494},{0.0205206463864},{0.0325707642958}};

F3x4 = {{0.035675220653},{0.0183128322366},{0.0182344100227},{0.0382032745233},{0.0244753227002},{0.0125636918383},{0.0125098895363},{0.0262097179792},{0.0243136702555},{0.0124807122786},{0.0124272653253},{0.0260366103541},{0.0443593922569},{0.0227705980131},{0.0226730860234},{0.0475028327522},{0.0169076088239},{0.00867902701785},{0.00864186026479},{0.0181057330441},{0.0115996250193},{0.00595432860953},{0.00592883000691},{0.0124216094776},{0.0115230128428},{0.00591500198703},{0.00588967179532},{0.0123395683309},{0.0210233108084},{0.0107917023874},{0.0107454883894},{0.0225130861001},{0.0175659909532},{0.00901698824865},{0.00897837422257},{0.0188107701193},{0.0120513143089},{0.00618619010983},{0.00615969859186},{0.0129053068343},{0.0119717188549},{0.00614533210901},{0.00611901555987},{0.0128200710061},{0.0218419583344},{0.0112119311773},{0.0111639176066},{0.023389745462},{0.0123371174133},{0.0257370502431},{0.0164887072616},{0.00846399613946},{0.00842775022689},{0.0176571468521},{0.00840809388701},{0.00837208736824},{0.0175405264916},{0.0298843468659},{0.0153402563639},{0.015274563802},{0.0320020419319}};



/* Optimize likelihoods for each frequency specification */

////////////// FEQUAL FREQUENCIES //////////////
Model MyModel = (GY94, Fequal, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn = (filt_data, Tree01);
Optimize (paramValues, LikFn);
fprintf ("fequal_hyout.txt", LikFn);


////////////// TRUE FREQUENCIES //////////////
Model MyModel = (GY94, Ftrue, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn1 = (filt_data, Tree01);
Optimize (paramValues, LikFn2);
fprintf ("ftrue_hyout.txt", LikFn2);



////////////// F61 FREQUENCIES, GLOBAL //////////////
global w;
global k;
global t;
Model MyModel = (GY94, F61, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn3 = (filt_data, Tree01);
Optimize (paramValues, LikFn3);
fprintf ("f61_hyout.txt", LikFn3);



////////////// F3x4 FREQUENCIES //////////////
global w;
global k;
global t;
Model MyModel = (GY94, F3x4, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn4 = (filt_data, Tree01);
Optimize (paramValues, LikFn4);
fprintf ("f3x4_hyout.txt", LikFn4);



////////////// Fnuc MODEL //////////////
global w;
global k;
global t;
Fones =  {{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1}};
Model MyModel = (GY94_Fnuc, Fones, 0); // Using 0 as last argument means that the matrix will *not* be multipled by frequencies, but just in case it is, we provide Fones (all entries are 1, so multiplication is basically..not)
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn5 = (filt_data, Tree01);
Optimize (paramValues, LikFn5);
fprintf ("fnuc_hyout.txt", LikFn5);

