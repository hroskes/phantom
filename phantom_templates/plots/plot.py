from collections import OrderedDict
import contextlib
import numpy
import os
import ROOT
import subprocess
import style

@contextlib.contextmanager
def cd(path):
   """http://stackoverflow.com/questions/24469538/sh-cd-using-context-manager"""
   old_path = os.getcwd()
   os.chdir(path)
   try:
       yield
   finally:
       os.chdir(old_path)

def getxsec(dir):
    if dir.startswith("gen_"):
        dir = dir.replace("gen_", "")
    elif dir.startswith("grid_"):
        dir = dir.replace("grid_", "")
    with cd(".."):
        output = subprocess.check_output(["./submit_width.py", "-s", "3", "-f", dir])
        for xsec in output.split("--->"):
            if "combined cross section" not in xsec: continue
            xsec = xsec.split("=")[1].split("+/-")[0]
            xsec = float(xsec)

            if "times1e6" in dir:
                xsec /= 1e6**8

            return xsec


hstack = ROOT.THStack("m4l", "m_{4l}")
hnames = [
          "gen_H",
          "gen_X",
          "gen_B",
          "gen_H+B+I",
          "gen_X+B+I",
          "gen_X+H+B+I",
          "gen_X+H_times1e6_2e2mu",
         ]
h = OrderedDict((hname, None) for hname in hnames)
finalhnames = [
               "M=450 #Gamma=47",            #X
               "SM bkg",                     #HB
               "BSI",                        #XHB
               "H",                          #H
               "XH",                         #XH
               "ZZ",                       #B
               "X+ZZ",                     #XB
               "X-H interference",           #XH - X - H
               "X-ZZ interference",        #XB - X - B
#               "X-ZZ + X-H interference",  #XB - X - B + XH - X - H
               "X-(ZZ+H) interference",    #XHB - X - HB
              ]
matrix = numpy.matrix(
          [
           [ 0,  1,  0,  0,  0,  0,  0],
           [ 0,  0,  0,  1,  0,  0,  0],
           [ 0,  0,  0,  0,  0,  1,  0],
           [ 1,  0,  0,  0,  0,  0,  0],
           [ 1,  1,  1, -1, -1,  1,  0],
           [ 0,  0,  1,  0,  0,  0,  0],
           [ 0,  0,  0,  0,  1,  0,  0],
           [ 0,  0,  1, -1, -1,  1,  0],
           [ 0, -1, -1,  0,  1,  0,  0],
#           [-1, -2, -1,  0,  1,  0,  1],
           [ 0, -1,  0, -1,  0,  1,  0],
          ]
         )
finalcolors = [
               1,
               6,
               4,
               8,
               93,
               38,
               2,
               93,
               1,
#               4,
               2,
              ]
finalstyles = [
               1,
               1,
               1,
               1,
               1,
               1,
               1,
               2,
               2,
#               2,
               2,
              ]
binning = "200,71,1071"

c1 = ROOT.TCanvas()
color = 1
hstack = ROOT.THStack("m4l", "m_{4l}")
legend = ROOT.TLegend(.6, .7, .9, .9)
legend.SetFillStyle(0)
legend.SetBorderSize(0)

for dir in os.listdir(".."):
    if not os.path.isdir(os.path.join("..", dir)) or not dir.startswith("gen_") or "forCMS" in dir or "_4e" in dir:
        continue
    if dir not in h: continue
    print dir
    f = ROOT.TFile(os.path.join("..", dir, "phamom.root"))
    assert f
    f.ls()
    t = f.Get("SelectedTree")
    assert t
    t.Draw("GenHMass>>h_{}({})".format(dir, binning), "GenHMass!=0")
    h[dir] = getattr(ROOT.gDirectory, "h_{}".format(dir))
    assert h[dir]
    h[dir].SetDirectory(0)
    h[dir].SetLineColor(color)
    color += 1
    if color == 5: color += 1
    if color == 7: color = ROOT.kViolet
    hstack.Add(h[dir])
    legend.AddEntry(h[dir], dir.replace("gen_", ""), "l")

    print dir, getxsec(dir), h[dir].Integral(), t.GetEntries()
    h[dir].Scale(getxsec(dir) / t.GetEntries())

hstack.Draw("hist nostack")
legend.Draw()
for ext in "png", "eps", "root", "pdf":
    c1.SaveAs("test.{}".format(ext))


hnew = [None]*len(finalhnames)

color = 1
hstack = ROOT.THStack("m4l", "m_{4l}")
legend = [ROOT.TLegend(0.25,0.72,0.5,0.92), ROOT.TLegend(0.6,0.32,0.9,0.52)]
for l in legend:
    l.SetFillStyle(0)
    l.SetBorderSize(0)

for i in range(len(finalhnames)):
    hnew[i] = ROOT.TH1F(finalhnames[i], finalhnames[i].replace("_", " "), *(int(a) for a in binning.split(",")))
    for j, (dir, hold) in enumerate(h.iteritems()):
        if j >= len(hnames): continue
        print dir
        assert hold
        hnew[i].Add(hold, matrix[i,j])
    hnew[i].SetLineColor(finalcolors[i])
    hnew[i].SetLineStyle(finalstyles[i])
    hnew[i].SetLineWidth(2)
    color += 1
    if color == 5: color += 1
    if color == 7: color = ROOT.kViolet
    hstack.Add(hnew[i])
    legend[finalstyles[i]-1].AddEntry(hnew[i], hnew[i].GetTitle(), "l")

h["gen_X+H+B+I"].SetLineWidth(3)
#hstack.Add(h["gen_X+H+B+I"])
#legend.AddEntry(h["gen_X+H+B+I"], "X+H+B+I", "l")

hstack.SetMinimum(-4e-6)
hstack.Draw("hist nostack")
hstack.GetXaxis().SetRange(16, 186)
for l in legend:
    l.Draw()
for ext in "png", "eps", "root", "pdf":
    c1.SaveAs("test_final.{}".format(ext))

hstack.SetMaximum(0.025e-3)
for ext in "png", "eps", "root", "pdf":
    c1.SaveAs("test_final_zoomint.{}".format(ext))

command = "rsync -az *.{png,eps,root,pdf} hroskes@lxplus.cern.ch:www/VBF/phantom/"
print command
subprocess.call(command, shell=True)
