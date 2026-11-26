// Integer rasterization and 2D geometry.
function line(x0, y0, x1, y1) {
    const points = [];
    const dx = Math.abs(x1 - x0);
    const dy = -Math.abs(y1 - y0);
    const sx = x0 < x1 ? 1 : -1;
    const sy = y0 < y1 ? 1 : -1;
    let err = dx + dy;
    while (true) {
        points.push([x0, y0]);
        if (x0 === x1 && y0 === y1) break;
        const e2 = 2 * err;
        if (e2 >= dy) { err += dy; x0 += sx; }
        if (e2 <= dx) { err += dx; y0 += sy; }
    }
    return points;
}

function circle(cx, cy, radius) {
    let x = radius, y = 0, error = 1 - radius;
    const points = new Map();
    while (x >= y) {
        for (const [a, b] of [[x,y],[y,x],[-x,y],[-y,x],[x,-y],[y,-x],[-x,-y],[-y,-x]]) {
            const px = cx + a, py = cy + b;
            points.set(px + ',' + py, [px, py]);
        }
        y++;
        if (error < 0) error += 2 * y + 1;
        else { x--; error += 2 * (y - x) + 1; }
    }
    return [...points.values()];
}

function transform(points, angle, scale, tx, ty) {
    const a = angle * Math.PI / 180;
    const c = Math.cos(a), s = Math.sin(a);
    return points.map(([x,y]) => [
        scale * (x * c - y * s) + tx,
        scale * (x * s + y * c) + ty
    ]);
}

function fillPolygon(vertices) {
    if (vertices.length < 3) return [];
    const pixels = [];
    const minY = Math.ceil(Math.min(...vertices.map(v => v[1])) - 0.5);
    const maxY = Math.floor(Math.max(...vertices.map(v => v[1])) - 0.5);
    for (let y = minY; y <= maxY; y++) {
        const scan = y + 0.5, intersections = [];
        for (let i = 0; i < vertices.length; i++) {
            const [x1,y1] = vertices[i];
            const [x2,y2] = vertices[(i+1) % vertices.length];
            if ((y1 <= scan && scan < y2) || (y2 <= scan && scan < y1)) {
                intersections.push(x1 + (scan-y1)*(x2-x1)/(y2-y1));
            }
        }
        intersections.sort((a,b)=>a-b);
        for (let i=0; i+1<intersections.length; i+=2) {
            for (let x=Math.ceil(intersections[i]-0.5); x+0.5<intersections[i+1]; x++) {
                pixels.push([x,y]);
            }
        }
    }
    return pixels;
}

if (typeof module !== 'undefined') module.exports = {line, circle, transform, fillPolygon};
