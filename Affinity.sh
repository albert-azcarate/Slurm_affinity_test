#!/bin/bash

#array of cpu_bind
cpu_bind=( "" ",rank" ",rank_ldom" ",sockets" ",cores" ",threads" ",ldoms" )
#array of node_affinity
node_affinity=( "block" "cyclic" "arbitrary" "plane" )
#array of sockets_affinity
sockets_affinity=( "block" "cyclic" "fcyclic" )
#array of cores_affinity
cores_affinity=( "block" "cyclic" "fcyclic" )

for j in "${node_affinity[@]}"; do
	for k in "${sockets_affinity[@]}"; do
	        for l in "${cores_affinity[@]}"; do
			mkdir $j:$k:$l
		done
	done
done
mkdir arbitrary

for i in "${cpu_bind[@]}"; do
	for j in "${node_affinity[@]}"; do
		#if plane is used, set SLURM_DIST_PLANESIZE
		if [ "$j" == "plane" ]; then
			export SLURM_DIST_PLANESIZE=5
		fi 
		#if arbitrary is used, set SLURM_HOSTFILE
		if [ "$j" == "arbitrary" ]; then
			cd arbitrary
			if [ "$i" == "" ]; then
				exec > -.txt 2>&1
			else
				exec > $i.txt 2>&1
			fi
			export SLURM_HOSTFILE=/path/to/affinity/hostfile
			srun -l -n 12 --cpus-per-task=2 --cpu-bind=v$i --distribution=$j python threadsleep.py
			unset SLURM_HOSTFILE
			cd ..
		else
			for k in "${sockets_affinity[@]}"; do
				for l in "${cores_affinity[@]}"; do
					cd $j\:$k\:$l
					if [ "$i" == "" ]; then
                        			exec > -.txt 2>&1
			                else
						exec > $i.txt 2>&1
					fi
					#srun and save the output to a file with the name of the affinity
					srun -l -n 12 --cpus-per-task=2 --cpu-bind=v$i --distribution=$j:$k:$l python threadsleep.py
					cd ..
				done
			done
		fi
		#if plane is used, unset SLURM_DIST_PLANESIZE
		if [ "$j" == "plane" ]; then
			unset SLURM_DIST_PLANESIZE
		fi 
	done
done
