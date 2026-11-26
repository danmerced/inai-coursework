import heapq
import math
import sys

GRAPH_A=[(1,3,2),(1,4,4),(2,1,6),(3,4,8),(2,6,3),(6,3,5),
         (3,8,4),(8,7,5),(6,7,6),(7,5,4),(4,5,1),(5,2,7)]
GRAPH_B=[(3,1,6),(8,3,2),(1,4,3),(1,2,4),(4,3,2),(3,6,8),
         (2,6,5),(2,5,3),(4,5,7),(6,7,6),(5,7,2),(7,8,9)]
GRAPH_C=[(3,1,4),(8,3,9),(1,4,1),(1,2,2),(3,4,8),(2,6,7),
         (6,3,3),(7,6,1),(5,2,6),(4,5,5),(5,7,4),(7,8,5)]
GRAPH_D=[(1,3,2),(3,8,4),(1,4,5),(2,1,1),(4,3,8),(3,6,2),
         (6,2,4),(6,7,7),(8,7,6),(4,5,3),(5,2,9),(7,5,6)]
VARIANTS=[(GRAPH_A,1,7),(GRAPH_B,2,8),(GRAPH_C,5,3),(GRAPH_D,6,1),
          (GRAPH_B,1,8),(GRAPH_C,2,8),(GRAPH_A,6,1),(GRAPH_C,5,1),
          (GRAPH_B,7,1),(GRAPH_A,4,8)]


def matrix_from_edges(size, edges):
    matrix=[[None]*size for _ in range(size)]
    for i,j,w in edges:
        matrix[i-1][j-1]=w
    return matrix


def dijkstra(matrix,start):
    size=len(matrix)
    distances=[math.inf]*size
    previous=[None]*size
    distances[start]=0
    heap=[(0,start)]
    while heap:
        distance,current=heapq.heappop(heap)
        if distance!=distances[current]:
            continue
        for target,weight in enumerate(matrix[current]):
            if weight is None:
                continue
            if weight<0:
                raise ValueError("Дейкстра требует неотрицательных весов")
            new_distance=distance+weight
            if new_distance<distances[target]:
                distances[target]=new_distance
                previous[target]=current
                heapq.heappush(heap,(new_distance,target))
    return distances,previous


def path_to(previous,start,target):
    path=[]
    while target is not None:
        path.append(target+1)
        if target==start:
            return path[::-1]
        target=previous[target]
    return []


if __name__=="__main__":
    variant=int(sys.argv[1])%10+1
    edges,start,target=VARIANTS[variant-1]
    matrix=matrix_from_edges(8,edges)
    distances,previous=dijkstra(matrix,start-1)
    print(f"Вариант {variant}; начальная вершина {start}, указанная конечная {target}")
    for i,distance in enumerate(distances):
        print(i+1, " -> ".join(map(str,path_to(previous,start-1,i))) or "нет пути", distance)
