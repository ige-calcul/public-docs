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
