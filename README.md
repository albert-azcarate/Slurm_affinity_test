# Slurm_affinity_test

This repository contains tests for Slurm workload manager with a focus on the `--cpu-bind` and `--distribution` options and their effects on CPU masks and affinity of each task.

## About Slurm

Slurm is an open-source workload manager designed for Linux clusters of all sizes. It provides three key functions:

1. Allocate exclusive and/or non-exclusive access to resources (compute nodes) to users for some duration of time so they can perform work.
2. Provide a framework for starting, executing, and monitoring work (typically a parallel job) on the set of allocated nodes.
3. Arbitrate contention for resources by managing a queue of pending work.

## --cpu-bind and --distribution options

`--cpu-bind` and `--distribution` are two important options in Slurm that allow the user to specify how tasks are bound to CPUs. The `--cpu-bind` option controls how the CPU mask is constructed for each task, while `--distribution` controls how tasks are distributed across the allocated resources.

### CPU Mask

The CPU mask determines which CPUs are available for a task to use. By default, all available CPUs are used. However, by using the `--cpu-bind` option, the CPU mask can be modified to include only a subset of the available CPUs.

### Affinity

CPU affinity refers to the relationship between a task and the CPUs it is allowed to use. In Slurm, tasks can be bound to specific CPUs using CPU affinity settings. The `--cpu-bind` option can be used to set the CPU affinity of each task.

### Distribution

`--distribution` controls how tasks are distributed across the available CPUs. It determines how the CPUs are divided into slices, and how the slices are allocated to the tasks. The `--distribution` option can have a significant impact on the performance of a parallel job.
