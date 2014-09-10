/* SJS 9/9/14 - 9/10/14.
Hyphy inference for an "experimental" dataset. Name of file indicates the mutation scheme.
Perform 7 inferences for each of the following parameterizations: Fequal, F61_true, F61_data, F3x4_true, F61_data, Fnuc_true, Fnuc_data. The _data refers to empirical frequencies, whereas _true refers to frequencies in absence of selection. 
Also note that Fnuc is not so much a frequency parameterization, but actually a "new" model.
*/


global w;
global k;
global t;

LIKELIHOOD_FUNCTION_OUTPUT = 1;
RANDOM_STARTING_PERTURBATIONS = 1;
#include "GY94.mdl"; // Basic GY94 rate matrix
#include "fnuc.mdl"; // Custom Fnuc matrices for this run

/* Read in the data */
DataSet	raw_data = ReadDataFile("temp.fasta");

/* Filter the data to find and remove any stop codons*/
DataSetFilter   filt_data = CreateFilter(raw_data,3,"", "","TAA,TAG,TGA");


/* Set up frequencies. MANY OF THESE WERE HARD-CODED IN WHEN THIS FILE WAS CREATED!!!*/

Fequal = {{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623},{0.016393442623}};

F61_true = {{0.0576983443548},{0.0178623287322},{0.0105319728082},{0.0678586010545},{0.0178623287322},{0.00552222202079},{0.00326287789486},{0.0209803898195},{0.0105319728082},{0.00326287789486},{0.0019163408744},{0.0123956892731},{0.0678586010545},{0.0209803898195},{0.0123956892731},{0.0797101896698},{0.016656776867},{0.00550938458351},{0.00301284076274},{0.0208985183277},{0.00550938458351},{0.00170636736722},{0.00100748665802},{0.00648261784471},{0.00301284076274},{0.00100748665802},{0.000495744452809},{0.00382119128245},{0.0208985183277},{0.00648261784471},{0.00382119128245},{0.0246286196663},{0.0110330778178},{0.00326881252872},{0.00201073890535},{0.0124138336682},{0.00326881252872},{0.00100886478209},{0.000596992336277},{0.00383288097333},{0.00201073890535},{0.000596992336277},{0.000358822780659},{0.00226728989147},{0.0124138336682},{0.00383288097333},{0.00226728989147},{0.0145619520645},{0.0210106323647},{0.0794524195248},{0.0210106323647},{0.00648393807125},{0.00385127114388},{0.0246314283336},{0.00385127114388},{0.00162336534621},{0.0145496436533},{0.0794524195248},{0.0246314283336},{0.0145496436533},{0.0935756891342}};

F61_data = {{0.064733389149},{0.0189087927842},{0.0115632355352},{0.0720346808208},{0.0207617881406},{0.00656579480405},{0.00378655454002},{0.024940714433},{0.0183282358288},{0.00405567903695},{0.00328878996608},{0.0154654001066},{0.0608007675151},{0.0192542602696},{0.0132514010227},{0.0731046467845},{0.0191347680316},{0.00480231559218},{0.0034017780326},{0.0182508480802},{0.00493633324659},{0.00154560263115},{0.000894215786054},{0.00587706951851},{0.00512041822435},{0.0017083213866},{0.000887389890897},{0.00649153378304},{0.0213374201395},{0.00663029994479},{0.00386848498876},{0.0252850872804},{0.0124122552578},{0.00300126013449},{0.00220656490876},{0.0114319414507},{0.00510089124266},{0.00162307513157},{0.000932107751921},{0.00616737701312},{0.00292513578661},{0.000880222075102},{0.000507525132551},{0.00334915414632},{0.0125533738666},{0.00397240978366},{0.00229534552166},{0.015092184512},{0.0153368199285},{0.0580263918681},{0.0287298549736},{0.00881210127899},{0.00520928043386},{0.033507110926},{0.00341326527498},{0.00114878555926},{0.0129029488686},{0.0812743827376},{0.0190352784228},{0.0146973634242},{0.0724395752933}};

