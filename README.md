# RFFT.jl

This is a fork of https://github.com/HolyLab/RFFT.jl with a new UUID such that it can be registered on the General registry.

----

In-place real FFTs for Julia

For example
```julia
import RFFT

a = rand(Float64, 100, 150)

# initialize a buffer 'RCpair' that contains a real and complex space
buf = RFFT.RCpair{Float64}(undef, size(a))

# create the plan
plan = RFFT.plan_rfft!(buf; flags=FFTW.MEASURE)

# use the plan and buffer on a new array
new = rand(Float64, 100, 150)
copy!(buf, new)
new_fft = plan(buf)

```
