using Mux
using Interact
using Plots
using Dispersal

init =  [0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0;
         0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0;
         0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0;
         0.0 0.0 0.0 0.0 81. 0.0 0.0 0.0;
         0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0;
         0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0;
         0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0;
         0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0]

struct TestFormulation <: KernelFormulation end
(f::TestFormulation)(d) = 1.0

hood = DispersalKernel{1}(; formulation=TestFormulation())
ruleset = Ruleset(InwardsDispersal(;neighborhood=hood))
tspan = 1:1:10
output = ArrayOutput(init; tspan=tspan, store=true)
sim!(output, ruleset)

mp = @manipulate for t in slider(tspan; value = minimum(tspan), label="Time")
    Plots.heatmap(
        output[t],
        c = cgrad(:roma),
        clims=(0.0, 100.0),
        title="Time $t"
    )
end

# WebIO.webio_serve(page("/", req -> mp),8095) # serve on a random port
@app test = (
    Mux.defaults,
    Mux.page("/", req -> mp),
    Mux.notfound())

# serve(test, 8096)
fetch(serve(test,parse(Int,ARGS[1])))