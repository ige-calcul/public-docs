This short tutorial shows how to run different executables simultaneously (MPMD mode) with MPI. It also aims to
demonstrate that MPI can be used to exchange data across different programs. This is useful, for example, when coupling
an ocean model and an atmosphere model that are being developped separately.

> Here [the files](./) for this tutorial !

# Prerequisites

This tutorial assumes that you:

 - know the basics of FORTRAN programming.

 - know the basics of parallelizing code using MPI.

 - know how to compile FORTRAN programs that link to external libraries;

 - know how to run FORTRAN programs that use MPI.

# SPMD versus MPMD

Imagine that your computer has 8 processors and that your model (let us call it `model.exe`) is parallelized using
MPI. You can run this model using all 8 processors with something like:

```
$> mpirun -np 8 ./model.exe
```

This workflow is sometimes ambiguously called **SPMD** (single program, multiple data).

Now imagine that you have two models, one for the atmosphere (`atmosphere.exe`) and one for the ocean
(`ocean.exe`). Both are parallelized using MPI. You want to couple them so that they can exchange information as they
run. For example, the water that rains out of the atmosphere must enter the ocean. Since modeling the ocean is more
computationnaly expensive than modeling the atmosphere, you give only 3 processors to `atmosphere.exe` and the
remaining 5 to `ocean.exe`. You can do this with something like:

```
$> mpirun -np 3 ./atmosphere.exe : -np 5 ./ocean.exe
```

This workflow is sometimes called **MPMD** (multiple programs, multiple data).

In this last example, there were two levels of parallelization:

 1. two different executables are run in parallel and they can exchange information (MPMD parallelization).

 2. each one of these executables can use several processors to do their own personal job faster. This is commonly
 known as "internal parallelization". This is the same kind of parallelization as in the SPMD workflow.

Both levels of parallelization can be achieved with MPI. This tutorial shows basic examples of MPMD parallelization (it
assumes that you already known how to implement and use internal parallelization).

# Minimum working example

This section shows the very basics of MPMD parallelization. We will run two different programs in parallel, but they
will not exchange information. Consider the two following FORTRAN programs
(cf. [atmosphere.f90](01_minimum-working-example/atmosphere.f90) and
[ocean.f90](01_minimum-working-example/ocean.f90)):

```Fortran
program atmosphere

  use mpi
  implicit none

  character (len=10), parameter :: name = "atmosphere"
  character (len=24) :: ctime
  integer :: time, error, n_proc, myself

  call mpi_init(error)
  call mpi_comm_size(mpi_comm_world, n_proc, error)
  call mpi_comm_rank(mpi_comm_world, myself, error)

  print '(A, I1, A, I1)', name // ", n_proc=", n_proc, ", my rank=", myself
  print '(A, I1, A)', name // " (rank=", myself, "), done at " // ctime(time())

  call mpi_finalize(error)

end program atmosphere
```

```Fortran
program ocean

  use mpi
  implicit none

  character (len=5), parameter :: name = "ocean"
  character (len=24) :: ctime
  integer :: time, error, n_proc, myself

  call mpi_init(error)
  call mpi_comm_size(mpi_comm_world, n_proc, error)
  call mpi_comm_rank(mpi_comm_world, myself, error)

  print '(A, I1, A, I1)', name // ", n_proc=", n_proc, ", my rank=", myself
  call sleep(120)
  print '(A, I1, A)', name // " (rank=", myself, "), done at " // ctime(time())

  call mpi_finalize(error)

end program ocean

```

The first of these programs does nothing beyond initializing MPI resources, printing information, and finalizing MPI
resources. The second program is almost identical, but it waits (doing nothing) for two minutes in the middle of the
process. These two programs are completely independent from each other. They are compiled separately, yielding two
independent binaries. Let us run them simultaneously through MPI as suggested above:

```
$> mpirun -np 3 ./atmosphere.exe : -np 5 ./ocean.exe
```

This produces the following output (lines do not necessarily appear in this order, they were re-ordered for clarity):

