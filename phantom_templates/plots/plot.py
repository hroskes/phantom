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
            if "combined cross section" not in output: continue
            output = output.split("=")[1].split("+/-")[0]
            return float(output)


hstack = ROOT.THStack("m4l", "m_{4l}")
hnames = [
          "gen_H",
          "gen_X",
          "gen_B",
          "gen_H+B+I",
          "gen_X+B+I",
          "gen_X+H+B+I",
         ]
h = OrderedDict((hname, None) for hname in hnames)
finalhnames = [
               "H",
               "X",
               "B",
               "HB_int",
               "XB_int",
               "HX_int",
              ]
matrix = numpy.matrix(
          [
           [ 1,  0,  0,  0,  0,  0],
           [ 0,  1,  0,  0,  0,  0],
           [ 0,  0,  1,  0,  0,  0],
           [ 1,  0,  1,  1,  0,  0],
           [ 0,  1,  1,  0,  1,  0],
           [ 1,  1,  1,  1,  1,  1],
          ]
         )
invertedmatrix = matrix.I
print invertedmatrix
binning = "60,0,600"

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
    print f
    if not f.Get("SelectedTree"):
        print f
        f = ROOT.TFile("../gen_B/phamom.root")
    print
    f.ls()
    t = f.Get("SelectedTree")
    t.Draw("GenHMass>>h_{}({})".format(dir, binning), "GenHMass!=0 && GenHMass<600")
    h[dir] = getattr(ROOT.gDirectory, "h_{}".format(dir))
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


hnew = [None]*6

color = 1
hstack = ROOT.THStack("m4l", "m_{4l}")
legend = ROOT.TLegend(.6, .7, .9, .9)
legend.SetFillStyle(0)
legend.SetBorderSize(0)

for i in range(6):
    hnew[i] = ROOT.TH1F(finalhnames[i], finalhnames[i].replace("_", " "), *(int(a) for a in binning.split(",")))
    for j, (dir, hold) in enumerate(h.iteritems()):
        if j >= 6: continue
        hnew[i].Add(hold, invertedmatrix[i,j])
    hnew[i].SetLineColor(color)
    color += 1
    if color == 5: color += 1
    if color == 7: color = ROOT.kViolet
    hstack.Add(hnew[i])
    legend.AddEntry(hnew[i], hnew[i].GetTitle(), "l")

h["gen_X+H+B+I"].SetLineWidth(3)
#hstack.Add(h["gen_X+H+B+I"])
#legend.AddEntry(h["gen_X+H+B+I"], "X+H+B+I", "l")


hstack.Draw("hist nostack")
legend.Draw()
for ext in "png", "eps", "root", "pdf":
    c1.SaveAs("test_final.{}".format(ext))
