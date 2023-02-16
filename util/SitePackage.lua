require("strict")
local hook = require("Hook")

local mapT =
{
   grouped = {
      ['/environment$'] = "NCAR and Cray Environments",
      ['/Core$'] = "Compilers and Core Software",
      ['modules[/%.%d]*/nvhpc/22%.11$'] = 'Compiler-dependent Software - [nvhpc/22.11]',
      ['modules[/%.%d]*/nvhpc/23%.1$'] = 'Compiler-dependent Software - [nvhpc/23.1]',
      ['modules[/%.%d]*/intel/2021%.6%.0$'] = 'Compiler-dependent Software - [intel/2021.6.0]',
      ['modules[/%.%d]*/intel/2021%.7%.1$'] = 'Compiler-dependent Software - [intel/2021.7.1]',
      ['modules[/%.%d]*/oneapi/2022%.2%.1$'] = 'Compiler-dependent Software - [oneapi/2022.2.1]',
      ['modules[/%.%d]*/oneapi/2023%.0%.0$'] = 'Compiler-dependent Software - [oneapi/2023.0.0]',
      ['modules[/%.%d]*/oneapi/2022%.1%.0$'] = 'Compiler-dependent Software - [oneapi/2022.1.0]',
      ['modules[/%.%d]*/cce/15%.0%.0$'] = 'Compiler-dependent Software - [cce/15.0.0]',
      ['modules[/%.%d]*/cce/15%.0%.1$'] = 'Compiler-dependent Software - [cce/15.0.1]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.24/nvhpc/22%.11$'] = 'MPI-dependent Software - [nvhpc/22.11 + cray-mpich/8.1.24]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.24/nvhpc/23%.1$'] = 'MPI-dependent Software - [nvhpc/23.1 + cray-mpich/8.1.24]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.24/intel/2021%.7%.1$'] = 'MPI-dependent Software - [intel/2021.7.1 + cray-mpich/8.1.24]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.24/oneapi/2023%.0%.0$'] = 'MPI-dependent Software - [oneapi/2023.0.0 + cray-mpich/8.1.24]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.24/cce/15%.0%.1$'] = 'MPI-dependent Software - [cce/15.0.1 + cray-mpich/8.1.24]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.24/gcc/11%.2%.0$'] = 'MPI-dependent Software - [gcc/11.2.0 + cray-mpich/8.1.24]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.24/gcc/12%.1%.0$'] = 'MPI-dependent Software - [gcc/12.1.0 + cray-mpich/8.1.24]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/nvhpc/22%.11$'] = 'MPI-dependent Software - [nvhpc/22.11 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/nvhpc/23%.1$'] = 'MPI-dependent Software - [nvhpc/23.1 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/intel/2021%.6%.0$'] = 'MPI-dependent Software - [intel/2021.6.0 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/intel/2021%.7%.1$'] = 'MPI-dependent Software - [intel/2021.7.1 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/oneapi/2022%.2%.1$'] = 'MPI-dependent Software - [oneapi/2022.2.1 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/oneapi/2023%.0%.0$'] = 'MPI-dependent Software - [oneapi/2023.0.0 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/oneapi/2022%.1%.0$'] = 'MPI-dependent Software - [oneapi/2022.1.0 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/cce/15%.0%.0$'] = 'MPI-dependent Software - [cce/15.0.0 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/gcc/11%.2%.0$'] = 'MPI-dependent Software - [gcc/11.2.0 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.21/gcc/12%.1%.0$'] = 'MPI-dependent Software - [gcc/12.1.0 + cray-mpich/8.1.21]',
      ['modules[/%.%d]*/gcc/11%.2%.0$'] = 'Compiler-dependent Software - [gcc/11.2.0]',
      ['modules[/%.%d]*/gcc/12%.1%.0$'] = 'Compiler-dependent Software - [gcc/12.1.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/nvhpc/22%.11$'] = 'MPI-dependent Software - [nvhpc/22.11 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/nvhpc/23%.1$'] = 'MPI-dependent Software - [nvhpc/23.1 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/intel/2021%.7%.1$'] = 'MPI-dependent Software - [intel/2021.7.1 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/oneapi/2022%.2%.1$'] = 'MPI-dependent Software - [oneapi/2022.2.1 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/cce/15%.0%.0$'] = 'MPI-dependent Software - [cce/15.0.0 + mpi-serial/2.3.0]',
      ['modules[/%.%d]*/mpi%-serial/2%.3%.0/gcc/12%.1%.0$'] = 'MPI-dependent Software - [gcc/12.1.0 + mpi-serial/2.3.0]',
      ['perftools/22%.06%.0/modulefiles$'] = 'Cray Performance Analysis Tools - [perftools-base/22.06.0]',
      ['modulefiles/perftools/22%.06%.0$'] = 'Cray Performance Analysis Tools - [perftools-base/22.06.0]',
      ['perftools/22%.09%.0/modulefiles$'] = 'Cray Performance Analysis Tools - [perftools-base/22.09.0]',
      ['modulefiles/perftools/22%.09%.0$'] = 'Cray Performance Analysis Tools - [perftools-base/22.09.0]',
      ['perftools/23%.02%.0/modulefiles$'] = 'Cray Performance Analysis Tools - [perftools-base/23.02.0]',
      ['modulefiles/perftools/23%.02%.0$'] = 'Cray Performance Analysis Tools - [perftools-base/23.02.0]',
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
