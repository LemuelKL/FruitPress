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
