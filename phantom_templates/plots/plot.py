import os
import ROOT
import style

hstack = ROOT.THStack("m4l", "m_{4l}")
keep = []
color = 1

for dir in os.listdir(".."):
    if not os.path.isdir(os.path.join("..", dir)) or not dir.startswith("gen_"):
        continue
    print dir
    f = ROOT.TFile(os.path.join("..", dir, "phamom.root"))
    f.ls()
    t = f.Get("SelectedTree")
    t.Draw("GenHMass>>h_{}".format(dir), "GenHMass!=0 && GenHMass<600")
    h = getattr(ROOT.gDirectory, "h_{}".format(dir))
    keep.append(h)
    h.SetLineColor(color)
    color += 1
    hstack.Add(h)

c1 = ROOT.TCanvas()
hstack.Draw()
for ext in "png", "eps", "root", "pdf":
    c1.SaveAs("test.{}".format(ext))
