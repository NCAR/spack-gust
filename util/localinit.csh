# Location variables
setenv INSTALLPATH_ROOT /glade/u/apps/gust/default/spack/opt/spack
setenv MODULEPATH_ROOT /glade/u/apps/gust/modules

# Lmod configuration
setenv LMOD_SYSTEM_NAME gust
setenv LMOD_SYSTEM_DEFAULT_MODULES "ncarenv/22.12:craype/2.7.19:cce/15.0.0:ncarcompilers/0.7.2:cray-mpich/8.1.21:netcdf/4.9.0:cray-libsci/22.11.1.2"
setenv MODULEPATH /glade/u/apps/gust/modules/environment

# Get location of Lmod initialization scripts
setenv LMOD_ROOT /glade/u/apps/gust/22.12/spack/opt/spack/lmod/8.7.14/gcc/7.5.0

# Add shell settings so Lmod can be used in bash scripts
setenv PROFILEREAD true
setenv BASH_ENV ${LMOD_ROOT}/lmod/lmod/init/bash 

# Use shell-specific init
set comm = `/bin/ps -p $$ -o cmd= |awk '{print $1}'|sed -e 's/-sh/csh/' -e 's/-csh/tcsh/' -e 's/-//g'`
set shell = `/bin/basename $comm`

source $LMOD_ROOT/lmod/lmod/init/$shell
unset comm shell

# Set system default stuff
setenv NCAR_DEFAULT_PATH /usr/local/bin:/usr/bin:/sbin:/bin
setenv NCAR_DEFAULT_MANPATH /usr/local/share/man:/usr/share/man
setenv NCAR_DEFAULT_INFOPATH /usr/local/share/info:/usr/share/info

setenv PATH ${PATH}:$NCAR_DEFAULT_PATH

if ( ! ($?MANPATH) ) then
    setenv MANPATH $NCAR_DEFAULT_MANPATH
else
    setenv MANPATH ${MANPATH}:$NCAR_DEFAULT_MANPATH
endif

if ( ! ($?INFOPATH) ) then
    setenv INFOPATH $NCAR_DEFAULT_INFOPATH
else
    setenv INFOPATH ${INFOPATH}:$NCAR_DEFAULT_INFOPATH
endif

# Load default modules
if ( ! $?__Init_Default_Modules || ! $?LD_LIBRARY_PATH ) then
  setenv __Init_Default_Modules 1
  module -q restore
endif

# Set PBS workdir if appropriate
if ( $?PBS_O_WORKDIR  && ! $?NCAR_PBS_JOBINIT ) then
    if ( -d $PBS_O_WORKDIR ) then
        cd $PBS_O_WORKDIR
    endif

    setenv NCAR_PBS_JOBINIT $PBS_JOBID
endif

# Set number of GPUs (analogous to NCPUS)
if ( `where nvidia-smi` != "" ) then
    setenv NGPUS `nvidia-smi -L | wc -l`
else
    setenv NGPUS 0
endif