```
atmosphere, n_proc=8, my rank=0
atmosphere, n_proc=8, my rank=1
atmosphere, n_proc=8, my rank=2
ocean, n_proc=8, my rank=3
ocean, n_proc=8, my rank=4
ocean, n_proc=8, my rank=5
ocean, n_proc=8, my rank=6
ocean, n_proc=8, my rank=7
atmosphere (rank=0), done at Thu Apr 18 15:28:01 2024
atmosphere (rank=1), done at Thu Apr 18 15:28:01 2024
atmosphere (rank=2), done at Thu Apr 18 15:28:01 2024
ocean (rank=3), done at Thu Apr 18 15:30:01 2024
ocean (rank=4), done at Thu Apr 18 15:30:01 2024
ocean (rank=5), done at Thu Apr 18 15:30:01 2024
ocean (rank=6), done at Thu Apr 18 15:30:01 2024
ocean (rank=7), done at Thu Apr 18 15:30:01 2024
```

NB: the return value (`$?` in bash) of this command is 0, meaning that it returned without error.

In the example above, `mpirun` launches only one parallel application with a total of 8 processes, gives 3 of them to
`atmosphere.exe` and 5 of them to `ocean.exe`. Each of these programs sees that there is a total of 8
processes. `atmosphere.exe` obviously finishes before `ocean.exe`, but it does not generate an error. The execution of
`mpirun` ends when all processes have finished.

# Exchanging data between different programs

In "classic" SPMD mode, one can use MPI to exchange data between different processes. It works exactly the same way in
MPMD mode! In the previous example, process 0, which is an instance of `atmosphere.exe`, can send data to process 1,
which is another instance of `atmosphere.exe`, but it can also send data to process 7, which is an instance of
`ocean.exe`. It makes no difference to MPI to which program corresponds which process.

Now let us try to exchange data between different programs. For that, consider the following versions of
[atmosphere.f90](02_exchanging-data/atmosphere.f90) and [ocean.f90](02_exchanging-data/ocean.f90):

```Fortran
program atmosphere

  use mpi
  implicit none

  character (len=10), parameter :: name = "atmosphere"
  integer :: error, n_proc, myself, n

  call mpi_init(error)
  call mpi_comm_size(mpi_comm_world, n_proc, error)
  call mpi_comm_rank(mpi_comm_world, myself, error)

  if (myself == 0) then
     print '(A, I1, A, I4)', name // " (rank=", myself, ") sending ", 1234
     call mpi_send(1234, 1, mpi_int, 7, 0, mpi_comm_world, error)
     call mpi_recv(n, 1, mpi_int, 7, 1, mpi_comm_world, mpi_status_ignore, error)
     print '(A, I1, A, I4)', name // " (rank=", myself, "), received ", n
  endif

  call mpi_finalize(error)

end program atmosphere
```

```Fortran
program ocean

  use mpi
  implicit none

  character(len=5), parameter :: name = "ocean"
  integer :: error, n_proc, myself, n

  call mpi_init(error)
  call mpi_comm_size(mpi_comm_world, n_proc, error)
  call mpi_comm_rank(mpi_comm_world, myself, error)

  if (myself == 7) then
     call mpi_recv(n, 1, mpi_int, 0, 0, mpi_comm_world, mpi_status_ignore, error)
     print '(A, I1, A, I4)', name // " (rank=", myself, "), received ", n
     print '(A, I1, A, I4)', name // " (rank=", myself, "), sending ", 5678
     call mpi_send(5678, 1, mpi_int, 0, 1, mpi_comm_world, error)
  endif

  call mpi_finalize(error)

end program ocean
```

Here, for simplicity, we rely on the fact that the process of rank 0 is associated with `atmosphere.exe` and that the
process of rank 7 is associated with `ocean.exe`, and we hard-code these numbers into the programs. We would never do
that in a real application, but it works for this example (I don't even know whether the MPI specification requires
that ranks are attributed in a predictable manner like that, but it works in my environment). In the code above,
`atmosphere.exe` sends the integer 1234 to `ocean.exe` and `ocean.exe` sends the integer 5678 to `atmosphere.exe`.

After running these two programs through mpirun (same as before), we get the following output (and a 0 return status):

```
$> mpirun -np 3 ./atmosphere.exe : -np 5 ./ocean.exe

atmosphere (rank=0) sending 1234
ocean (rank=7), received 1234
ocean (rank=7), sending 5678
atmosphere (rank=0), received 5678
```

# Grouping processes by program

