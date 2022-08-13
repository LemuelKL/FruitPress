import subprocess
import json

def main():
    with open('seeds.json') as f:
        seeds = json.load(f)
    
    fruits = ""
    for seed in seeds:
        fid = seed['id']
        qn = seed['gene']['qn']
        sol = seed['gene']['sol']
        fruits += "<h2>{}</h2>\n".format(fid) + qn + "\n" + sol + "\n"

    intermediate_tex = subprocess.run(["pandoc", '-f', "html", "-t", "latex", "--filter", "Filter.hs", "--include-in-header", "header.tex", "-o", "-"], input=fruits.encode(), capture_output=True).stdout.decode()
    subprocess.run(["pandoc", "-f", "latex", "-t", "docx", "-o", "checkout.docx"], input=intermediate_tex.encode())

    # print(intermediate_tex)

main()
