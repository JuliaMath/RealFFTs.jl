import RealFFTs
using Test, FFTW, LinearAlgebra

@testset "RealFFTs.jl" begin
    for dims in (1:2, 1, 2)
        for sz in ((5,6), (6,5))
            pair = RealFFTs.RCpair{Float64}(undef, sz, dims)
            r = @inferred(real(pair))
            c = @inferred(complex(pair))
            b = rand(eltype(r), size(r))
            pair = RealFFTs.RCpair(b, dims)
            copyto!(r, b)
            copy!(pair, c) # for coverage
            RealFFTs.rfft!(pair)
            RealFFTs.irfft!(pair)
            @test r ≈ b
            pfwd = RealFFTs.plan_rfft!(pair)
            pinv = RealFFTs.plan_irfft!(pair)
            pinv(pfwd(pair))
            @test r ≈ b

            pair2 = copy(pair)
            @test real(pair2) == real(pair)
            @test complex(pair2) == complex(pair)
        end
    end
end
