import psutil, time, multiprocessing, os

def get_cpu_id():
    process = psutil.Process()
    cpu_affinity = process.cpu_affinity()
    cpu_id = process.cpu_num()
    return cpu_affinity, cpu_id
def p():
    time.sleep(0.5)
    aff, cid = get_cpu_id()
    node = os.getenv('SLURM_NODEID')
    print(cid, ":", aff, ":", node)
    if cid not in aff:
        print("WARNING, TASK NOT IN AFFINITY CPU")

aT = multiprocessing.Process(target=p, args = ())
bT = multiprocessing.Process(target=p, args = ())
aT.start()
bT.start()

aT.join()
bT.join()
