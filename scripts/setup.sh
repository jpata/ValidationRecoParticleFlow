export SCRAM_ARCH=slc6_amd64_gcc630
cmsrel CMSSW_9_4_11
cd CMSSW_9_4_11
eval `scramv1 runtime -sh`
git cms-addpkg Validation/RecoTrack
git cms-addpkg Configuration/PyReleaseValidation
git cms-addpkg RecoParticleFlow/PFProducer
