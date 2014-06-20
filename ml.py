import random
 
def rectangle(N):
    n_hits = 0
    specific = []
    #general = []
    for i in range(N):
        x, y = random.uniform(0.0, 10.0), random.uniform(0.0, 10.0)
        if x >= 3.0 and x <= 7.0 and y >= 3.0 and y <= 7.0:
            n_hits += 1
            specific += [(x, y)]
        #else:
        #    general += [(x,y)]
    s_xmin = 7.0
    s_xmax = 3.0
    s_ymin = 7.0
    s_ymax = 3.0
    for s in specific:
       if s[0] < s_xmin:
           s_xmin = s[0]
       if s[0] > s_xmax:
           s_xmax = s[0]    
       if s[1] < s_ymin:
           s_ymin = s[1]
       if s[1] > s_ymax:
           s_ymax = s[1]    
    print '[', s_xmin, ',', s_xmax, '] X [', s_ymin, ',', s_ymax, ']'
    print (16-(s_xmin-s_xmax) * (s_ymin-s_ymax)),'%'
    e_hits = 0
    e_N = 1000
    for i in range(e_N):
        x, y = random.uniform(0.0, 10.0), random.uniform(0.0, 10.0)
        s1 = ((x >= 3.0) and (x < s_xmin) and (y >= 3.0) and (y <= 7.0))
        s2 = ((x > s_xmax) and (x <= 7.0) and (y >= 3.0) and (y <= 7.0))
        s3 = ((y >= 3.0) and (y < s_ymin) and (x >= 3.0) and (x <= 7.0))
        s4 = ((y > s_ymax) and (y <= 7.0) and (x >= 3.0) and (x <= 7.0))
        if s1 or s2 or s3 or s4:
            e_hits += 1

    print e_hits*1.0/e_N*100, "%"
    #g_xmin = 0.0
    #g_xmax = 10.0
    #g_ymin = 0.0
    #g_ymax = 10.0
    #for g in general:
    #   if g[0] < 3.0 and g[0] > g_xmin:
    #       g_xmin = g[0]
    #   if g[0] > 7.0 and g[0] < g_xmax:
    #       g_xmax = g[0]    
    #   if g[1] < 3.0 and g[1] > g_ymin:
    #       g_ymin = g[1]
    #   if g[1] > 7.0 and g[1] < g_ymax:
    #       g_ymax = g[1]    
    #print g_xmin, g_xmax, g_ymin, g_ymax        
    return n_hits
 
n_runs = 10
n_trials = 1000
for run in range(n_runs):
    print run+1
    rectangle(n_trials) / float(n_trials)
    #print rectangle(n_trials) / float(n_trials)