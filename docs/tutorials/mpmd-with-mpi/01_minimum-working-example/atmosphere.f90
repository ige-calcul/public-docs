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
