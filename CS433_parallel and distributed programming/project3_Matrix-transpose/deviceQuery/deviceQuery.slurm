#!/bin/sh
#SBATCH --job-name=GTCP_UMA
#SBATCH --partition=k40
#SBATCH -N 1
#SBATCH --gres=gpu:1
#SBATCH --ntasks-per-node=1
#SBATCH --mail-type=end
#SBATCH --mail-user=dimon-gao@sjtu.edu.cn
#SBATCH --output=%j.out
#SBATCH --error=%j.err


MODULEPATH=/lustre/utility/modulefiles:$MODULEPATH
module purge
module load cuda/8.0

./deviceQuery

