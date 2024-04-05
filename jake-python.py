import os, sys
import ROOT as RT
# from matplotlib import pyplot as plt
import numpy as np
import math
from argparse import ArgumentParser as ap

from utils import read_header, provide_list#, provide_get_valid_handle # no need to call it here
# plt.ion()

parser = ap()
parser.add_argument('-i', type=str, required=True)
parser.add_argument('--tag', type=str, default='generator')

args = parser.parse_args()

read_header('gallery/ValidHandle.h')
beamv = 'std::vector<beam::ProtoDUNEBeamEvent>'
marleydata = 'std::vector<simb::MCTruth>'
classes = [marleydata]
provide_list(classes)

ev = RT.gallery.Event(RT.vector(RT.string)(1, args.i))

get_beams = ev.getValidHandle[marleydata]

prev_val = -1
while True:
    val = input('N Events in file: %i. Request an event or [q/Q] to quit'%ev.numberOfEventsInFile())
    if val in ['q', 'Q']:
        break
    elif val.lower() == 'all':
        vals = [i for i in range(ev.numberOfEventsInFile())]
    elif int(val) >= ev.numberOfEventsInFile():
        print('Try again')
        continue
    elif val is not prev_val:
        vals = [int(val)]
    else:
        print('Same event')

    for val in vals:
        ev.goToEntry(int(val))
        beams = get_beams(RT.art.InputTag(args.tag))
        beam = beams.product()[0]

        #print("pressure 0:", beam.GetCKov0Pressure())
        #print("pressure 1:", beam.GetCKov1Pressure())
        #print(beam.GetTOF())
        #print(beam.GetNBeamTracks())
        #print([i for i in beam.GetRecoBeamMomenta()])
        print('Spill start', beam.GetSpillStart())

    next_val = input('Any key to move on. [q/Q] to quit')
    if next_val in ['q', 'Q']:
        break
    else:
        # plt.close()
        continue
