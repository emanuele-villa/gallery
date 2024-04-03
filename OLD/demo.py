import os, sys
import ROOT

print ("Starting demo...")

if (len(sys.argv) < 2):
	print ("Please specify an art/ROOT file to read")
	sys.exit(1)

# Some functions that I find useful to reduce error-prone typing.
def read_header(h):
        """Make the ROOT C++ jit compiler read the specified header."""
        ROOT.gROOT.ProcessLine('#include "%s"' % h)

def provide_get_valid_handle(klass):
        """Make the ROOT C++ jit compiler instantiate the
           Event::getValidHandle member template for template
           parameter klass."""
        # this does not work, dropping the python approach as I don't know how to solve it
        process = ROOT.gROOT.ProcessLine('template gallery::ValidHandle<%(name)s> gallery::Event::getValidHandle<%(name)s>(art::InputTag const&) const;' % {'name' : klass})
        print ("Process: ", process)
        # check that it worked
        # ROOT.gROOT.ProcessLine('gallery::ValidHandle<%(name)s> (gallery::Event::*dummy)(art::InputTag const&) const = &gallery::Event::getValidHandle<%(name)s>;' % {'name' : klass})
        


# Now for the script...

print ("Reading headers...")
read_header('gallery/ValidHandle.h')

print ("Instantiating member templates...")
provide_get_valid_handle('std::vector<simb::MCTruth>')

print ("Preparing before event loop...")
mctruths_tag = ROOT.art.InputTag("generator")
filenames = ROOT.vector(ROOT.string)(1, sys.argv[1])

# Make histograms before we open the art/ROOT file, or the file ends
# up owning the histograms.
histfile = ROOT.TFile("hist.root", "RECREATE")
npart_hist = ROOT.TH1F("npart", "Number of particles per MCTruth", 51, -0.5, 50.5)

print ("Creating event object ...")
ev = ROOT.gallery.Event(filenames)

# Capture the functions that will get ValidHandles. This avoids some
# inefficiency in constructing the function objects many times.
print ("Capturing getValidHandle functions...")
get_mctruths = ev.getValidHandle(ROOT.vector(ROOT.simb.MCTruth))

print ("Entering event loop...")
while (not ev.atEnd()) :
        mctruths = get_mctruths(mctruths_tag)
        if (not mctruths.empty()):
                npart_hist.Fill(mctruths.product()[0].NParticles())

        # The Assns<> involved in demo.cc appears to be inaccessible
        # from PyROOT at this time, because of PyROOT's incomplete
        # object model.
        ev.next()

print ("Writing histograms...")
histfile.Write()