This is nice, but it would be convenient for all the `atmosphere.exe` processes to be able to talk to each other
without bothering the `ocean.exe` processes, and vice-versa, so that developpers can work on internal parallelization.

Thankfully, in MPI, the concept of "group of processes" exists. To each group is associated a **communicator**. The
conceptual difference between group and communicator is not entirely clear to me at this stage, but it seems that, for
most use cases, we can use these concepts interchangeably. When running an application through MPI, one communicator is
always created by default: it is called `mpi_comm_world` and contains all the processes, as seen in the examples above.

Users can create other communicators. For example, in an MPMD application, it seems natural to create one communicator
for each program. In the examples above, that would mean creating one communicator containing all the `atmosphere.exe`
processes and another communicator containing all the `ocean.exe` processes.

This can be done, but it requires to have a way to uniquely identify each program (an ID number, a name, etc.). For
example, using integer ID numbers (cf. [atmosphere.f90](03_grouping-processes/atmosphere.f90) and
[ocean.f90](03_grouping-processes/ocean.f90)):

```Fortran
program atmosphere

  use mpi
  implicit none

  character (len=10), parameter :: name = "atmosphere"
  integer, parameter :: my_id = 1234
  integer :: error, n_proc, comm_local, rank_world, rank_local

  call mpi_init(error)
  call mpi_comm_size(mpi_comm_world, n_proc, error)
  call mpi_comm_rank(mpi_comm_world, rank_world, error)

  call mpi_comm_split(mpi_comm_world, my_id, rank_world, comm_local, error)
  call mpi_comm_rank(comm_local, rank_local, error)

  print '(A, I1, A, I1, A, I1)', name // ", n_proc=", n_proc, &
        ", world rank=", rank_world, ", local rank=", rank_local

  call mpi_finalize(error)

end program atmosphere
```

```Fortran
program ocean

  use mpi
  implicit none

  character (len=5), parameter :: name = "ocean"
  integer, parameter :: my_id = 5678
  integer :: error, n_proc, comm_local, rank_world, rank_local

  call mpi_init(error)
  call mpi_comm_size(mpi_comm_world, n_proc, error)
  call mpi_comm_rank(mpi_comm_world, rank_world, error)

  call mpi_comm_split(mpi_comm_world, my_id, rank_world, comm_local, error)
  call mpi_comm_rank(comm_local, rank_local, error)

  print '(A, I1, A, I1, A, I1)', name // ", n_proc=", n_proc, &
        ", world rank=", rank_world, ", local rank=", rank_local

  call mpi_finalize(error)

end program ocean
```

Running these two programs through mpirun (same as before) yields the following output (and a 0 exit satus):

```
$> mpirun -np 3 ./atmosphere.exe : -np 5 ./ocean.exe

atmosphere, n_proc=8, world rank=0, local rank=0
atmosphere, n_proc=8, world rank=1, local rank=1
atmosphere, n_proc=8, world rank=2, local rank=2
ocean, n_proc=8, world rank=3, local rank=0
ocean, n_proc=8, world rank=4, local rank=1
ocean, n_proc=8, world rank=5, local rank=2
ocean, n_proc=8, world rank=6, local rank=3
ocean, n_proc=8, world rank=7, local rank=4
```

A processor that belongs to two communicators or more may not have the same rank in each communicator. In a
communicator with _n_ processes, rank numbers vary from _0_ to _(n-1)_. For example, in the communicator that is local
to `ocean.exe`, processes have ranks 0, 1, 2, 3, and 4 whereas their ranks in the world-wide communicator are 3, 4, 5,
6, and 7, respectively.

```{tip}
In your programs, never use `mpi_comm_world` when you want to select all processes for internal parallelization
purposes, because this will not work in MPMD applications. In MPMD applications, create local communicators as shown
above. In SPMD applications, create a communicator that is a copy of `mpi_comm_world`. This will make your
program easier to port to MPMD applications.
```

```{note}
If you use XIOS or the OASIS coupler, then creating local per-program communicators will most likely be done using the
initialization routines provided by these libraries (`xios_initialize` for XIOS, `oasis_init_comp` and
`oasis_get_localcomm` for OASIS).
```

```{important}
This content is licensed under the [Creative Commons Attribution 4.0 International Public
License](https://creativecommons.org/licenses/by/4.0/).
```