F3x4_true = {{0.0472422131321},{0.0182269186026},{0.00885416106978},{0.0691748531734},{0.0182269186026},{0.0070322819301},{0.00341609891692},{0.0266889363251},{0.00885416106978},{0.00341609891692},{0.00165945164403},{0.0129647882978},{0.0691748531734},{0.0266889363251},{0.0129647882978},{0.101289926833},{0.0143754177374},{0.00554630174176},{0.00269424854709},{0.0210493401},{0.00554630174176},{0.00213986567712},{0.00103949086436},{0.00812122428661},{0.00269424854709},{0.00103949086436},{0.000504957516094},{0.00394507867649},{0.0210493401},{0.00812122428661},{0.00394507867649},{0.0308216934448},{0.00871416675686},{0.00336208652467},{0.00163321383438},{0.0127598003135},{0.00336208652467},{0.00129715509409},{0.000630124070114},{0.00492296669189},{0.00163321383438},{0.000630124070114},{0.000306097817868},{0.00239144865797},{0.0127598003135},{0.00492296669189},{0.00239144865797},{0.0186836571509},{0.0172522984657},{0.0654759720654},{0.0172522984657},{0.00665625547564},{0.00323343508509},{0.0252618396587},{0.00323343508509},{0.00157071832471},{0.0122715420052},{0.0654759720654},{0.0252618396587},{0.0122715420052},{0.0958738055168}};

F3x4_data = {{0.0516306288865},{0.0172336346698},{0.009794035423},{0.0655013296892},{0.0261047700568},{0.0087134338667},{0.00495192578823},{0.0331178834508},{0.0131797839329},{0.00439924103627},{0.00250012973868},{0.0167205666721},{0.0728641699367},{0.0243211154365},{0.0138219168896},{0.0924393159736},{0.0155992756703},{0.005206836016},{0.00295909350288},{0.019790061067},{0.00788709169746},{0.00263260897364},{0.00149613624965},{0.0100059791001},{0.00398203716045},{0.00132915238774},{0.000755369706824},{0.00505182165134},{0.0220146122145},{0.00734819219686},{0.00417604620557},{0.0279288942192},{0.0101202472712},{0.0033780073573},{0.00191975310783},{0.0128390776434},{0.00511686054637},{0.00170794172402},{0.000970639221844},{0.00649151824895},{0.00258340204756},{0.000862306116602},{0.0004900566139},{0.00327743963005},{0.0142822861715},{0.00476724199255},{0.00270926811666},{0.0181192589634},{0.0141812189246},{0.0538997555636},{0.0214811017086},{0.00717011330553},{0.00407484230963},{0.0272520547483},{0.00362004890046},{0.00205730757576},{0.0137590253631},{0.0599584919507},{0.0200133674123},{0.0113737834836},{0.0760664945137}};

CF3x4_true = {{0.0575598420157},{0.0178879458303},{0.0104033620304},{0.0678884500778},{0.0178879369448},{0.00555905707659},{0.00323306453766},{0.0210977701075},{0.0104033227592},{0.00323305393927},{0.00188029586589},{0.0122701076488},{0.0678884251709},{0.0210977728471},{0.0122701494652},{0.0800704067572},{0.0175149741518},{0.00544315095169},{0.00316565526717},{0.0206578824173},{0.0054431482479},{0.00169157415301},{0.000983794253512},{0.00641987339008},{0.00316564331728},{0.000983791028511},{0.000572158163322},{0.00373369020454},{0.0206578748383},{0.00641987422371},{0.00373370292892},{0.0243647490258},{0.0106173092787},{0.00329955480402},{0.00191897177524},{0.0125224921697},{0.00329955316502},{0.00102540636342},{0.000596361020327},{0.00389162899825},{0.0019189645314},{0.000596359065381},{0.000346833522201},{0.00226330586097},{0.0125224875754},{0.00389162950358},{0.0022633135743},{0.0147695379772},{0.020924826624},{0.0794140401097},{0.0209248162299},{0.0065028319419},{0.00378194989835},{0.0246795907054},{0.00378193750064},{0.00219951834429},{0.0143532341637},{0.0794140109743},{0.0246795939101},{0.0143532830793},{0.0936641576958}};

