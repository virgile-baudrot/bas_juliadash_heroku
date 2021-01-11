# using Dash
# using DashHtmlComponents
# using DashCoreComponents
# using HTTP

# app = dash(external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"])

# app.layout = html_div() do
#     html_h1("Hello Dash"),
#     html_div("Dash.jl: Julia interface for Dash"),
#     dcc_graph(
#         id = "example-graph",
#         figure = (
#             data = [
#                 (x = [1, 2, 3], y = [4, 1, 2], type = "bar", name = "SF"),
#                 (x = [1, 2, 3], y = [2, 4, 5], type = "bar", name = "Montréal"),
#             ],
#             layout = (title = "Dash Data Visualization",)
#         )
#     )
# end

# # then go to localhost
# # run_server(app, "0.0.0.0", 8080)
# # println("started at localhost:$(parse(Int, ARGS[1]))")
# # run_server(app, "0.0.0.0", parse(Int,ARGS[1]))
# # HTTP.serve(app, "0.0.0.0", 8080)
# handler = make_handler(app, debug = true)
# println("started at localhost:$(parse(Int, ARGS[1]))")
# HTTP.serve(handler,"0.0.0.0",parse(Int,ARGS[1]))

using Mux

@app test = (
  Mux.defaults,
  page(respond("<h1>Hello JuliaCon!</h1>")),
  page("/about",
       probabilty(0.1, respond("<h1>Boo!</h1>")),
       respond("<h1>About Me</h1>")),
  page("/user/:user", req -> "<h1>Hello, $(req[:params][:user])!</h1>"),
  Mux.notfound())

fetch(serve(test,parse(Int,ARGS[1])))