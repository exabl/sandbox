function det_by_lu(y, x, N)
    y[1] = 1.

    for k = 1:N
        y[1] *= x[k,k]
        for i = k+1:N
            x[i,k] /= x[k,k]
	    end
        for j = k+1:N
            for i = k+1:N
                x[i,j] -= x[i,k] * x[k,j]
            end
        end
    end
end

nb_loops = []

function run_julia(y,A,B,N)
    loops = max(10000000 // (N*N), 1)
    append!(nb_loops, loops)
    print(loops, '\n')
    for l in 1:loops
        B[:,:] = A
        det_by_lu(y, B, N)
    end
end

y = [0.0]

times = []

N=5
A = rand(N,N)
B = zeros(N,N)
# Warm up
@time run_julia(y,A,B,N)

N=5
A = rand(N,N)
B = zeros(N,N)
append!(times, @elapsed run_julia(y,A,B,N))
N=10
A = rand(N,N)
B = zeros(N,N)
append!(times, @elapsed run_julia(y,A,B,N))
N=30
A = rand(N,N)
B = zeros(N,N)
append!(times, @elapsed run_julia(y,A,B,N))
N=100
A = rand(N,N)
B = zeros(N,N)
append!(times, @elapsed run_julia(y,A,B,N))
N=200
A = rand(N,N)
B = zeros(N,N)
append!(times, @elapsed run_julia(y,A,B,N))
N=300
A = rand(N,N)
B = zeros(N,N)
append!(times, @elapsed run_julia(y,A,B,N))
N=400
A = rand(N,N)
B = zeros(N,N)
append!(times, @elapsed run_julia(y,A,B,N))
N=600
A = rand(N,N)
B = zeros(N,N)
append!(times, @elapsed run_julia(y,A,B,N))
N=1000
A = rand(N,N)
B = zeros(N,N)
append!(times, @elapsed run_julia(y,A,B,N))

print("\ntime per loop=\n", times ./ nb_loops[2:end])
# [5, 10, 30, 100, 200, 300, 400, 600, 1000])