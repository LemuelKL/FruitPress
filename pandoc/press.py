# Loop through every seed object in seeds.json
# and run the question and solution gene against the pandoc with Filter for every seed.
# append the AST nicely together
# and run the resulting AST against pandoc to produce the final juice

import subprocess
import json
# pandoc -f html -t json --filter Filter.hs -o ast_q1.json

def press(seed):
    id = seed['id']

    qn = seed['gene']['qn']
    sol = seed['gene']['sol']

    _to = 'docx'
    _out_dir = './out/'

    print("## {}".format(id))
    subprocess.run(["pandoc", "--katex", "-f", "html", "-t", _to, "--filter", "Filter.hs", "-o", _out_dir + id + "." + _to], input=qn.encode())

def mass_produce(seeds):
    for seed in seeds:
        press(seed)

def main():
    with open('seeds.json') as f:
        seeds = json.load(f)
    # press(seeds[5])
    mass_produce(seeds)

main()

# [
#     {
#         "id": "DS2022D01",
#         "bank": "HKDSE 2022",
#         "folder": "HKDSE_Replica_Math_MC_2022",
#         "gene": {
#             "qn": "<p><span class=\"math-tex\">\\(\\alpha^2+*c\\alpha+*d\\beta^2+*e\\beta\\)</span></p>\n\n<ul>\n\t<li><span class=\"math-tex\">\\(\\left(\\alpha+*f\\beta\\right)\\left(\\alpha+*g\\beta+*h\\right)\\)</span></li>\n</ul>\n\n<p>&nbsp;</p>\n",
#             "sol": "<p><span class=\"math-tex\">\\(\\alpha^2+*c\\alpha+*d\\beta^2+*e\\beta\\\\ =\\alpha^2+*d\\beta^2+*c\\alpha+*e\\beta\\\\ =(\\alpha+\\beta)(\\alpha-\\beta)+*c(\\alpha+*j\\beta) \\\\=\\left(\\alpha+*f\\beta\\right)\\left(\\alpha+*g\\beta+*h\\right)\\)</span></p>\n\n<p>&nbsp;</p>\n",
#             "populate": "f = RndU()\r\ng = RndU()\r\nh = RndU()\r\n\r\nc = h\r\nd = f * g\r\ne = f * h\r\n\r\nj = e/c\r\n\r\noptions = {\r\n    f: [f, -f, -f],\r\n    g: [g, -g, -g],\r\n    h: [h, -h, -h]\r\n}\r\n",
#             "validate": "d === -1",
#             "preprocess": "",
#             "postprocess": "",
#             "remark": "OK"
#         }
#     },
#     ...
# ]