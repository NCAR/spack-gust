require("strict")
local hook = require("Hook")

local mapT =
{
   grouped = {
      ['/environment$'] = "NCAR and Cray Environments",
      ['/Core$'] = "Compilers and Core Software",
      ['modules[/%.%d]*/nvhpc/22%.2$'] = 'Compiler-dependent Software - [nvhpc/22.2]',
      ['modules[/%.%d]*/nvhpc/21%.3$'] = 'Compiler-dependent Software - [nvhpc/21.3]',
      ['modules[/%.%d]*/nvhpc/22%.7$'] = 'Compiler-dependent Software - [nvhpc/22.7]',
      ['modules[/%.%d]*/intel/2021%.6%.0$'] = 'Compiler-dependent Software - [intel/2021.6.0]',
      ['modules[/%.%d]*/oneapi/2022%.1%.0$'] = 'Compiler-dependent Software - [oneapi/2022.1.0]',
      ['modules[/%.%d]*/openmpi/4%.1%.4/nvhpc/22%.2$'] = 'MPI-dependent Software - [nvhpc/22.2 + openmpi/4.1.4]',
      ['modules[/%.%d]*/openmpi/4%.1%.4/nvhpc/21%.3$'] = 'MPI-dependent Software - [nvhpc/21.3 + openmpi/4.1.4]',
      ['modules[/%.%d]*/openmpi/4%.1%.4/nvhpc/22%.7$'] = 'MPI-dependent Software - [nvhpc/22.7 + openmpi/4.1.4]',
      ['modules[/%.%d]*/openmpi/4%.1%.4/intel/2021%.6%.0$'] = 'MPI-dependent Software - [intel/2021.6.0 + openmpi/4.1.4]',
      ['modules[/%.%d]*/openmpi/4%.1%.4/oneapi/2022%.1%.0$'] = 'MPI-dependent Software - [oneapi/2022.1.0 + openmpi/4.1.4]',
      ['modules[/%.%d]*/openmpi/4%.1%.4/cce/14%.0%.3$'] = 'MPI-dependent Software - [cce/14.0.3 + openmpi/4.1.4]',
      ['modules[/%.%d]*/openmpi/4%.1%.4/gcc/11%.2%.0$'] = 'MPI-dependent Software - [gcc/11.2.0 + openmpi/4.1.4]',
      ['modules[/%.%d]*/openmpi/4%.1%.4/gcc/10%.3%.0$'] = 'MPI-dependent Software - [gcc/10.3.0 + openmpi/4.1.4]',
      ['modules[/%.%d]*/openmpi/4%.1%.4/gcc/12%.1%.0$'] = 'MPI-dependent Software - [gcc/12.1.0 + openmpi/4.1.4]',
      ['modules[/%.%d]*/cce/14%.0%.3$'] = 'Compiler-dependent Software - [cce/14.0.3]',
      ['modules[/%.%d]*/cce/15%.0%.0$'] = 'Compiler-dependent Software - [cce/15.0.0]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.19/nvhpc/22%.2$'] = 'MPI-dependent Software - [nvhpc/22.2 + cray-mpich/8.1.19]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.19/nvhpc/21%.3$'] = 'MPI-dependent Software - [nvhpc/21.3 + cray-mpich/8.1.19]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.19/nvhpc/22%.7$'] = 'MPI-dependent Software - [nvhpc/22.7 + cray-mpich/8.1.19]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.19/intel/2021%.6%.0$'] = 'MPI-dependent Software - [intel/2021.6.0 + cray-mpich/8.1.19]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.19/oneapi/2022%.1%.0$'] = 'MPI-dependent Software - [oneapi/2022.1.0 + cray-mpich/8.1.19]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.19/cce/14%.0%.3$'] = 'MPI-dependent Software - [cce/14.0.3 + cray-mpich/8.1.19]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.19/gcc/11%.2%.0$'] = 'MPI-dependent Software - [gcc/11.2.0 + cray-mpich/8.1.19]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.19/gcc/10%.3%.0$'] = 'MPI-dependent Software - [gcc/10.3.0 + cray-mpich/8.1.19]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.19/gcc/12%.1%.0$'] = 'MPI-dependent Software - [gcc/12.1.0 + cray-mpich/8.1.19]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/nvhpc/22%.7$'] = 'MPI-dependent Software - [nvhpc/22.7 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/intel/2021%.6%.0$'] = 'MPI-dependent Software - [intel/2021.6.0 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/oneapi/2022%.1%.0$'] = 'MPI-dependent Software - [oneapi/2022.1.0 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/cce/15%.0%.0$'] = 'MPI-dependent Software - [cce/15.0.0 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/gcc/12%.1%.0$'] = 'MPI-dependent Software - [gcc/12.1.0 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/gcc/11%.2%.0$'] = 'Compiler-dependent Software - [gcc/11.2.0]',
      ['modules[/%.%d]*/gcc/10%.3%.0$'] = 'Compiler-dependent Software - [gcc/10.3.0]',
      ['modules[/%.%d]*/gcc/12%.1%.0$'] = 'Compiler-dependent Software - [gcc/12.1.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/nvhpc/22%.7$'] = 'MPI-dependent Software - [nvhpc/22.7 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/intel/2021%.6%.0$'] = 'MPI-dependent Software - [intel/2021.6.0 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/intel/2022%.1%.0$'] = 'MPI-dependent Software - [intel/2022.1.0 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/oneapi/2022%.1%.0$'] = 'MPI-dependent Software - [oneapi/2022.1.0 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/cce/14%.0%.3$'] = 'MPI-dependent Software - [cce/14.0.3 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/cce/15%.0%.0$'] = 'MPI-dependent Software - [cce/15.0.0 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/cce/14%.0%.2$'] = 'MPI-dependent Software - [cce/14.0.2 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/gcc/11%.2%.0$'] = 'MPI-dependent Software - [gcc/11.2.0 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/gcc/12%.1%.0$'] = 'MPI-dependent Software - [gcc/12.1.0 + mpi-serial/2.3.0]',
      ['perftools/22%.06%.0/modulefiles$'] = 'Cray Performance Analysis Tools - [perftools-base/22.06.0]',
      ['perftools/22%.09%.0/modulefiles$'] = 'Cray Performance Analysis Tools - [perftools-base/22.09.0]',
   },
}

function avail_hook(t)
   local availStyle = masterTbl().availStyle
   local styleT     = mapT[availStyle]
   if (not availStyle or availStyle == "system" or styleT == nil) then
      return
   end

   for k,v in pairs(t) do
      for pat,label in pairs(styleT) do
         if (k:find(pat)) then
            t[k] = label
            break
         end
      end
   end
end

hook.register("avail",avail_hook)
