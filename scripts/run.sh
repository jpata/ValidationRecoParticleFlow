#!/bin/bash
#https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideCmsDriver
#https://twiki.cern.ch/twiki/bin/view/CMSPublic/WorkBookDataFormats

N=1000
INPUT_FILE=root://cms-xrd-global.cern.ch///store/relval/CMSSW_9_4_11_cand2/RelValTTbar_13/GEN-SIM/94X_mc2017_realistic_v15-v1/10000/8E5D8B31-CCD2-E811-AC34-0025905A6138.root
CONDITIONS=auto:phase1_2017_realistic
ERA=Run2_2017,run2_nanoAOD_94XMiniAODv1

#In case you want to generate your own events
#cmsDriver.py TTbarLepton_13TeV_TuneCUETP8M1_cfi  --conditions $CONDITIONS -n $N --era $ERA --eventcontent FEVTDEBUG --relval 9000,100 -s GEN,SIM --datatier GEN-SIM --beamspot Realistic50ns13TeVCollision --fileout file:step1.root  > step1.log  2>&1
#INPUT_FILE=step1.root


#DIGI: simulate detector response to MC particles
#L1: simulate L1 trigger
#DIGI2RAW: Convert detector response to RAW (DAQ output) used in online data taking
#HLT: run HLT
cmsDriver.py step2  --conditions $CONDITIONS  -s DIGI:pdigi_valid,L1,DIGI2RAW,HLT:@relval2017 --datatier GEN-SIM-DIGI-RAW-HLTDEBUG -n $N --era $ERA --eventcontent FEVTDEBUGHLT --filein file:$INPUT_FILE --fileout file:step2.root  > step2.log  2>&1

cmsDriver.py step3  --runUnscheduled  --conditions $CONDITIONS -s RAW2DIGI,L1Reco,RECO,RECOSIM,EI,PAT --datatier RECOSIM,AODSIM,MINIAODSIM -n $N --era $ERA --eventcontent RECOSIM,AODSIM,MINIAODSIM --filein file:step2.root --fileout file:step3.root > step3.log  2>&1

#NanoAOD
cmsDriver.py step4 --conditions $CONDITIONS -s NANO --datatier NANOAODSIM -n $N --era $ERA --eventcontent NANOAODSIM --filein file:step3_inMINIAODSIM.root --fileout file:step4.root > step4.log 2>&1