CF3x4_data = {{0.0619398474557},{0.0169027863674},{0.0112535515219},{0.0642438703822},{0.0252475621825},{0.00688981596501},{0.00458710754861},{0.0261867146748},{0.0152477990789},{0.00416097715755},{0.00277029892031},{0.0158149828887},{0.0704714578535},{0.0192309804759},{0.0128036185809},{0.0730928374861},{0.0187140259328},{0.00510687700099},{0.00340006092471},{0.0194101455806},{0.00762810295523},{0.00208163565035},{0.00138591315845},{0.00791185121773},{0.0046068519556},{0.00125716542146},{0.000836996666375},{0.0047782164804},{0.0212917006413},{0.00581029954257},{0.0038683861843},{0.022083703987},{0.012140978528},{0.00331315582423},{0.00220583571002},{0.0125925956053},{0.0049488354094},{0.0013504894043},{0.000899129987251},{0.00513292094903},{0.00298875778389},{0.000815603144022},{0.000543012956749},{0.0030999328471},{0.0138132800092},{0.0037695107531},{0.00250966808373},{0.0143271029381},{0.0175015878684},{0.0665197866231},{0.0261419873857},{0.00713389596764},{0.00474961134091},{0.0271144104825},{0.00430838476912},{0.00286844008564},{0.0163752476454},{0.0729679938576},{0.0199122610484},{0.0132572021414},{0.0756822390109}};

/* Optimize likelihoods for each frequency specification */


////////////// F61_TRUE FREQUENCIES //////////////
Model MyModel = (GY94, F61_true, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn1 = (filt_data, Tree01);
Optimize (paramValues, LikFn1);
fprintf ("f61_true_hyout.txt", LikFn1);



////////////// F61_DATA FREQUENCIES //////////////
global w;
global k;
global t;
Model MyModel = (GY94, F61_data, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn2 = (filt_data, Tree01);
Optimize (paramValues, LikFn2);
fprintf ("f61_data_hyout.txt", LikFn2);



////////////// F3x4_TRUE FREQUENCIES //////////////
global w;
global k;
global t;
Model MyModel = (GY94, F3x4_true, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn3 = (filt_data, Tree01);
Optimize (paramValues, LikFn3);
fprintf ("f3x4_true_hyout.txt", LikFn3);


////////////// F3x4_DATA FREQUENCIES //////////////
global w;
global k;
global t;
Model MyModel = (GY94, F3x4_data, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn4 = (filt_data, Tree01);
Optimize (paramValues, LikFn4);
fprintf ("f3x4_data_hyout.txt", LikFn4);

////////////// CF3x4_TRUE FREQUENCIES //////////////
global w;
global k;
global t;
Model MyModel = (GY94, CF3x4_true, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn5 = (filt_data, Tree01);
Optimize (paramValues, LikFn5);
fprintf ("cf3x4_true_hyout.txt", LikFn5);


////////////// CF3x4_DATA FREQUENCIES //////////////
global w;
global k;
global t;
Model MyModel = (GY94, CF3x4_data, 1);
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn6 = (filt_data, Tree01);
Optimize (paramValues, LikFn6);
fprintf ("cf3x4_data_hyout.txt", LikFn6);


Fones =  {{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1}};
////////////// Fnuc_TRUE MODEL //////////////
global w;
global k;
global t;
Model MyModel = (GY94_Fnuc_true, Fones, 0); // Using 0 as last argument means that the matrix will *not* be multipled by frequencies, but just in case it is, we provide Fones (all entries are 1, so multiplication is basically..not)
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn7 = (filt_data, Tree01);
Optimize (paramValues, LikFn7);
fprintf ("fnuc_true_hyout.txt", LikFn7);


////////////// Fnuc_DATA MODEL //////////////
global w;
global k;
global t;
Model MyModel = (GY94_Fnuc_data, Fones, 0); // Using 0 as last argument means that the matrix will *not* be multipled by frequencies, but just in case it is, we provide Fones (all entries are 1, so multiplication is basically..not)
UseModel (USE_NO_MODEL);
UseModel(MyModel);
Tree    Tree01 = DATAFILE_TREE;
LikelihoodFunction  LikFn8 = (filt_data, Tree01);
Optimize (paramValues, LikFn8);
fprintf ("fnuc_data_hyout.txt", LikFn8);
