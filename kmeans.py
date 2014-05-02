dataset = [(2,34),(2,54),(2,94),(10,360),(-4,530),(-4,564)]
center1 = (-4,100)
center2 = (-4,150)
def distance(point, center):
    x = point[0] - center[0]
    y = point[1] - center[1]
    return x*x + y*y
def center(cluster):
    x = 0.0
    y = 0.0
    for data in cluster:
        x += data[0]
        y += data[1]
    length = len(cluster)
    return (x/length, y/length)

while True:
    cluster1 = []
    cluster2 = []
    print center1, center2
    for data in dataset:
        if distance(data, center1) < distance(data, center2):
            cluster1 += [data]
        else:
            cluster2 += [data]

    new_center1 = center(cluster1)
    new_center2 = center(cluster2)
    
    print distance(center1, new_center1)
    print distance(center2, new_center2)
    if distance(center1, new_center1) < 0.00001 and distance(center2, new_center2) < 0.00001:
        print center1, center2
        print cluster1, cluster2
        break
    else:
        center1 = new_center1
        center2 = new_center2



