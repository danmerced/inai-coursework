from collections import deque
import heapq
from itertools import count

GRAPH = {
    "A": [("B", 2), ("C", 4)],
    "B": [("D", 3), ("E", 1)],
    "C": [("E", 1), ("F", 5)],
    "D": [("G", 4)],
    "E": [("G", 2)],
    "F": [("G", 1)],
    "G": [],
}
HEURISTIC = {"A": 5, "B": 3, "C": 3, "D": 4, "E": 2, "F": 1, "G": 0}

def bfs(graph, start, goal):
    queue = deque([(start, [start])])
    seen = {start}
    while queue:
        node, path = queue.popleft()
        if node == goal:
            return path
        for neighbor, _ in graph[node]:
            if neighbor not in seen:
                seen.add(neighbor)
                queue.append((neighbor, path + [neighbor]))
    return None

def dfs(graph, start, goal, limit=None):
    def visit(node, path):
        if node == goal:
            return path
        if limit is not None and len(path) - 1 >= limit:
            return None
        for next_node, _ in graph[node]:
            if next_node not in path:
                solution = visit(next_node, path + [next_node])
                if solution is not None:
                    return solution
        return None
    return visit(start, [start])

def iterative_deepening(graph, start, goal):
    for depth in range(len(graph)):
        result = dfs(graph, start, goal, depth)
        if result:
            return result
    return None

def astar(graph, start, goal, heuristic):
    sequence = count()
    heap = [(heuristic[start], next(sequence), 0, start, [start])]
    best = {start: 0}
    while heap:
        _, _, cost, node, path = heapq.heappop(heap)
        if cost != best[node]:
            continue
        if node == goal:
            return path, cost
        for next_node, weight in graph[node]:
            new_cost = cost + weight
            if new_cost < best.get(next_node, float("inf")):
                best[next_node] = new_cost
                heapq.heappush(heap, (new_cost + heuristic[next_node], next(sequence), new_cost, next_node, path + [next_node]))
    return None

if __name__ == "__main__":
    print("BFS:", bfs(GRAPH, "A", "G"))
    print("DFS:", dfs(GRAPH, "A", "G"))
    print("DLS (depth 2):", dfs(GRAPH, "A", "G", 2))
    print("Iterative deepening:", iterative_deepening(GRAPH, "A", "G"))
    print("A*:", astar(GRAPH, "A", "G", HEURISTIC))
