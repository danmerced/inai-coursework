import csv
from pathlib import Path

root = Path(__file__).with_name("results")
with (root/"counts.csv").open(encoding="utf-8") as file:
    rows = list(csv.DictReader(file))
width, height = 640, 360
parts = ['<svg xmlns="http://www.w3.org/2000/svg" width="640" height="360" viewBox="0 0 640 360">',
         '<rect width="640" height="360" fill="white"/>',
         '<g font-family="sans-serif" font-size="12" fill="#172033">']
for count in range(0,61,10):
    y = 285 - count*4
    parts.append(f'<line x1="64" y1="{y}" x2="550" y2="{y}" stroke="#ddd"/><text x="35" y="{y+4}">{count}</text>')
for i,row in enumerate(rows):
    x = 75 + i*76
    parts.append(f'<text x="{x-7}" y="306">{row["log10_epsilon"]}</text>')
parts.append('<path d="M64 35 V285 H552" fill="none" stroke="#172033"/>')
parts.append('<text x="64" y="23">Function evaluations</text><text x="250" y="330">log10(epsilon)</text>')
for j,(name,color) in enumerate([("dichotomy","#b64e3e"),("golden","#276b9b"),("fibonacci","#32835c")]):
    points = " ".join(f'{75+i*76},{285-int(row[name])*4}' for i,row in enumerate(rows))
    dash = ' stroke-dasharray="5 4"' if name=="fibonacci" else ''
    parts.append(f'<polyline points="{points}" fill="none" stroke="{color}" stroke-width="2.5"{dash}/>')
    parts.append(f'<text x="400" y="{18+j*16}" fill="{color}">{name}</text>')
parts.append('</g></svg>')
(root/"counts.svg").write_text("\n".join(parts), encoding="utf-8")
