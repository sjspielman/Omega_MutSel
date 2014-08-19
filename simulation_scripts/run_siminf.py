# SJS. stephanie.spielman@gmail.com
# Generic code for simulating and deriving dN/dS via selection coeffcients and hyphy ML.
# Be sure to cp src/ directory (simulator), hyphy files, and the functions_simandinf.py script into working directory
# NOTE: very little (ok, none) sanity checking for input args..

######## Input parameters ########
import sys
if (len(sys.argv) != 6):
    print "\n\nUsage: python run_siminf.py <rep> <treefile> <simdir> <cpu> <bias>\n."
    sys.exit()
rep = sys.argv[1]         # which rep we're on, for saving files
treefile = sys.argv[2]    # tree for simulation
simdir = sys.argv[3]      # directory of simulation library
cpu = sys.argv[4]         # hyphy can use
bias = float(sys.argv[5]) # codon bias, yes or no?
sys.path.append(simdir)
from functions_simandinf import *


# Set up output files and parameters
seqfile       = "seqs"+str(rep)+".fasta"
freqfile      = "codonFreqs" + str(rep)+".txt"
paramfile     = "params"+str(rep)+".txt"


seqlength = 500000
if bias != 0.:
    bias = rn.uniform(ZERO,1)
mu = 1e-6
kappa = rn.uniform(1.0, 6.0)
sd = rn.uniform(0., 4.)
mu_dict = {'AT': mu, 'TA':mu, 'CG': mu, 'GC':mu, 'AC': mu, 'CA':mu, 'GT':mu, 'TG':mu, 'AG': kappa*mu, 'GA':kappa*mu, 'CT':kappa*mu, 'TC':kappa*mu}


# Derive equilibrium codon frequencies 
print "Deriving equilibrium codon frequencies"
codon_freqs_f61, codon_freqs_dict, gc_content, entropy = set_codon_freqs(sd, freqfile, bias)


# Simulate according to BH98 MutSel model
print "Simulating"
simulate(codon_freqs_f61, seqfile, treefile, mu_dict, seqlength)

# Derive omega from equilibrium codon frequencies
print "Deriving omega from equilibrium codon frequencies"
derivedw = derive_dnds(codon_freqs_dict, mu_dict)


# Maximum likelihood omega inference across a variety of frequency, kappa specifications
print "Conducting ML inference with HyPhy"

# Lists for storing values and printing strings
krun = [kappa]#, 1.0, 'free']
kspecs = ['true']#, 'one', 'free']
fspecs = ['equal', 'f61', 'f3x4', 'cf3x4'] # DO NOT CHANGE THIS LIST !!!!
omegas = np.zeros([1,4])
kappas = np.zeros([1,4])
omega_errors = np.ones([1,4])


# First, set up F61 (data) frequency vector in the hyphy batchfile as this applies to all hyphy runs.
hyf = array_to_hyphy_freq(codon_freqs_f61)
setuphyphyf = "sed -i 's/DATAFREQS/"+hyf+"/g' globalDNDS.bf"
setupf = subprocess.call(setuphyphyf, shell = True)
assert(setupf == 0), "couldn't properly add in F61 frequencies"


# Run hyphy and save omegas, kappas (only sometimes returned, note), and omega errors along the way
kcount = 0
for kap in krun:
    wtemp, ktemp = run_hyphy(seqfile, treefile, cpu, kap, fspecs)  
    kappas[kcount] = ktemp
    omegas[kcount] = wtemp
    omega_errors[kcount] = (derivedw - wtemp) / derivedw
    kcount += 1


# Finally, save results
outstring_params = rep + '\t' + str(seqlength) + '\t' + str(mu) + '\t' + str(kappa) + '\t' + str(sd) + '\t' + str(bias) + '\t' + str(gc_content) + '\t' + str(entropy) + '\t' + str(derivedw)
outf = open(paramfile, 'w')
for f in fspecs:
    y =  fspecs.index(f)
    for k in kspecs:
        x = kspecs.index(k)
        outf.write( outstring_params + '\t' + f + '\t' + k + '\t' + str(omegas[x,y]) + '\t' + str(omega_errors[x,y]) + '\t' + str(kappas[x,y]) + '\n')
outf.close()   
