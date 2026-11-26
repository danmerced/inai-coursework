"""Дополнительная модель: куча и обычная очередь стоянки."""
import heapq
import random
from collections import deque


def simulate(cars=1000, seed=42):
    random.seed(seed)
    priority=[]
    arrivals=[]
    for i in range(cars):
        if random.random()<0.1:
            arrivals.append((i,random.randint(1,3),random.random()<0.02))
    queues=[deque(),deque()]
    parking=deque()
    fuel=[None,None]
    inspection=None
    waiting=[]
    fuel_times=[]
    completed=0
    arrived=0
    tick=0
    while arrived<len(arrivals) or priority or parking or inspection or any(queues) or any(fuel):
        while arrived<len(arrivals) and arrivals[arrived][0]<=tick:
            entry=arrivals[arrived]
            heapq.heappush(priority,(entry[1],entry[0],entry[2]))
            arrived+=1
        while priority:
            rank,entered,needs_inspection=priority[0]
            if needs_inspection and len(parking)>=10:
                break
            heapq.heappop(priority)
            if needs_inspection:
                parking.append((rank,entered))
            else:
                queues[random.randrange(2)].append((rank,entered))
        if inspection and inspection[0]<=tick:
            _,rank,entered=inspection
            queues[random.randrange(2)].append((rank,entered))
            inspection=None
        if inspection is None and parking:
            rank,entered=parking.popleft()
            inspection=(tick+random.randint(4,9),rank,entered)
        for i in range(2):
            if fuel[i] and fuel[i][0]<=tick:
                end,entered,started=fuel[i]
                completed+=1
                fuel_times.append(end-entered)
                waiting.append(started-entered)
                fuel[i]=None
            if fuel[i] is None and queues[i]:
                rank,entered=queues[i].popleft()
                fuel[i]=(tick+random.randint(2,7),entered,tick)
        tick+=1
    return {"traffic":cars,"visited":len(arrivals),"inspection":sum(x[2] for x in arrivals),
            "completed":completed,"mean_before_fuel":sum(waiting)/max(1,completed),
            "mean_total":sum(fuel_times)/max(1,completed),"duration":tick}


if __name__=="__main__":
    for key,value in simulate().items():
        print(key,":",value)
