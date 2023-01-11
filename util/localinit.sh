# Location variables
export INSTALLPATH_ROOT=/glade/u/apps/gust/default/spack/opt/spack
export MODULEPATH_ROOT=/glade/u/apps/gust/modules

# Lmod configuration
export LMOD_SYSTEM_NAME=gust
export LMOD_SYSTEM_DEFAULT_MODULES="ncarenv/22.12:craype/2.7.19:cce/15.0.0:ncarcompilers/0.7.1:cray-mpich/8.1.21:netcdf/4.9.0:cray-libsci/22.11.1.2"
export MODULEPATH=/glade/u/apps/gust/modules/environment

# Location of Lmod initialization scripts
LMOD_ROOT=/glade/u/apps/gust/22.12/spack/opt/spack/lmod/8.7.14/gcc/7.5.0

# Use shell-specific init
comm=`/bin/ps -p $$ -o cmd= |awk '{print $1}'|sed -e 's/-sh/csh/' -e 's/-csh/tcsh/' -e 's/-//g'`
shell=`/bin/basename $comm`

if [ -f $LMOD_ROOT/lmod/lmod/init/$shell ]; then
    . $LMOD_ROOT/lmod/lmod/init/$shell
else
    . $LMOD_ROOT/lmod/lmod/init/sh
fi

unset comm shell

# Set system default stuff
export NCAR_DEFAULT_PATH=/usr/local/bin:/usr/bin:/sbin:/bin
export NCAR_DEFAULT_MANPATH=/usr/local/share/man:/usr/share/man
export NCAR_DEFAULT_INFOPATH=/usr/local/share/info:/usr/share/info

export PATH=${PATH}:$NCAR_DEFAULT_PATH
export MANPATH=${MANPATH}:$NCAR_DEFAULT_MANPATH
export INFOPATH=${INFOPATH}:$NCAR_DEFAULT_INFOPATH

# Load default modules
if [ -z "$__Init_Default_Modules" -o -z "$LD_LIBRARY_PATH" ]; then
  __Init_Default_Modules=1; export __Init_Default_Modules;
  module -q restore 
fi

# Set PBS workdir if appropriate
if [ -n "$PBS_O_WORKDIR" ] && [ -z "$NCAR_PBS_JOBINIT" ]; then
    if [ -d "$PBS_O_WORKDIR" ]; then
        cd $PBS_O_WORKDIR
    fi

    export NCAR_PBS_JOBINIT=$PBS_JOBID
fi

# Set number of GPUs (analogous to NCPUS)
if command -v nvidia-smi &> /dev/null; then
    export NGPUS=`nvidia-smi -L | wc -l`
else
    export NGPUS=0
fi
