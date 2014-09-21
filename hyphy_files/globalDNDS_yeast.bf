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

F61 = {{0.043290480867},{0.0188472313944},{0.0193545856332},{0.0420950331717},{0.0211606018004},{0.0101401150859},{0.0101019121973},{0.0214678453666},{0.0273822028831},{0.0106683058196},{0.012250248782},{0.0239101248661},{0.0377141651232},{0.0183903315529},{0.020684945186},{0.0394423155306},{0.0217845918205},{0.00774771537914},{0.00977427199326},{0.0170464058066},{0.00726263656558},{0.0034510319783},{0.00345813818133},{0.00726019611744},{0.0149794076361},{0.00690924671313},{0.00697640963953},{0.0144660098607},{0.0200427088827},{0.00962866611965},{0.00945871585698},{0.0202951867294},{0.0194304451535},{0.00750138713285},{0.00873151982915},{0.0167730955518},{0.0130008082228},{0.00622743019523},{0.00622058756301},{0.0131146195545},{0.0125594406824},{0.00603500577388},{0.00607281205363},{0.0127906523446},{0.0192647962792},{0.00914754678407},{0.00918270275692},{0.0192518095131},{0.0133533353384},{0.0312176902037},{0.0222307097398},{0.0107391095205},{0.0106832235699},{0.0228261705635},{0.00765284954925},{0.00718355907153},{0.0174058347007},{0.04505341036},{0.0151772893843},{0.0202383995281},{0.0334919745395}};

F1x4 = {{0.0374058645467},{0.0203076994119},{0.0203617916419},{0.0365488136751},{0.0203076994119},{0.0110250801686},{0.0110544469206},{0.0198424052209},{0.0203617916419},{0.0110544469206},{0.0110838918948},{0.0198952580786},{0.0365488136751},{0.0198424052209},{0.0198952580786},{0.0357113997295},{0.0203076994119},{0.0110250801686},{0.0110544469206},{0.0198424052209},{0.0110250801686},{0.00598553239632},{0.00600147564959},{0.0107724712614},{0.0110544469206},{0.00600147564959},{0.00601746136982},{0.0108011651563},{0.0198424052209},{0.0107724712614},{0.0108011651563},{0.0193877719463},{0.0203617916419},{0.0110544469206},{0.0110838918948},{0.0198952580786},{0.0110544469206},{0.00600147564959},{0.00601746136982},{0.0108011651563},{0.0110838918948},{0.00601746136982},{0.00603348967011},{0.0108299354812},{0.0198952580786},{0.0108011651563},{0.0108299354812},{0.0194394138284},{0.0198424052209},{0.0357113997295},{0.0198424052209},{0.0107724712614},{0.0108011651563},{0.0193877719463},{0.0108011651563},{0.0108299354812},{0.0194394138284},{0.0357113997295},{0.0193877719463},{0.0194394138284},{0.0348931727847}};

F3x4 = {{0.035736292775},{0.0177624612237},{0.0176256772949},{0.03878050096},{0.0244323785406},{0.0121439338759},{0.0120504167127},{0.0265136589689},{0.0241610120584},{0.0120090531638},{0.0119165746806},{0.0262191760411},{0.0447065254672},{0.022221049342},{0.0220499310274},{0.0485148659575},{0.0171182556021},{0.00850850291785},{0.00844298122905},{0.0185764799945},{0.0117034999534},{0.00581713848752},{0.00577234227115},{0.0127004665547},{0.0115735110697},{0.0057525284699},{0.00570822979787},{0.012559404524},{0.0214151404805},{0.0106442379118},{0.0105622695032},{0.0232393964643},{0.0175698958275},{0.00873298736678},{0.00866573698371},{0.0190665933452},{0.0120122797426},{0.00597061520843},{0.00592463710918},{0.0130355498547},{0.0118788612917},{0.00590430054966},{0.00585883312173},{0.0128907661079},{0.021980147751},{0.0109250706159},{0.0108409395903},{0.0238525340702},{0.0121237753147},{0.0264696471006},{0.0166763301605},{0.00828884713066},{0.00822501695191},{0.0180969089847},{0.00819678424437},{0.0081336630171},{0.0178959095395},{0.030514457599},{0.015166986494},{0.0150501896169},{0.0331138419886}};

pos_freqs = {{0.37690044526,0.276947789275,0.325156406016},{0.18054133928,0.189345136222,0.161616597722},{0.185304659391,0.187242110376,0.160372031842},{0.257253556069,0.346464964126,0.352854964421}};
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