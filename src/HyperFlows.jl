module HyperFlows


# We need a function where input ranges from 0 to 1, and output is an x and y coordinate, which we can integrate over

struct LimFunc{A<:Real,B}
    startx::A
    endx::A
    func::B
end



function geomConstructor(LimFuncs::LimFunc...)
    totalLength = sum(map(x -> abs(x.startx-x.endx), LimFuncs ))
    return function(t)
        t = t*totalLength
        runningTotal = 0
        for func in LimFuncs
            runningTotal = runningTotal + abs(func.startx - func.endx)
            if t < runningTotal
                x = func.startx + (t - runningTotal + abs(func.startx - func.endx )) / (func.endx-func.startx)
                return x
            end
        end
    end#returns funtion that maps a value t to x and y values
end



end # module


# scratch code
first = LimFunc(2,3,x->x-1)
second = LimFunc(3,2,x->-2*x+8)
third = LimFunc(2,1,x->2*x)
forth = LimFunc(1,2,x->-x+3)

g = geomConstructor(first, second, third, forth)
g(0.74)
